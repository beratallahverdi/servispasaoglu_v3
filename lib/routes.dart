import 'package:flutter/material.dart';
import 'package:servispasaoglu_v3/screens/sample_screen.dart';

class Routes extends StatefulWidget {
  static const String id = 'Routes';

  const Routes({super.key});
  @override
  State<Routes> createState() => _RoutesState();
}

class _RoutesState extends State<Routes> {
  static final _defaultLightColorScheme =
      ColorScheme.fromSeed(seedColor: Colors.blue);

  static final _defaultDarkColorScheme =
      ColorScheme.fromSeed(seedColor: Colors.blue, brightness: Brightness.dark);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: _defaultLightColorScheme,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: _defaultDarkColorScheme,
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      initialRoute: SampleScreen.id,
      routes: {
        SampleScreen.id: (context) => const SampleScreen(),
      },
    );
  }
}
