import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:servispasaoglu_v3/main.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'package:servispasaoglu_v3/classes/logged_user.dart';
import 'package:servispasaoglu_v3/classes/order.dart';
import 'package:servispasaoglu_v3/classes/order_status.dart';
import 'package:servispasaoglu_v3/generated/l10n.dart';

// ignore: must_be_immutable
class OrderDetails extends StatefulWidget {
  final Order order;
  ServisPasaogluUser? user;
  OrderDetails({
    Key? key,
    required this.order,
    this.user,
  }) : super(key: key);
  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Row(children: [
        Expanded(
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(8),
                  child: SizedBox(
                      width: double.maxFinite,
                      child: Text(
                        S.of(context).status,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ))),
              Card(
                color: HexColor.fromHex(widget.order.orderStatus!.chartColor!
                    .replaceAll("#", "#FF")),
                child: InkWell(
                  splashColor: HexColor.fromHex(widget
                      .order.orderStatus!.chartColor!
                      .replaceAll("#", "#FF")),
                  onTap: () {
                    widget.user!.isAdmin! == 1
                        ? _buildOrderStatusBottomSheet(context)
                        : null;
                  },
                  child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.white),
                          width: double.maxFinite,
                          child: Text(
                            "${widget.order.orderStatus!.description} ${widget.order.totalCredit} Kr",
                            style: const TextStyle(fontSize: 18),
                          ))),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(8),
                  child: SizedBox(
                      width: double.maxFinite,
                      child: Text(
                        S.of(context).creditRequestsViewDescription,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ))),
              Card(
                  child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: SizedBox(
                          width: double.maxFinite,
                          child: Text(
                            (widget.order.orderRequests != null)
                                ? widget.order.getOrderRequestsText()
                                : "",
                            style: const TextStyle(fontSize: 18),
                          )))),
            ],
          ),
        )
      ]),
      GridView(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 0, childAspectRatio: 2),
        shrinkWrap: true,
        children: [
          Column(
            children: [
              Container(
                  padding: const EdgeInsets.all(8.0),
                  width: double.maxFinite,
                  child: Text(
                    S.of(context).brands,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  )),
              Card(
                  child: Container(
                      width: double.maxFinite,
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        (widget.order.brand != null
                            ? widget.order.brand!.brandName!
                            : widget.order.brandId!),
                        style: const TextStyle(fontSize: 18),
                      ))),
            ],
          ),
          Column(
            children: [
              Container(
                  padding: const EdgeInsets.all(8.0),
                  width: double.maxFinite,
                  child: Text(
                    S.of(context).model,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  )),
              Card(
                  child: Container(
                      width: double.maxFinite,
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        (widget.order.model != null
                            ? widget.order.model!.modelName!
                            : widget.order.modelId!),
                        style: const TextStyle(fontSize: 18),
                      ))),
            ],
          ),
          Column(
            children: [
              Container(
                  padding: const EdgeInsets.all(8.0),
                  width: double.maxFinite,
                  child: Text(
                    S.of(context).generation,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  )),
              Card(
                  child: Container(
                      width: double.maxFinite,
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        (widget.order.generation != null
                            ? widget.order.generation!.generationName!
                            : widget.order.generationId!),
                        style: const TextStyle(fontSize: 18),
                      ))),
            ],
          ),
          Column(
            children: [
              Container(
                  padding: const EdgeInsets.all(8.0),
                  width: double.maxFinite,
                  child: Text(
                    S.of(context).engine,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  )),
              Card(
                  child: Container(
                      width: double.maxFinite,
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        (widget.order.engine != null
                            ? widget.order.engine!.engineName!
                            : widget.order.engineId!),
                        style: const TextStyle(fontSize: 18),
                      ))),
            ],
          ),
          Column(
            children: [
              Container(
                  padding: const EdgeInsets.all(8.0),
                  width: double.maxFinite,
                  child: Text(
                    S.of(context).ecu,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  )),
              Card(
                  child: Container(
                      width: double.maxFinite,
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        (widget.order.ecu != null
                            ? widget.order.ecu!.ecuName!
                            : widget.order.ecuId!),
                        style: const TextStyle(fontSize: 18),
                      ))),
            ],
          ),
          Column(
            children: [
              Container(
                  padding: const EdgeInsets.all(8.0),
                  width: double.maxFinite,
                  child: Text(
                    S.of(context).years,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  )),
              Card(
                  child: Container(
                      width: double.maxFinite,
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        "${widget.order.year}",
                        style: const TextStyle(fontSize: 18),
                      ))),
            ],
          ),
          Column(
            children: [
              Container(
                  padding: const EdgeInsets.all(8.0),
                  width: double.maxFinite,
                  child: Text(
                    S.of(context).plate,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  )),
              Card(
                  child: Container(
                      width: double.maxFinite,
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        "${widget.order.plateNumber}",
                        style: const TextStyle(fontSize: 18),
                      ))),
            ],
          ),
          Column(
            children: [
              Container(
                  padding: const EdgeInsets.all(8.0),
                  width: double.maxFinite,
                  child: Text(
                    S.of(context).horsepower,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  )),
              Card(
                  child: Container(
                      width: double.maxFinite,
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        "${widget.order.powerHp} HP / ${widget.order.powerKw} KW",
                        style: const TextStyle(fontSize: 18),
                      ))),
            ],
          ),
          Column(
            children: [
              Container(
                  padding: const EdgeInsets.all(8.0),
                  width: double.maxFinite,
                  child: Text(
                    S.of(context).torque,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  )),
              Card(
                  child: Container(
                      width: double.maxFinite,
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        "${widget.order.torqueNm} NM",
                        style: const TextStyle(fontSize: 18),
                      ))),
            ],
          ),
          Column(
            children: [
              Container(
                  padding: const EdgeInsets.all(8.0),
                  width: double.maxFinite,
                  child: Text(
                    S.of(context).engineType,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  )),
              Card(
                  child: Container(
                      width: double.maxFinite,
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        widget.order.engineType!.replaceFirst(
                            widget.order.engineType!.substring(0, 1),
                            widget.order.engineType!
                                .substring(0, 1)
                                .toUpperCase()),
                        style: const TextStyle(fontSize: 18),
                      ))),
            ],
          ),
          Column(
            children: [
              Container(
                  padding: const EdgeInsets.all(8.0),
                  width: double.maxFinite,
                  child: Text(
                    S.of(context).transmission,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  )),
              Card(
                  child: Container(
                      width: double.maxFinite,
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        widget.order.transmission!.replaceFirst(
                            widget.order.transmission!.substring(0, 1),
                            widget.order.transmission!
                                .substring(0, 1)
                                .toUpperCase()),
                        style: const TextStyle(fontSize: 18),
                      ))),
            ],
          ),
          Column(
            children: [
              Container(
                  padding: const EdgeInsets.all(8.0),
                  width: double.maxFinite,
                  child: Text(
                    S.of(context).kilometer,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  )),
              Card(
                  child: Container(
                      width: double.maxFinite,
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        "${widget.order.kilometer} KM",
                        style: const TextStyle(fontSize: 18),
                      ))),
            ],
          ),
          Column(
            children: [
              Container(
                  padding: const EdgeInsets.all(8.0),
                  width: double.maxFinite,
                  child: Text(
                    S.of(context).chassis,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  )),
              Card(
                  child: Container(
                      width: double.maxFinite,
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        "${widget.order.chassisNumber}",
                        style: const TextStyle(fontSize: 18),
                      ))),
            ],
          ),
          Column(
            children: [
              Container(
                  padding: const EdgeInsets.all(8.0),
                  width: double.maxFinite,
                  child: Text(
                    S.of(context).customer,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  )),
              Card(
                  child: Container(
                      width: double.maxFinite,
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        "${widget.order.customerName}",
                        style: const TextStyle(fontSize: 18),
                      ))),
            ],
          ),
          Column(
            children: [
              Container(
                  padding: const EdgeInsets.all(8.0),
                  width: double.maxFinite,
                  child: Text(
                    S.of(context).phone,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  )),
              Card(
                  child: InkWell(
                splashColor: HexColor.fromHex(widget
                    .order.orderStatus!.chartColor!
                    .replaceAll("#", "#FF")),
                onTap: () {
                  _buildPhoneBottomSheet(context);
                },
                child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: SizedBox(
                        width: double.maxFinite,
                        child: Text(
                          "0${widget.order.telephoneNumber}",
                          style: const TextStyle(fontSize: 18),
                        ))),
              )),
            ],
          ),
          (widget.user!.isAdmin == 1)
              ? Column(
                  children: [
                    Container(
                        padding: const EdgeInsets.all(8.0),
                        width: double.maxFinite,
                        child: const Text(
                          "Start",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )),
                    Card(
                        child: Container(
                            width: double.maxFinite,
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              "${widget.order.firstTimeInfo}",
                              style: const TextStyle(fontSize: 18),
                            ))),
                  ],
                )
              : Container(),
          (widget.user!.isAdmin == 1)
              ? Column(
                  children: [
                    Container(
                        padding: const EdgeInsets.all(8.0),
                        width: double.maxFinite,
                        child: const Text(
                          "Process",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )),
                    Card(
                        child: Container(
                            width: double.maxFinite,
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              "${widget.order.lastTimeInfo}",
                              style: const TextStyle(fontSize: 18),
                            ))),
                  ],
                )
              : Container(),
        ],
      ),
    ]);
  }

  _buildOrderStatusBottomSheet(BuildContext context) {
    List<Widget> columns = <Widget>[
      Stack(
        children: [
          Container(
              width: double.maxFinite,
              padding: const EdgeInsets.all(16),
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(S.of(context).status,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
              )),
          Positioned(
              top: 16,
              left: 16,
              child: InkWell(
                splashColor: HexColor.fromHex(widget
                    .order.orderStatus!.chartColor!
                    .replaceAll("#", "#FF")),
                child: IconButton(
                    splashColor: HexColor.fromHex(widget
                        .order.orderStatus!.chartColor!
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
      )
    ];
    columns.addAll(OrderStatus.colors.entries
        .map((e) => InkWell(
              splashColor: e.value.withAlpha(255),
              onTap: () =>
                  widget.order.setStatus(status: e.key).whenComplete(() {
                setState(() {});
                Navigator.pop(context);
              }),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      e.key.replaceAll("_", " "),
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
            ))
        .toList());
    showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      isDismissible: true,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Column(
            children: columns,
          ),
        );
      },
    );
  }

  _buildPhoneBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      isDismissible: true,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 32),
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
                              .order.orderStatus!.chartColor!
                              .replaceAll("#", "#FF")),
                          child: IconButton(
                              splashColor: HexColor.fromHex(widget
                                  .order.orderStatus!.chartColor!
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                        child: Column(
                      children: [
                        IconButton(
                          color: Colors.red,
                          iconSize: 64,
                          icon: const Icon(Icons.phone),
                          onPressed: () async {
                            String telephone = widget.order.telephoneNumber!
                                .replaceAll("/[ -()]/", "");
                            telephone = telephone.startsWith("+")
                                ? telephone
                                : "+90$telephone";
                            telephone = telephone.substring(1);
                            canLaunchUrlString("tel:$telephone").then((value) =>
                                value
                                    ? launchUrlString("tel:+$telephone")
                                    : ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                            content: Text(
                                                "Telefon başlatılamıyor."))));
                          },
                        ),
                        const Text('Telefon')
                      ],
                    )),
                    Flexible(
                        child: Column(
                      children: [
                        IconButton(
                          color: Colors.blue,
                          iconSize: 64,
                          icon: const Icon(Icons.sms),
                          onPressed: () async {
                            String telephone = widget.order.telephoneNumber!
                                .replaceAll("/[ -()]/", "");
                            telephone = telephone.startsWith("+")
                                ? telephone
                                : "+90$telephone";
                            telephone = telephone.substring(1);
                            String customerName = widget.order.customerName!;
                            customerName = customerName
                                .toLowerCase()
                                .split(" ")
                                .reduce((value, element) =>
                                    "$value ${element[0].toUpperCase()}${element.substring(1).toLowerCase()}");
                            String text = Uri.parse(
                                    "Sayın $customerName, ${widget.order.plateNumber} plakalı ${widget.order.brand != null ? widget.order.brand!.brandName! : widget.order.brandId!} ${widget.order.model != null ? widget.order.model!.modelName! : widget.order.modelId!} aracınızın yazılım işlemi tamamlanmıştır.")
                                .toString();
                            Permission.sms.request().then((value) => value
                                    .isGranted
                                ? canSendSMS().then((send) => send
                                    ? launchSms(
                                        message: text, number: telephone)
                                    : ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                            content:
                                                Text("SMS başlatılamıyor."))))
                                : ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "SMS erişim izni verilmedi."))));
                          },
                        ),
                        const Text('SMS')
                      ],
                    )),
                    Flexible(
                        child: Column(
                      children: [
                        IconButton(
                          color: Colors.green,
                          iconSize: 64,
                          icon: const FaIcon(FontAwesomeIcons.whatsapp),
                          onPressed: () async {
                            String telephone = widget.order.telephoneNumber!
                                .replaceAll("/[ -()]/", "");
                            telephone = telephone.startsWith("+")
                                ? telephone
                                : "+90$telephone";
                            telephone = telephone.substring(1);
                            String customerName = widget.order.customerName!;
                            customerName = customerName
                                .toLowerCase()
                                .split(" ")
                                .reduce((value, element) =>
                                    "$value ${element[0].toUpperCase()}${element.substring(1).toLowerCase()}");
                            String text = Uri.parse(
                                    "Sayın $customerName, ${widget.order.plateNumber} plakalı ${widget.order.brand != null ? widget.order.brand!.brandName! : widget.order.brandId!} ${widget.order.model != null ? widget.order.model!.modelName! : widget.order.modelId!} aracınızın yazılım işlemi tamamlanmıştır.")
                                .toString();
                            Platform.isAndroid
                                ? await canLaunchUrlString(
                                        "whatsapp://send?phone=$telephone&text=$text")
                                    .then((value) => value
                                        ? launchUrlString(
                                            "whatsapp://send?phone=$telephone&text=$text")
                                        : ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    "Whatsapp başlatılamıyor."))))
                                : await canLaunchUrlString(
                                        "https://wa.me/$telephone?text=$text")
                                    .then((value) => value
                                        ? launchUrlString(
                                            "https://wa.me/$telephone?text=$text")
                                        : ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text("Whatsapp başlatılamıyor."))));
                          },
                        ),
                        const Text('WhatsApp')
                      ],
                    )),
                  ],
                ),
              ],
            ));
      },
    );
  }
}
