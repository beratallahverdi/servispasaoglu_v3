import 'package:flutter/material.dart';
import 'package:servispasaoglu_v3/api/order.dart';
import 'package:servispasaoglu_v3/classes/user_authentication.dart';
import 'package:servispasaoglu_v3/Components/drawer.dart';
import 'package:servispasaoglu_v3/classes/order.dart';
import 'package:servispasaoglu_v3/classes/order_status.dart';
import 'package:servispasaoglu_v3/screens/Order/order_page.dart';
import 'package:servispasaoglu_v3/screens/Orders/orders_page_card.dart';
import 'package:servispasaoglu_v3/utils/search_delegate.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class OrdersPage extends StatefulWidget {
  static const String routeName = '/pages/orders';
  const OrdersPage({Key? key}) : super(key: key);
  @override
  UserAuthentication createState() => _OrderPageState();
}

class _OrderPageState extends UserAuthentication with WidgetsBindingObserver {
  int _page = 1;
  final int _limit = 10;

  bool _hasNextPage = true;
  bool _isFirstLoadRunning = false;
  final List _orders = [];
  final Map<int, Order> _ordersMap = {};
  final List _orderStatuses = [];
  final Future<SharedPreferences> _preferences =
      SharedPreferences.getInstance();

  // The controller for the ListView
  late ScrollController _controller;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _loadLatestOrders();
    } else if (state == AppLifecycleState.inactive) {
      // app is inactive
    } else if (state == AppLifecycleState.paused) {
      // user is about quit our app temporally
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    OrderStatus.colors.forEach((key, value) {
      _orderStatuses.add({
        "label": key,
        "color": value,
        "isSelected": false,
      });
    });
    _controller = ScrollController();
    _loadFirst();
  }

  void _loadFromCache() async {
    var preferences = await _preferences;
    setState(() {
      _orders.clear();
      _ordersMap.clear();
      for (var element in preferences.getStringList("ordersSet")!) {
        var order = Order.fromJson(element);
        _ordersMap[order.orderId!] = order;
      }
      _orders.addAll(_ordersMap.values);
      _sortOrders();
    });
  }

  _loadFromAPI() async {
    var preferences = await _preferences;
    OrdersAPI.getWithOffset(offset: 0, limit: 50)
        .then((value) => setState(() {
              _orders.clear();
              _ordersMap.clear();
              for (var order in value.data!) {
                _ordersMap[order.orderId!] = order;
              }
              _sortOrders();
              _hasNextPage = (value.total > value.to);
            }))
        .then((_) => preferences.setStringList(
            "ordersSet", (_ordersMap.values.map((e) => e.toJson()).toList())));
  }

  void _loadFirst() async {
    var preferences = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _isFirstLoadRunning = true;
      _page = 1;
      _orderStatuses.asMap().forEach((index, value) {
        _orderStatuses[index]["isSelected"] = false;
      });
    });
    preferences.containsKey("ordersSet") ? _loadFromCache() : _loadFromAPI();
    setState(() => _isFirstLoadRunning = false);
    () async {
      _loadLatestOrders();
    }();
  }

  void _loadMore() async {
    var preferences = await SharedPreferences.getInstance();
    OrdersAPI.getWithOffset(offset: _ordersMap.length, limit: _limit)
        .then((value) => setState(() {
              _orders.clear();
              for (var order in value.data!) {
                _ordersMap[order.orderId!] = order;
              }
              _orders.addAll(_ordersMap.values);
              _sortOrders();
              _hasNextPage = (value.total > value.to);
            }))
        .then((_) => preferences.setStringList(
            "ordersSet", (_ordersMap.values.map((e) => e.toJson()).toList())));
  }

  _loadLatestOrders() async {
    var preferences = await SharedPreferences.getInstance();
    OrdersAPI.getWithOffset(offset: 0, limit: 50)
        .then((value) => setState(() {
              _orders.clear();
              _ordersMap.clear();
              for (var order in value.data!) {
                _ordersMap[order.orderId!] = order;
              }
              _orders.addAll(_ordersMap.values);
              _sortOrders();
              _hasNextPage = (value.total > value.to);
            }))
        .then((_) => preferences.setStringList(
            "ordersSet", (_ordersMap.values.map((e) => e.toJson()).toList())));
  }

  void filterOrders() async {
    if (_orderStatuses
        .where((element) => element["isSelected"] == true)
        .isEmpty) {
      _loadFromCache();
    } else {
      var keyword = _orderStatuses
          .where((element) => element["isSelected"] == true)
          .map((e) => "${e['label']}")
          .toList()
          .join(' ');
      var filteredIds = [];
      OrdersAPI.getWithKeyword(keyword: keyword, page: _page, limit: 50)
          .then((value) => setState(() {
                _orders.clear();
                for (var order in value.data!) {
                  _ordersMap[order.orderId!] = order;
                  filteredIds.add(order.orderId);
                }
                _orders.addAll(_ordersMap.values
                    .where((element) => filteredIds.contains(element.orderId)));
                _sortOrders();
                _hasNextPage = (value.lastPage != value.currentPage);
              }));
    }
  }

  _sortOrders() {
    _orders.sort((a, b) {
      if (a.orderStatus.id.compareTo(b.orderStatus.id) > 0) {
        return 1;
      } else if (a.orderStatus.id.compareTo(b.orderStatus.id) < 0) {
        return -1;
      } else if (a.orderStatus.id.compareTo(b.orderStatus.id) == 0) {
        if (a.updatedAt.compareTo(b.updatedAt) > 0) {
          return -1;
        } else if (a.updatedAt.compareTo(b.updatedAt) < 0) {
          return 1;
        } else {
          return 0;
        }
      }
      return 0;
    });
  }

  List<Widget> _buildOrderStatusButtons() {
    List<Widget> buttons = [];
    for (int i = 0; i < _orderStatuses.length; i++) {
      buttons.add(
        Container(
          margin: const EdgeInsets.only(right: 10),
          child: FilterChip(
            backgroundColor: _orderStatuses[i]["isSelected"]
                ? _orderStatuses[i]["color"]
                : Theme.of(context).colorScheme.surface,
            onSelected: (bool value) {
              setState(() {
                _orderStatuses[i]["isSelected"] =
                    !_orderStatuses[i]["isSelected"];
                filterOrders();
              });
            },
            label: Text(
                _orderStatuses[i]["label"].toString().replaceAll("_", " "),
                style: TextStyle(
                    color: _orderStatuses[i]["isSelected"]
                        ? Colors.white
                        : Theme.of(context).colorScheme.onSurface)),
          ),
        ),
      );
    }
    return buttons;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: InkWell(
              onTap: () {
                _controller.animateTo(_controller.position.minScrollExtent,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.ease);
              },
              child: SizedBox(
                  height: 44.0,
                  width: 220.0, // fixed width and height
                  child: Image.asset("assets/images/pasaoglu-vertical.png"))),
          //Text("${S.of(context).ordersTitle}")
          leading: GestureDetector(
            onTap: () {
              showSearch(context: context, delegate: SearchOrder(user: user!));
            },
            child: const Icon(
              Icons.search,
              size: 26.0,
            ),
          )),
      endDrawer: ServisPasaogluDrawer((user != null) ? user : null),
      body: RefreshIndicator(
          onRefresh: () async {
            _loadLatestOrders();
          },
          child: ListView(
              controller: _controller,
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                SizedBox(
                    height: 64,
                    width: double.maxFinite,
                    child: Card(
                      elevation: 1.5,
                      margin: const EdgeInsets.fromLTRB(6, 12, 6, 0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children: _buildOrderStatusButtons(),
                        ),
                      ),
                    )),
                (_isFirstLoadRunning)
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height - 144,
                        width: MediaQuery.of(context).size.width,
                        child: const Center(child: CircularProgressIndicator()))
                    : ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _orders.length,
                        itemBuilder: _buildOrderCard,
                      ),

                // When nothing else to load
                (_hasNextPage == false)
                    ? Container(
                        padding: const EdgeInsets.only(top: 30, bottom: 40),
                        child: const Center(
                          child: Text('You have fetched all of the content'),
                        ),
                      )
                    : Container(
                        padding: const EdgeInsets.only(top: 8, bottom: 8),
                        child: Center(
                            child: ElevatedButton(
                                onPressed: _loadMore,
                                child: const Text('Load More'))),
                      ),
              ])),
    );
  }

  void _onTap(int i) {
    if (user!.isAdmin == 1 &&
        _orders[i].orderStatus!.description.compareTo(OrderStatus.waiting) ==
            0) {
      OrdersAPI.setStatus(order: _orders[i], status: OrderStatus.inProgress)
          .then((value) => setState(() {
                _orders.removeAt(i);
                _orders.insert(i, value.order!);
              }));
    }
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => OrderPage(
              user!,
              orderId: _orders[i].orderId!,
            )));
  }

  Widget _buildOrderCard(BuildContext context, int i) {
    return OrderCard(_orders[i], user!, onTap: () {
      _onTap(i);
    }, onAssociate: () {});
  }

  @override
  void dispose() {
    //_controller.removeListener(_loadMore);
    _controller.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
