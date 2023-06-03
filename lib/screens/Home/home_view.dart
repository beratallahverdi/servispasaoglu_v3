import 'package:flutter/material.dart';
import 'package:servispasaoglu_v3/screens/routes.dart';
import 'package:servispasaoglu_v3/utils/data.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(children: [
          const Text(
            "Gallery",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
              height: 225,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: ServisPasaogluData.gallery.length,
                  itemBuilder: ((context, index) {
                    Widget image = Image.asset(
                      ServisPasaogluData.gallery[index],
                    );
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: GestureDetector(
                            child: image,
                            onTap: () => Navigator.of(context).pushNamed(
                                Routes.galleryPage,
                                arguments: {image: image})),
                      ),
                    );
                  }))),
          Card(
              child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Hakkımızda",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "         ${ServisPasaogluData.info["companyAbout"]}",
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Misyonumuz",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "         ${ServisPasaogluData.info["companyMissionText"]}",
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Vizyonumuz",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "         ${ServisPasaogluData.info["companyVisionText"]}",
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ))),
          Card(
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Chip Tuning & Mekanik Servis",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "         ${ServisPasaogluData.home["pageHeader"]}",
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ]))),
        ]));
  }
}

class GlobalVariable {}
