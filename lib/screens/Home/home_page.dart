import 'package:flutter/material.dart';
import 'package:servispasaoglu_v3/classes/user_authentication.dart';
import 'package:servispasaoglu_v3/Components/drawer.dart';
import 'package:servispasaoglu_v3/generated/l10n.dart';
import 'package:servispasaoglu_v3/screens/Home/contact_view.dart';
import 'package:servispasaoglu_v3/screens/Home/gallery_view.dart';
import 'package:servispasaoglu_v3/screens/Home/home_view.dart';
import 'package:servispasaoglu_v3/screens/Home/mechanic_view.dart';
import 'package:servispasaoglu_v3/screens/Home/tuning_calculator_view.dart';
import 'package:servispasaoglu_v3/utils/functions.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/pages/home';
  const HomePage({Key? key}) : super(key: key);
  @override
  UserAuthentication createState() => _HomePageState();
}

class _HomePageState extends UserAuthentication with TickerProviderStateMixin {
  TabController? _tabController;
  Widget pageView = Center(
    child: Image.asset('assets/images/pasaoglu.png'),
  );
  String title = "Home";
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 5, vsync: this, initialIndex: _selectedIndex);
    _tabController!.addListener(() {
      setState(() {
        _selectedIndex = _tabController!.index;
        switch (_selectedIndex) {
          case 0:
            title = S.of(context).homeViewTitle;
            break;
          case 1:
            title = S.of(context).mechanicViewTitle;
            break;
          case 2:
            title = S.of(context).tuningViewTitle;
            break;
          case 3:
            title = S.of(context).galleryViewTitle;
            break;
          case 4:
            title = S.of(context).contactViewTitle;
            break;
          default:
            title = S.of(context).homeViewTitle;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: Theme.of(context).appBarTheme.titleTextStyle),
        leading: ServisPasaogluFunctions.leadingBackButton(context),
      ),
      endDrawer: ServisPasaogluDrawer(user),
      body: TabBarView(controller: _tabController, children: const [
        HomeView(),
        MechanicView(),
        TuningCalculatorView(),
        GalleryView(),
        ContactView(),
      ]),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor:
                Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            icon: const Icon(Icons.home),
            label: S.of(context).mechanicViewBottomBarText,
          ),
          BottomNavigationBarItem(
            backgroundColor:
                Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            icon: const Icon(Icons.settings),
            label: S.of(context).mechanicViewBottomBarText,
          ),
          BottomNavigationBarItem(
            backgroundColor:
                Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            icon: const Icon(Icons.tune),
            label: S.of(context).tuningViewBottomBarText,
          ),
          BottomNavigationBarItem(
            backgroundColor:
                Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            icon: const Icon(Icons.photo_album),
            label: S.of(context).galleryViewBottomBarText,
          ),
          BottomNavigationBarItem(
            backgroundColor:
                Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            icon: const Icon(Icons.contact_page),
            label: S.of(context).contactViewBottomBarText,
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (itemIndex) {
          setState(() {
            _tabController!.animateTo(itemIndex);
          });
        },
      ),
    );
  }
}
