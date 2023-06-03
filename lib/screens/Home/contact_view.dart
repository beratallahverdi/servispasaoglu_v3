import 'package:flutter/material.dart'
    show
        BuildContext,
        Center,
        Color,
        Column,
        Container,
        EdgeInsets,
        FontWeight,
        GestureDetector,
        Icon,
        IconData,
        Icons,
        Image,
        InputDecoration,
        Key,
        MainAxisAlignment,
        MainAxisSize,
        OutlineInputBorder,
        Padding,
        Row,
        ScaffoldMessenger,
        SingleChildScrollView,
        SizedBox,
        SnackBar,
        State,
        StatefulWidget,
        Text,
        TextField,
        TextStyle,
        Theme,
        Widget;
import 'package:servispasaoglu_v3/utils/data.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ContactView extends StatefulWidget {
  const ContactView({Key? key}) : super(key: key);

  @override
  StateContactView createState() => StateContactView();
}

class StateContactView extends State<ContactView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;

    return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(8),
            child: Center(
                child: Column(children: [
              SizedBox(
                width: 200,
                height: 200,
                child: Image.asset("${ServisPasaogluData.info["companyLogo"]}"),
              ),
              Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildButtonColumn(primaryColor, Icons.email, 'E-POSTA',
                          "${ServisPasaogluData.info["companyEmail"]}"),
                      _buildButtonColumn(primaryColor, Icons.call, 'ARA',
                          "${ServisPasaogluData.info["companyTelephone"]}"),
                      _buildButtonColumn(primaryColor, Icons.near_me, 'GİT',
                          "${ServisPasaogluData.info["companyGoogleMaps"]}"),
                      _buildButtonColumn(primaryColor, Icons.link, 'WEBSİTE',
                          "${ServisPasaogluData.info["companyWebsite"]}"),
                    ],
                  )),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'İsminiz',
                ),
              ),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'E-Posta',
                ),
              ),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Telefon Numaranız',
                ),
              ),
              const TextField(
                maxLines: 8,
                decoration: InputDecoration.collapsed(hintText: "Talebiniz"),
              ),
            ]))));
  }

  GestureDetector _buildButtonColumn(
      Color color, IconData icon, String label, String link) {
    return GestureDetector(
        onTap: () {
          canLaunchUrlString(link).then((value) => value
              ? launchUrlString(link)
              : ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Gösterilemiyor"))));
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color),
            Container(
              margin: const EdgeInsets.only(top: 8),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: color,
                ),
              ),
            ),
          ],
        ));
  }
}
