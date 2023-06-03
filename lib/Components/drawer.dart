import 'package:flutter/material.dart';

import 'package:servispasaoglu_v3/classes/logged_user.dart';
import 'package:servispasaoglu_v3/screens/routes.dart';
import 'package:servispasaoglu_v3/utils/data.dart';
import 'package:servispasaoglu_v3/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServisPasaogluDrawer extends StatelessWidget {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final ServisPasaogluUser? user;

  ServisPasaogluDrawer(
    this.user, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            padding: const EdgeInsets.all(0.0),
            child: (user != null)
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.only(top: 32.0),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 16.0),
                        child: Text(
                          "${ServisPasaogluData.info["companyName"]}",
                          style: textTheme.titleLarge,
                        ),
                      ),
                      const Divider(
                        height: 1,
                        thickness: 1,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 16.0),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 16.0),
                        child: Text(
                          '${user!.firstName} ${user!.lastName}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 16.0),
                        child: Text(
                          '${user!.city} / ${user!.country}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.only(top: 32.0),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 16.0),
                        child: Text(
                          "${ServisPasaogluData.info["companyName"]}",
                          style: textTheme.titleLarge,
                        ),
                      ),
                      const Divider(
                        height: 1,
                        thickness: 1,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 16.0),
                      ),
                    ],
                  ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: Text(S.of(context).homeViewTitle),
            onTap: () => Navigator.of(context)
                .pushNamedAndRemoveUntil(Routes.home, (route) => false),
          ),
          (user != null && user!.isAdmin == 1)
              ? ListTile(
                  leading: const Icon(Icons.manage_accounts_outlined),
                  title: Text(S.of(context).user),
                  onTap: () => Navigator.of(context)
                      .pushNamedAndRemoveUntil(Routes.users, (route) => false),
                )
              : Container(),
          (user != null && user!.isAdmin == 1)
              ? ListTile(
                  leading: const Icon(Icons.bar_chart),
                  title: Text(S.of(context).statistics),
                  onTap: () => Navigator.of(context).pushNamedAndRemoveUntil(
                      Routes.statistics, (route) => false),
                )
              : Container(),
          (user == null)
              ? ListTile(
                  leading: const Icon(Icons.login_outlined),
                  title: Text(S.of(context).loginPageTitle),
                  onTap: () => Navigator.of(context)
                      .pushNamedAndRemoveUntil(Routes.login, (route) => false),
                )
              : ListTile(
                  leading: const Icon(Icons.announcement_outlined),
                  title: Text(S.of(context).ordersTitle),
                  onTap: () => Navigator.of(context)
                      .pushNamedAndRemoveUntil(Routes.orders, (route) => false),
                ),
          (user != null)
              ? ListTile(
                  leading: const Icon(Icons.logout_outlined),
                  title: Text(S.of(context).logout),
                  onTap: () {
                    _prefs.then((value) => value.clear());
                    Navigator.of(context).pushNamed(Routes.login);
                  })
              : Container(),
        ],
      ),
    );
  }
}
