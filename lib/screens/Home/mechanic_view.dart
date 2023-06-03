import 'package:flutter/material.dart';
import 'package:servispasaoglu_v3/utils/data.dart';

class MechanicView extends StatelessWidget {
  const MechanicView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView(children: [
          const Padding(padding: EdgeInsets.all(8.0)),
          Card(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
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
                        "${ServisPasaogluData.home["pageHeader"]}",
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ]))),
          Card(
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Mekanik Servis",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "         ${ServisPasaogluData.home["pageServicesMekanikServis"]}",
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ]))),
          Card(
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Yedek Parça",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "         ${ServisPasaogluData.home["pageServicesYedekParca"]}",
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ]))),
          const Text(
            "Çalıştığımız Markalar",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
              height: 140,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: ServisPasaogluData.brands.length,
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Image.asset(
                          ServisPasaogluData.brands[index],
                          width: 160,
                        ),
                      ),
                    );
                  }))),
          Card(
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Oto Ekspertiz",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "         ${ServisPasaogluData.home["pageServicesEkspertiz"]}",
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ]))),
          Card(
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Dinamometre",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "         ${ServisPasaogluData.home["pageServicesDinamometre"]}",
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ]))),
          Card(
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Özel projelendirme",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "         ${ServisPasaogluData.home["pageServicesOzelProjelendirme"]}",
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ]))),
        ]));
  }
}
