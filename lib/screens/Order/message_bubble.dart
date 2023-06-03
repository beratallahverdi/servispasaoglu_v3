import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:bubble/bubble.dart';
import 'package:chat_bubbles/bubbles/bubble_normal_audio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:servispasaoglu_v3/api/users.dart';
import 'package:servispasaoglu_v3/classes/message.dart';
import 'package:servispasaoglu_v3/screens/Gallery/gallery_page.dart';
import 'package:servispasaoglu_v3/screens/Gallery/video_page.dart';
import 'package:servispasaoglu_v3/utils/constants.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:servispasaoglu_v3/generated/l10n.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

// ignore: must_be_immutable
class MessageBubble extends StatefulWidget {
  static const int text = 0;
  static const int image = 1;
  static const int video = 2;
  static const int audio = 3;
  static const int file = 4;
  static const int sending = 5;

  bool isSent;
  int messageType;
  final Message message;
  final bool showUser;
  final bool showDate;
  final bool isAdmin;
  final bool isAccessingUser;
  AudioPlayer? audioPlayer;
  void Function()? onPlayPause;
  MessageBubble({
    Key? key,
    required this.isSent,
    required this.showUser,
    required this.showDate,
    required this.messageType,
    required this.message,
    this.onPlayPause,
    this.isAdmin = false,
    this.isAccessingUser = true,
    this.audioPlayer,
  }) : super(key: key);

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  String _playingUri = "";
  bool isVideoThumbnailLoaded = false;
  String? videoFilePath = "";
  void _onPlayPauseButtonClick() {
    String uri = Uri.https(ServisPasaogluConstants.baseUrl,
            "/orders/${widget.message.orderId}/${widget.message.file}")
        .toString();
    if (uri.compareTo(_playingUri) == 0) {
      if (widget.audioPlayer?.state == PlayerState.playing) {
        widget.audioPlayer?.pause();
      } else if (widget.audioPlayer?.state == PlayerState.paused) {
        widget.audioPlayer?.resume();
      } else if (widget.audioPlayer?.state == PlayerState.completed) {
        setState(() {
          _playingUri = "";
        });
        widget.audioPlayer?.play(UrlSource(uri));
      }
    } else {
      widget.audioPlayer?.stop();
      if (widget.audioPlayer?.state == PlayerState.playing) {
        widget.audioPlayer?.pause();
      } else if (widget.audioPlayer?.state == PlayerState.paused) {
        widget.audioPlayer?.resume();
      } else if (widget.audioPlayer?.state == PlayerState.stopped) {
        widget.audioPlayer?.setSource(UrlSource(uri));
        setState(() {
          _playingUri = uri;
        });
        widget.audioPlayer?.setSource(UrlSource(uri));
      } else if (widget.audioPlayer?.state == PlayerState.completed) {
        setState(() {
          _playingUri = "";
        });
        widget.audioPlayer?.play(UrlSource(uri));
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime date =
        DateTime.parse(widget.message.createdAt!).add(const Duration(hours: 3));
    return Container(
        padding: (widget.showUser)
            ? const EdgeInsets.only(top: 10)
            : const EdgeInsets.only(top: 0),
        child: Column(children: [
          (widget.showUser)
              ? SizedBox(
                  width: 400,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 0),
                      alignment: widget.isSent
                          ? Alignment.bottomRight
                          : Alignment.bottomLeft,
                    ),
                    onPressed: () async => {
                      if (widget.isAdmin && !widget.isAccessingUser)
                        showDialog<void>(
                          context: context,
                          barrierDismissible: false, // user must tap button!
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Erişim Talebi'),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    Text(
                                        "${widget.message.user!.firstName} ${widget.message.user!.lastName} kullanıcının erişim talebini onaylıyor musunuz?"),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Hayır',
                                      style: TextStyle(color: Colors.black)),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green),
                                  onPressed: () {
                                    UsersAPI.sendAccessByOrderId(
                                            widget.message.user!,
                                            widget.message.orderId!)
                                        .then((value) =>
                                            Navigator.of(context).pop());
                                  },
                                  child: const Text('Evet'),
                                ),
                              ],
                            );
                          },
                        )
                    },
                    child: Text(
                      "${widget.message.user!.firstName} ${widget.message.user!.lastName}",
                    ),
                  ),
                )
              : Container(),
          widget.messageType == MessageBubble.audio
              ? _getMessageContent(context)
              : Bubble(
                  margin: BubbleEdges.only(
                    top: (widget.showUser) ? 5 : 0,
                    left: widget.isSent ? 50 : 0,
                    right: widget.isSent ? 0 : 50,
                  ),
                  padding: const BubbleEdges.all(8),
                  alignment:
                      widget.isSent ? Alignment.topRight : Alignment.topLeft,
                  nip: (!widget.showUser)
                      ? BubbleNip.no
                      : widget.isSent
                          ? BubbleNip.rightTop
                          : BubbleNip.leftTop,
                  color: widget.isSent
                      ? Theme.of(context).colorScheme.primaryContainer
                      : Theme.of(context).colorScheme.secondaryContainer,
                  child: Column(
                    crossAxisAlignment: widget.isSent
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [_getMessageContent(context)],
                  )),
          (widget.showDate)
              ? Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.025),
                  child: Text(
                    DateFormat('d MMM y HH:mm ').format(date).toString(),
                    textAlign: widget.isSent ? TextAlign.end : TextAlign.start,
                  ),
                )
              : Container(),
        ]));
  }

  Widget _getMessageContent(BuildContext context) {
    switch (widget.messageType) {
      case MessageBubble.text:
        return SizedBox(
            child: Text(
          "${widget.message.text}",
          textAlign: widget.isSent ? TextAlign.end : TextAlign.start,
          style: TextStyle(
              fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize!,
              color: widget.isSent
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).colorScheme.onSecondary),
        ));
      case MessageBubble.image:
        return InteractiveViewer(
            child: CachedNetworkImage(
          imageUrl: Uri.https(ServisPasaogluConstants.baseUrl,
                  "/orders/${widget.message.orderId}/${widget.message.file}")
              .toString(),
          placeholder: (context, url) => const SizedBox(
              height: 200,
              width: 200,
              child: Center(
                child: CircularProgressIndicator(),
              )),
          errorWidget: (context, url, error) {
            return const Icon(Icons.error);
          },
          fit: BoxFit.fitHeight,
          imageBuilder: (context, imageProvider) {
            double? width;
            double? height;
            imageProvider.resolve(const ImageConfiguration()).addListener(
              ImageStreamListener(
                (ImageInfo image, bool synchronousCall) {
                  width = image.image.width.toDouble();
                  height = image.image.height.toDouble();
                },
              ),
            );
            return InkWell(
              child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: AspectRatio(
                      aspectRatio: (width! / height!),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(8),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ))),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => GalleryPage(
                    image: imageProvider,
                  ),
                ),
              ),
            );
          },
        ));
      case MessageBubble.audio:
        return BubbleNormalAudio(
          bubbleRadius: 12,
          isPlaying: widget.audioPlayer?.state == PlayerState.playing,
          isPause: widget.audioPlayer?.state == PlayerState.paused &&
              _playingUri.compareTo("") != 0,
          color: widget.isSent
              ? Theme.of(context).colorScheme.primaryContainer.withOpacity(0.8)
              : Theme.of(context)
                  .colorScheme
                  .secondaryContainer
                  .withOpacity(0.8),
          onSeekChanged: (_) {},
          onPlayPauseButtonClick: _onPlayPauseButtonClick,
        );
      case MessageBubble.video:
        final Future<String?> fileName =
            _videoThumbnail(widget.message.orderId!, widget.message.file!);
        return FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(8),
                        image: DecorationImage(
                          image: FileImage(File(videoFilePath as String)),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.play_arrow, size: 64),
                        onPressed: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => VideoPage(
                            videoUrl: Uri.https(ServisPasaogluConstants.baseUrl,
                                    "/orders/${widget.message.orderId}/${widget.message.file}")
                                .toString(),
                          ),
                        )),
                      ),
                    ));
              } else {
                return const SizedBox(
                    height: 200,
                    width: 200,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ));
              }
            },
            future: fileName);
      case MessageBubble.file:
        return SizedBox(
            child: TextButton(
          child: Text(
            widget.message.file!,
            style: TextStyle(
                fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize!,
                color: widget.isSent
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).colorScheme.onSecondary),
          ),
          onPressed: () {
            widget.message.download().then((file) {
              try {
                OpenFile.open(file.path);
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Theme.of(context).colorScheme.error,
                  content: Text(S.of(context).fileNotFound,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onError)),
                ));
              }
            });
          },
        ));
      case MessageBubble.sending:
        return const SizedBox(
            height: 200,
            width: 200,
            child: Center(
              child: CircularProgressIndicator(),
            ));
      default:
        return Container();
    }
  }

  Future<String?> _videoThumbnail(int orderId, String file) async {
    if (isVideoThumbnailLoaded == false) {
      return VideoThumbnail.thumbnailFile(
        video:
            Uri.https(ServisPasaogluConstants.baseUrl, "/orders/$orderId/$file")
                .toString(),
        thumbnailPath: (await getTemporaryDirectory()).path,
        imageFormat: ImageFormat.WEBP,
        maxHeight:
            512, // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
        quality: 75,
      ).then((value) {
        setState(() {
          isVideoThumbnailLoaded = true;
          videoFilePath = value;
        });
        return value;
      });
    } else {
      return videoFilePath;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
