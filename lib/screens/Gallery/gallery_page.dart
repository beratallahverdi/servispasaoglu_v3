import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:photo_view/photo_view.dart';
import 'package:path_provider/path_provider.dart';
import 'package:servispasaoglu_v3/utils/constants.dart';
import 'package:servispasaoglu_v3/utils/functions.dart';

class GalleryPage extends StatelessWidget {
  static const String routeName = '/pages/gallery';
  const GalleryPage({Key? key, required this.image}) : super(key: key);
  final ImageProvider image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ServisPasaogluConstants.scaffoldMessengerKey,
      appBar: AppBar(
        title:
            Text("Image", style: Theme.of(context).appBarTheme.titleTextStyle),
        leading: ServisPasaogluFunctions.leadingBackButton(context),
        actions: [
          IconButton(
            onPressed: () async {
              String dir = (await getApplicationDocumentsDirectory()).path;
              File file = File("$dir/share.png");
              image.resolve(const ImageConfiguration()).addListener(
                  ImageStreamListener(
                      (ImageInfo im, bool synchronousCall) async {
                file.writeAsBytesSync(
                    (await im.image.toByteData(format: ImageByteFormat.png))!
                        .buffer
                        .asUint8List());
              }));
            },
            icon: Icon(Platform.isIOS ? Icons.ios_share : Icons.share),
          )
        ],
      ),
      body: PhotoView(
        imageProvider: image,
        initialScale: PhotoViewComputedScale.contained * 1,
        minScale: PhotoViewComputedScale.contained * 0.8,
        maxScale: PhotoViewComputedScale.contained * 2,
      ),
    );
  }
}
