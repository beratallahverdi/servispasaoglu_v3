import 'package:flutter/material.dart';
import 'package:servispasaoglu_v3/screens/Gallery/gallery_page.dart';
import 'package:servispasaoglu_v3/utils/data.dart';

class GalleryView extends StatelessWidget {
  const GalleryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: ServisPasaogluData.gallery.length,
          itemBuilder: ((context, index) {
            Widget image = Image.asset(
              ServisPasaogluData.gallery[index],
            );
            var imageAsset = AssetImage(ServisPasaogluData.gallery[index]);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                  child: GestureDetector(
                child: image,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => GalleryPage(image: imageAsset)),
                  );
                },
              )),
            );
          })),
    );
  }
}
