import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:servispasaoglu_v3/models/sample_model.dart';
import 'package:servispasaoglu_v3/routes.dart';
import 'package:provider/provider.dart';
import 'package:servispasaoglu_v3/screens/Order/order_page.dart';
import 'package:servispasaoglu_v3/utils/constants.dart';
import 'providers/sample_provider.dart';

const String hiveBoxName = 'appDB';

final Map<int, TypeAdapter> objList = {
  Sample.typeId: SampleAdapter(),
};

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessageHandler(RemoteMessage message) async {
  await flutterLocalNotificationsPlugin
      .show(
          int.parse(message.data['NotificationTypeId'] ?? "0"),
          message.notification != null
              ? message.notification!.title
              : "Bildirim",
          message.notification != null
              ? message.notification!.body
              : "Bildirim",
          Platform.isIOS
              ? const NotificationDetails(
                  iOS: DarwinNotificationDetails(badgeNumber: 1))
              : NotificationDetails(
                  android: AndroidNotificationDetails(
                  message.data['NotificationTypeId'].toString(),
                  message.data['NotificationType'].toString(),
                )),
          payload: json.encode(message.data))
      .then((value) => null);
}

void main() async {
  await Hive.initFlutter();
  await Firebase.initializeApp();

  FlutterAppBadger.isAppBadgeSupported()
      .then((value) => value ? FlutterAppBadger.removeBadge() : null);
  flutterLocalNotificationsPlugin.initialize(
      Platform.isIOS
          ? const InitializationSettings(
              iOS: DarwinInitializationSettings(
                  requestAlertPermission: true,
                  requestBadgePermission: true,
                  requestSoundPermission: true))
          : const InitializationSettings(
              android: AndroidInitializationSettings('@mipmap/ic_launcher')),
      onDidReceiveNotificationResponse: (details) {
    ServisPasaogluConstants.navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (context) =>
            OrderPage(null, orderId: int.parse(details.payload!)),
      ),
    );
  }, onDidReceiveBackgroundNotificationResponse: (details) {
    ServisPasaogluConstants.navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (context) =>
            OrderPage(null, orderId: int.parse(details.payload!)),
      ),
    );
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessageHandler);
  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    ServisPasaogluConstants.navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (context) =>
            OrderPage(null, orderId: int.parse(message.data["OrderId"])),
      ),
    );
  },
      onError: (error) => "print(error)",
      onDone: () => FlutterAppBadger.isAppBadgeSupported()
          .then((value) => value ? FlutterAppBadger.removeBadge() : null));

  FirebaseMessaging.onMessage.listen(_firebaseMessageHandler,
      onError: (error) => "print(error)",
      onDone: () => FlutterAppBadger.isAppBadgeSupported()
          .then((value) => value ? FlutterAppBadger.removeBadge() : null));
  for (var item in objList.entries) {
    if (!Hive.isAdapterRegistered(item.key)) Hive.registerAdapter(item.value);
  }
  final Box<dynamic> db = await Hive.openBox(hiveBoxName);

  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp(database: db));
}

class MyApp extends StatelessWidget {
  final Box<dynamic> database;

  const MyApp({super.key, required this.database});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SampleProvider(database)),
      ],
      child: const Routes(),
    );
  }
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
