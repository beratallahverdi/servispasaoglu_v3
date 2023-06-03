import 'package:flutter/material.dart';
import 'package:servispasaoglu_v3/api/order.dart';
import 'package:servispasaoglu_v3/api/users.dart';
import 'package:servispasaoglu_v3/classes/user_authentication.dart';
import 'package:servispasaoglu_v3/Components/drawer.dart';
import 'package:servispasaoglu_v3/classes/detail_statistics_response/detail_statistics_response.dart';
import 'package:servispasaoglu_v3/classes/overview_statistics_response/overview_statistics_response.dart';
import 'package:servispasaoglu_v3/main.dart';

// ignore: must_be_immutable
class StatisticsPage extends StatefulWidget {
  static const String routeName = '/pages/statistics';

  const StatisticsPage({Key? key}) : super(key: key);
  @override
  UserAuthentication createState() => _StatisticsPageState();
}

class _StatisticsPageState extends UserAuthentication
    with TickerProviderStateMixin {
  TabController? _tabController;
  bool _isLoading = true;
  int _selectedDropdownIndex = 0;
  DetailStatisticsResponse? statistics;
  OverviewStatisticsResponse? overviewStatistics;

  int _selectedIndex = 0;
  int isAdmin = 0;

  @override
  void initState() {
    _tabController =
        TabController(length: 5, vsync: this, initialIndex: _selectedIndex);
    _loadFirst();
    super.initState();
  }

  void _loadFirst() {
    setState(() {
      _isLoading = true;
    });
    Future.wait([
      OrdersAPI.getDetailedStatistics(),
      OrdersAPI.getOverviewStatistics(),
    ]).then((value) {
      setState(() {
        isAdmin = user!.isAdmin!;
        statistics = value[0] as DetailStatisticsResponse?;
        overviewStatistics = value[1] as OverviewStatisticsResponse?;
        _isLoading = false;
      });
    });
    // Future(() async {
    //   OrdersAPI.getDetailedStatistics().then((value) => setState(() {
    //         statistics = value;
    //       }));
    //   OrdersAPI.getOverviewStatistics().then((value) => setState(() {
    //         overviewStatistics = value;
    //       }));
    // }).then((value) => setState(() {
    //       _isLoading = false;
    //     }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: SizedBox(
            height: 44.0,
            width: 220.0, // fixed width and height
            child: Image.asset("assets/images/pasaoglu-vertical.png")),
        //Text("${S.of(context).ordersTitle}")
      ),
      endDrawer: ServisPasaogluDrawer((user != null) ? user : null),
      body: RefreshIndicator(
        onRefresh: () async {
          _loadFirst();
        },
        child: (!_isLoading)
            ? TabBarView(controller: _tabController, children: [
                StatisticsOverviewTab(
                    title: "Genel",
                    statistics: overviewStatistics,
                    selectedIndex: _selectedDropdownIndex,
                    onDropdownChange: ((int? value) {
                      setState(() {
                        _selectedDropdownIndex = value!;
                      });
                      UsersAPI.setQuickLookDays(value!).then((value) {
                        _loadFirst();
                      });
                    })),
                StatisticsPageTab(
                  title: "Günlük",
                  statistics: statistics!.data!.days!
                    ..sort((a, b) => b.label!.compareTo(a.label!)),
                ),
                StatisticsPageTab(
                  title: "Haftalık",
                  statistics: statistics!.data!.weeks!
                    ..sort((a, b) => b.label!.compareTo(a.label!)),
                ),
                StatisticsPageTab(
                  title: isAdmin == 1 ? "Şehir" : "Aylık",
                  statistics: (isAdmin == 1
                      ? (statistics!.data!.cities!
                        ..sort((a, b) => b.count! - a.count!))
                      : (statistics!.data!.months!
                        ..sort((a, b) => b.label!.compareTo(a.label!)))),
                ),
                StatisticsPageTab(
                  title: "Marka",
                  statistics: statistics!.data!.brands!
                    ..sort((a, b) => b.count! - a.count!),
                ),
              ])
            : const Center(child: CircularProgressIndicator()),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor:
                Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            icon: const Icon(Icons.settings),
            label: "Genel",
          ),
          BottomNavigationBarItem(
            backgroundColor:
                Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            icon: const Icon(Icons.settings),
            label: "Günlük",
          ),
          BottomNavigationBarItem(
            backgroundColor:
                Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            icon: const Icon(Icons.contact_page),
            label: "Haftalık",
          ),
          BottomNavigationBarItem(
            backgroundColor:
                Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            icon: const Icon(Icons.tune),
            label: isAdmin == 1 ? "Şehir" : "Aylık",
          ),
          BottomNavigationBarItem(
            backgroundColor:
                Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            icon: const Icon(Icons.photo_album),
            label: "Markalar",
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (itemIndex) {
          setState(() {
            _tabController!.animateTo(itemIndex);
            _selectedIndex = itemIndex;
          });
        },
      ),
    );
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }
}

class StatisticsOverviewTab extends StatelessWidget {
  final String title;
  final OverviewStatisticsResponse? statistics;
  final void Function(int?) onDropdownChange;
  final int selectedIndex;
  const StatisticsOverviewTab(
      {Key? key,
      required this.title,
      this.statistics,
      required this.selectedIndex,
      required this.onDropdownChange})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      // DropdownButton(
      //   value: selectedIndex,
      //   items: const <DropdownMenuItem<int>>[
      //     DropdownMenuItem(child: Text("Today"), value: 0),
      //     DropdownMenuItem(child: Text("Last Week"), value: 7),
      //     DropdownMenuItem(child: Text("Last Month"), value: 30),
      //     DropdownMenuItem(child: Text("Last 3 Month"), value: 90),
      //     DropdownMenuItem(child: Text("Last 6 Month"), value: 180),
      //   ],
      //   onChanged: onDropdownChange,
      // ),
      Expanded(
          child: ListView.builder(
        itemBuilder: ((context, index) => Card(
              color: HexColor.fromHex(
                  statistics!.data![index].orderStatus!.chartColor!),
              child: ListTile(
                title: Text(
                  statistics!.data![index].status!,
                  style: const TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                    "${statistics!.data![index].count} / ${statistics!.data![index].credit}",
                    style: const TextStyle(color: Colors.white)),
              ),
            )),
        itemCount: statistics!.data!.length,
      ))
    ]);
  }
}

class StatisticsPageTab extends StatelessWidget {
  final String title;
  final List<dynamic> statistics;

  const StatisticsPageTab(
      {Key? key, required this.title, required this.statistics})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: statistics.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(statistics[index].label),
            subtitle: Text(
                "Credit${statistics[index].credit} / Count ${statistics[index].count}"),
          ),
        );
      },
    );
  }
}
