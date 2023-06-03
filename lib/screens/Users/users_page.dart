import 'package:flutter/material.dart';
import 'package:servispasaoglu_v3/classes/user_authentication.dart';
import 'package:servispasaoglu_v3/Components/drawer.dart';
import 'package:servispasaoglu_v3/classes/user.dart';
import 'package:servispasaoglu_v3/utils/search_delegate.dart';

// ignore: must_be_immutable
class UsersPage extends StatefulWidget {
  static const String routeName = '/pages/users';

  const UsersPage({Key? key}) : super(key: key);
  @override
  UserAuthentication createState() => _UsersPageState();
}

class _UsersPageState extends UserAuthentication {
  // The controller for the ListView
  late ScrollController _controller;
  final bool _isLoading = true;
  List<User> users = <User>[];

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _loadFirst();
  }

  void _loadFirst() async {
    users.clear();
    /*
    UsersAPI.get().then((value) => setState(() {
          value.removeWhere((user) => user.userStatus!.userStatusId == 3);
          users.addAll(value);
          _isLoading = false;
        }));
        */
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
                showSearch(
                    context: context,
                    delegate: SearchUsers(suggestionList: users));
              },
              child: const Icon(
                Icons.search,
                size: 26.0,
              ),
            )),
        endDrawer: ServisPasaogluDrawer((user != null) ? user : null),
        body: RefreshIndicator(
          onRefresh: () async {
            _loadFirst();
          },
          child: (!_isLoading)
              ? ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) => users[index].card(context))
              : const Center(child: CircularProgressIndicator()),
        ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
