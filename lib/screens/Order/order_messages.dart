import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:servispasaoglu_v3/api/order.dart';
import 'package:servispasaoglu_v3/classes/logged_user.dart';
import 'package:servispasaoglu_v3/classes/message.dart';
import 'package:servispasaoglu_v3/classes/order.dart';
import 'package:servispasaoglu_v3/screens/Order/message_bubble.dart';
import 'package:servispasaoglu_v3/generated/l10n.dart';
import 'package:servispasaoglu_v3/main.dart';

// For the testing purposes, you should probably use https://pub.dev/packages/uuid
String randomString() {
  var random = Random.secure();
  var values = List<int>.generate(16, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}

class OrderMessages extends StatefulWidget {
  final ServisPasaogluUser user;
  Order? order;
  final ScrollController? scrollController;
  final bool isSending;
  final void Function()? onPhotoChoose;
  final void Function()? onGalleryFileChoose;
  final void Function()? onVideoChoose;
  final void Function()? onFileChoose;
  final void Function(String)? onSendMessage;
  OrderMessages(
      {Key? key,
      this.order,
      required this.user,
      required this.isSending,
      required this.scrollController,
      required this.onGalleryFileChoose,
      required this.onPhotoChoose,
      required this.onVideoChoose,
      required this.onFileChoose,
      required this.onSendMessage})
      : super(key: key);
  @override
  State<OrderMessages> createState() => _OrderMessagesState();
}

class _OrderMessagesState extends State<OrderMessages> {
  bool _isRecording = false;
  final TextEditingController _textController = TextEditingController();
  final AudioPlayer _audioPlayer = AudioPlayer();
  final _audioRecorder = Record();
  bool showUser = true;
  bool showDate = true;
  bool _isMicrophoneGranted = true;
  int lastUserId = -2;
  int duration = 0;
  String textInput = "";

  @override
  void initState() {
    super.initState();
  }

  void getOrder() async {
    OrdersAPI.get(widget.order!).then((value) => setState(() {
          widget.order = value.order;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        Flexible(
            child: Stack(children: [
          Center(
            child: DecoratedBox(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  scale: 0.3,
                  image: ExactAssetImage('assets/images/pasaoglu.png'),
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                child: Container(
                  decoration:
                      BoxDecoration(color: Colors.white.withOpacity(0.0)),
                ),
              ),
            ),
          ),
          ListView(
              scrollDirection: Axis.vertical,
              controller: widget.scrollController,
              reverse: true,
              padding: const EdgeInsets.all(8),
              children: widget.order!.messages!
                  .asMap()
                  .keys
                  .map((e) => _buildMessages(context, e))
                  .toList()),
        ])),
        _buildiOSMessageArea(context),
      ],
    ));
  }

  Widget _buildMessages(BuildContext context, int index) {
    int messagesLength = widget.order!.messages!.length;
    Message message = widget.order!.messages![messagesLength - index - 1];
    if (messagesLength - 1 == messagesLength - index - 1) {
      lastUserId = message.userId!;
      showDate = true;
    } else if (messagesLength - index < messagesLength &&
        message.userId !=
            widget.order!.messages![messagesLength - index].userId) {
      showDate = true;
    } else {
      showDate = false;
    }
    if (messagesLength - index - 1 == 0) {
      showUser = true;
    } else if (messagesLength - index - 1 > 0 &&
        message.userId !=
            widget.order!.messages![messagesLength - index - 2].userId) {
      showUser = true;
    } else {
      showUser = false;
    }
    /*
    if (index + 1 < messagesLength &&
        widget.order!.messages![index + 1].userId != message.userId) {
      showDate = true;
    } else if (index + 1 == messagesLength) {
      showDate = true;
    } else {
      showDate = false;
    }
    if ((messagesLength - index - 1 > 0 &&
            widget.order!.messages![messagesLength - index - 1].userId !=
                message.userId) ||
        messagesLength - index - 1 == 0) {
      showDate = true;
    } else {
      showDate = false;
    }
    */

    if ((message.file == "" || message.file == null) &&
        message.text!.isNotEmpty) {
      return Container(
        padding: (showUser)
            ? const EdgeInsets.only(top: 8, bottom: 1)
            : const EdgeInsets.symmetric(vertical: 1),
        width: MediaQuery.of(context).size.width * 0.6,
        child: MessageBubble(
            showUser: showUser,
            showDate: showDate,
            message: message,
            isSent: widget.user.userId == message.userId,
            isAccessingUser: widget.order!.userList!.contains(message.userId),
            isAdmin: widget.user.isAdmin == 1,
            messageType: MessageBubble.text),
      );
    } else if (message.file != null && message.mimeType!.startsWith('image')) {
      return Container(
          padding: (showUser)
              ? const EdgeInsets.only(top: 8, bottom: 1)
              : const EdgeInsets.symmetric(vertical: 1),
          child: MessageBubble(
              showUser: showUser,
              message: message,
              showDate: showDate,
              isSent: widget.user.userId == message.userId,
              messageType: MessageBubble.image));
    } else if (message.file != null && message.mimeType!.startsWith('video')) {
      return Container(
        padding: (showUser)
            ? const EdgeInsets.only(top: 8, bottom: 1)
            : const EdgeInsets.symmetric(vertical: 1),
        width: MediaQuery.of(context).size.width * 0.6,
        child: MessageBubble(
            showUser: showUser,
            showDate: showDate,
            message: message,
            isSent: widget.user.userId == message.userId,
            messageType: MessageBubble.video),
      );
    } else if (message.file != null && message.mimeType!.startsWith('audio')) {
      return Container(
        padding: (showUser)
            ? const EdgeInsets.only(top: 8, bottom: 1)
            : const EdgeInsets.symmetric(vertical: 1),
        width: MediaQuery.of(context).size.width * 0.7,
        child: MessageBubble(
          showUser: showUser,
          showDate: showDate,
          message: message,
          isSent: widget.user.userId == message.userId,
          messageType: MessageBubble.audio,
          audioPlayer: _audioPlayer,
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(8),
        ),
        padding: (showUser)
            ? const EdgeInsets.only(top: 8, bottom: 1)
            : const EdgeInsets.symmetric(vertical: 1),
        width: MediaQuery.of(context).size.width * 0.6,
        child: MessageBubble(
            showUser: showUser,
            showDate: showDate,
            message: message,
            isSent: widget.user.userId == message.userId,
            isAccessingUser: widget.order!.userList!.contains(message.userId),
            isAdmin: widget.user.isAdmin == 1,
            messageType: MessageBubble.file),
      );
    }
  }

  Widget _buildiOSMessageArea(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            (_textController.text.isNotEmpty)
                ? Container()
                : ClipOval(
                    child: Material(
                      color: _isRecording
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).primaryColor,
                      child: InkWell(
                        onTap: _handleAttachmentiOSPressed,
                        child: const SizedBox(
                          width: 40,
                          height: 40,
                          child: Icon(Icons.add),
                        ),
                      ),
                    ),
                  ),
            Flexible(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: TextField(
                    maxLines: 3,
                    textInputAction: TextInputAction.newline,
                    minLines: 1,
                    cursorColor: Colors.black,
                    controller: _textController,
                    onChanged: (value) => setState(() {
                      textInput = value;
                    }),
                    onSubmitted: (String val) {
                      widget.onSendMessage!(val);
                      _textController.clear();
                    },
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      isDense: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                      hintText: 'Type a message',
                    ),
                  )),
            ),
            (_textController.text.isNotEmpty)
                ? ClipOval(
                    child: Material(
                      color: _isRecording
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).primaryColor,
                      child: InkWell(
                        child: const SizedBox(
                          width: 40,
                          height: 40,
                          child: Icon(Icons.send),
                        ),
                        onTap: () async {
                          widget.onSendMessage!(_textController.text);
                          _textController.clear();
                        },
                      ),
                    ),
                  )
                : ClipOval(
                    child: Material(
                      color: _isRecording
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).primaryColor,
                      child: GestureDetector(
                        child: SizedBox(
                          width: _isRecording ? 72 : 40,
                          height: _isRecording ? 72 : 40,
                          child: _isMicrophoneGranted
                              ? (_isRecording
                                  ? const Icon(Icons.stop,
                                      color: Colors.red, size: 56)
                                  : Icon(Icons.mic,
                                      color: Theme.of(context).iconTheme.color,
                                      size: 24))
                              : const Icon(Icons.mic_off, color: Colors.red),
                        ),
                        onTapDown: (details) async {
                          if (await Permission.microphone.status.isDenied) {
                            Permission.microphone.request().then((value) {
                              if (value == PermissionStatus.granted) {
                                setState(() {
                                  _isMicrophoneGranted = true;
                                });
                              } else {
                                setState(() {
                                  _isMicrophoneGranted = false;
                                });
                              }
                            });
                            return;
                          }
                          Permission.microphone.isGranted.then((ok) {
                            if (ok && !_isRecording) {
                              setState(() {
                                _isRecording = !_isRecording;
                                _start();
                              });
                            }
                          });
                        },
                        onTapUp: (details) =>
                            Permission.microphone.isGranted.then((ok) {
                          if (ok && _isRecording) {
                            setState(() {
                              _isRecording = !_isRecording;
                              _stop();
                            });
                          }
                        }),
                      ),
                    ),
                  )
          ],
        ));
  }

  Future<void> _start() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        await _audioRecorder.start();

        bool isRecord = await _audioRecorder.isRecording();
        setState(() {
          _isRecording = isRecord;
        });
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Future<void> _stop() async {
    final path = await _audioRecorder.stop();

    setState(() => _isRecording = false);
    OrdersAPI.sendMessage(widget.order!, microphone: path);
  }

  void _handleAttachmentiOSPressed() {
    showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      isDismissible: true,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
            height: MediaQuery.of(context).size.height * 0.64,
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                        width: double.maxFinite,
                        padding: const EdgeInsets.all(16),
                        child: TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(S.of(context).actions,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  )),
                        )),
                    Positioned(
                        top: 16,
                        left: 16,
                        child: InkWell(
                          splashColor: HexColor.fromHex(widget
                              .order!.orderStatus!.chartColor!
                              .replaceAll("#", "#FF")),
                          child: IconButton(
                              splashColor: HexColor.fromHex(widget
                                  .order!.orderStatus!.chartColor!
                                  .replaceAll("#", "#FF")),
                              icon: Platform.isIOS
                                  ? const Icon(
                                      CupertinoIcons.clear,
                                      size: 32,
                                    )
                                  : const Icon(
                                      Icons.clear,
                                      size: 32,
                                    ),
                              onPressed: () => Navigator.of(context).pop()),
                        )),
                  ],
                ),
                ListTile(
                  leading: const Icon(Icons.camera_alt, size: 32),
                  title: const Text('Camera'),
                  subtitle: const Text('Capture from Camera'),
                  onTap: () {
                    Navigator.of(context).pop();
                    widget.onPhotoChoose!();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library, size: 32),
                  title: const Text('Gallery'),
                  subtitle: const Text('Choose from gallery'),
                  onTap: () {
                    Navigator.of(context).pop();
                    widget.onGalleryFileChoose!();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.video_library, size: 32),
                  title: const Text('Video'),
                  subtitle: const Text('Capture from Camera'),
                  onTap: () {
                    Navigator.of(context).pop();
                    widget.onVideoChoose!();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.file_present, size: 32),
                  title: const Text('File'),
                  subtitle: const Text('Choose from files'),
                  onTap: () {
                    Navigator.of(context).pop();
                    widget.onFileChoose!();
                  },
                ),
              ],
            ));
      },
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    _audioRecorder.dispose();
    super.dispose();
  }
}
