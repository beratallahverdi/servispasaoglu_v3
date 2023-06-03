import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:servispasaoglu_v3/classes/order.dart';
import 'package:servispasaoglu_v3/classes/logged_user.dart';
import 'package:servispasaoglu_v3/main.dart';

// ignore: must_be_immutable
class OrderCard extends StatefulWidget {
  final ServisPasaogluUser user;
  final void Function() onTap;
  final void Function() onAssociate;
  Order order;
  OrderCard(this.order, this.user,
      {Key? key, required this.onTap, required this.onAssociate})
      : super(key: key);
  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      child: InkWell(
        splashColor: HexColor.fromHex(
            widget.order.orderStatus!.chartColor!.replaceAll("#", "#FF")),
        onTap: widget.onTap,
        child: Ink(
            decoration: const BoxDecoration(color: Colors.transparent),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    color: HexColor.fromHex(widget
                        .order.orderStatus!.chartColor!
                        .replaceAll("#", "#FF")),
                  ),
                  width: double.maxFinite,
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    widget.order.getOrderTitle(),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondary),
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.all(8),
                  color: Colors.transparent,
                  child: Text(
                    widget.order.getOrderDescription(),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadiusDirectional.only(
                        bottomStart: Radius.circular(10),
                        bottomEnd: Radius.circular(10)),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.user.isAdmin! == 1
                              ? widget.order.totalTimeInfo!
                              : "Order ID:${widget.order.orderId}",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface),
                        ),
                        Text(
                          widget.order.appTime!,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface),
                        ),
                      ]),
                ),
              ],
            )),
      ),
    );
  }
}
