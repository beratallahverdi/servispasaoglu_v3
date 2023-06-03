import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_luban/flutter_luban.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:servispasaoglu_v3/api/login.dart';
import 'package:servispasaoglu_v3/api/order.dart';
import 'package:servispasaoglu_v3/classes/logged_user.dart';
import 'package:servispasaoglu_v3/classes/order.dart';
import 'package:servispasaoglu_v3/screens/Order/order_details.dart';
import 'package:servispasaoglu_v3/screens/Order/order_edit.dart';
import 'package:servispasaoglu_v3/screens/Order/order_messages.dart';
import 'package:servispasaoglu_v3/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_compress/video_compress.dart';

// ignore: must_be_immutable
class OrderPage extends StatefulWidget {
  static const String routeName = "/order";
  ServisPasaogluUser? user;
  Order? order;
  int? orderId;
  OrderPage(this.user, {Key? key, this.order, this.orderId}) : super(key: key);
  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with TickerProviderStateMixin {
  TabController? _tabController;
  final ScrollController _scrollController = ScrollController();
  Timer? t;
  bool _isReloading = false;
  bool _showEditIcon = true;
  bool _isSending = false;
  bool isEdit = false;
  int _tabIndex = 0;
  @override
  void initState() {
    super.initState();
    if (widget.order == null && widget.orderId != null ||
        widget.order!.messages == null) {
      OrdersAPI.get(Order(orderId: widget.orderId))
          .then((value) => setState(() {
                widget.order = value.order;
              }));
    }
    if (widget.user == null) {
      SharedPreferences.getInstance().then((prefs) {
        if (prefs.containsKey("Authorization")) {
          LoginAPI.get(prefs.getString("Authorization")!)
              .then((value) => (value.data[0] as ServisPasaogluUser))
              .then((value) {
            setState(() {
              widget.user = value;
            });
            return value;
          }).then((value) =>
                  prefs.setString("user", widget.user!.toJson().toString()));
        }
      });
    }
    _tabController = TabController(length: 2, vsync: this);
    _tabController?.addListener(() => setState(() {
          _tabIndex = _tabController!.index;
          _showEditIcon = (_tabIndex == 0) ? true : false;
        }));
    t = Timer.periodic(const Duration(seconds: 10), _reload);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _tabController?.dispose();
    t?.cancel();
    super.dispose();
  }

  void _reload(Timer ti) {
    if (_isReloading == false &&
        _isSending == false &&
        ti.isActive &&
        _tabIndex == 1) {
      setState(() {
        _isReloading = true;
      });
      OrdersAPI.get(widget.order!).then((value) => {
            setState(() {
              widget.order = value.order!;
              _isReloading = false;
            })
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.order != null ? widget.order!.getOrderTitle() : ""),
        actions: (_showEditIcon)
            ? [
                IconButton(
                  icon: (!isEdit)
                      ? const Icon(Icons.edit)
                      : const Icon(Icons.check),
                  onPressed: () {
                    if (isEdit) {
                      showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                title: const Text('AlertDialog Title'),
                                content: const Text('AlertDialog description'),
                                actions: <Widget>[
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                    ),
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: const Text('Cancel'),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                    ),
                                    onPressed: () async {
                                      widget.order!.save();
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              ));
                    } else {
                      setState(() {
                        isEdit = !isEdit;
                      });
                    }
                  },
                ),
              ]
            : [],
      ),
      body: TabBarView(
          controller: _tabController,
          children: (widget.order != null && widget.user != null)
              ? <Widget>[
                  (!isEdit)
                      ? OrderDetails(order: widget.order!, user: widget.user!)
                      : OrderEdit(widget.order!, widget.user!),
                  Stack(
                    children: [
                      OrderMessages(
                        order: widget.order,
                        user: widget.user!,
                        isSending: _isSending,
                        scrollController: _scrollController,
                        onFileChoose: _handleFilePick,
                        onPhotoChoose: _handleCameraPick,
                        onVideoChoose: _handleVideoPick,
                        onGalleryFileChoose: _handlePickGallery,
                        onSendMessage: _handleSendMessage,
                      ),
                      (_isSending)
                          ? Positioned.fill(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 5.0,
                                  sigmaY: 5.0,
                                ),
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            )
                          : Container()
                    ],
                  )
                ]
              : <Widget>[
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                ]),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _tabIndex,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: const Icon(Icons.directions_car),
              label: S.of(context).detailsViewBottomBarText,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.message),
              label: S.of(context).messagesViewBottomBarText,
            ),
          ],
          selectedItemColor: Colors.amber[800],
          onTap: (index) {
            _tabController!.animateTo(index);
          }),
    );
  }

  void _handleSendMessage(String message) {
    OrdersAPI.sendMessage(widget.order!, text: message)
        .then((response) => setState(() {
              widget.order = response.order!;
            }))
        .catchError((onError) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(onError.toString())));
    });
  }

  void _handlePickGallery() async {
    PermissionStatus status = await Permission.storage.status;
    if (status == PermissionStatus.granted) {
      FilePicker.platform
          .pickFiles(type: FileType.media, allowMultiple: true)
          .then((files) {
            if (files!.count > 0) {
              setState(() {
                _isSending = true;
              });

              return OrdersAPI.sendMessage(Order(orderId: widget.orderId!),
                  files: files);
            } else {
              throw ("No file selected");
            }
          })
          .catchError((onError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(onError.toString())));
          })
          .then((response) => setState(() {
                _isSending = false;
                widget.order = response.order!;
              }))
          .catchError((onError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(onError.toString())));
          });
    } else {
      PermissionStatus status = await Permission.storage.request();
      if (status.isGranted) {
        _handlePickGallery();
      }
    }
  }

  void _handleCameraPick() {
    ImagePicker()
        .pickImage(
          source: ImageSource.camera,
          maxHeight: 2048,
          maxWidth: 2048,
          imageQuality: 80,
        )
        .then((photo) {
          setState(() {
            _isSending = true;
          });
          return OrdersAPI.sendMessage(widget.order!, photo: photo);
        })
        .catchError((onError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(onError.toString())));
        })
        .then((response) => setState(() {
              _isSending = false;
              widget.order = response.order!;
            }))
        .catchError((onError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(onError.toString())));
        });
  }

  void _handleVideoPick() {
    ImagePicker()
        .pickVideo(source: ImageSource.camera)
        .then((photo) {
          if (photo != null) {
            setState(() {
              _isSending = true;
            });
            return OrdersAPI.sendMessage(widget.order!, photo: photo);
          } else {
            throw ("No file selected");
          }
        })
        .catchError((onError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(onError.toString())));
        })
        .then((response) => setState(() {
              _isSending = false;
              widget.order = response.order!;
            }))
        .catchError((onError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(onError.toString())));
        });
  }

  void _handleFilePick() async {
    PermissionStatus status = await Permission.storage.status;
    if (status == PermissionStatus.granted) {
      FilePicker.platform
          .pickFiles(type: FileType.custom, allowedExtensions: ["pdf"])
          .then((files) {
            if (files!.count > 0) {
              setState(() {
                _isSending = true;
              });
              return OrdersAPI.sendMessage(Order(orderId: widget.orderId!),
                  files: files);
            } else {
              throw ("No file selected");
            }
          })
          .catchError((onError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(onError.toString())));
          })
          .then((response) => setState(() {
                _isSending = false;
                widget.order = response.order!;
              }))
          .catchError((onError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(onError.toString())));
          });
    } else {
      PermissionStatus status = await Permission.storage.request();
      if (status.isGranted) {
        _handlePickGallery();
      }
    }
  }

  Future<PlatformFile> compressGalleryFile(PlatformFile file) async {
    String filename = file.name;
    if (['mp4', 'mkv', 'mov', 'mpeg4', 'flv', 'avi']
        .contains(filename.split('.').last)) {
      File compressedFile = await VideoCompress.compressVideo(
        file.path!,
        quality: VideoQuality.Res1280x720Quality,
        deleteOrigin: false, // It's false by default
      ).then((value) => File(value!.path!));
      return PlatformFile(
          path: compressedFile.path,
          name: filename,
          size: compressedFile.lengthSync());
    } else {
      var temporaryDirectory = await getTemporaryDirectory();
      CompressObject compressObject = CompressObject(
        imageFile: File(file.path!), //image
        path: temporaryDirectory.path, //compress to path
        quality: 85, //first compress quality, default 80
        step:
            7, //compress quality step, The bigger the fast, Smaller is more accurate, default 6
      );
      return Luban.compressImage(compressObject).then((path) {
        File nFile = File(path!);
        return PlatformFile(
            name: filename, size: nFile.lengthSync(), path: nFile.path);
      });
    }
  }
}
