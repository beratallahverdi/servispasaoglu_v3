import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_template/models/sample_model.dart';
import 'package:flutter_template/routes.dart';
import 'package:provider/provider.dart';
import 'providers/sample_provider.dart';

const String hiveBoxName = 'appDB';

final Map<int, TypeAdapter> objList = {
  Sample.typeId: SampleAdapter(),
};

void main() async {
  await Hive.initFlutter();
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
