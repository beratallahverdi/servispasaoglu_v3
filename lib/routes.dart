import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:servispasaoglu_v3/generated/l10n.dart';
import 'package:servispasaoglu_v3/screens/sample_screen.dart';
import 'package:servispasaoglu_v3/utils/constants.dart';

class Routes extends StatefulWidget {
  static const String id = 'Routes';

  const Routes({super.key});
  @override
  State<Routes> createState() => _RoutesState();
}

class _RoutesState extends State<Routes> {
  static final _defaultLightColorScheme =
      ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 255, 40, 0));

  static final _defaultDarkColorScheme = ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 255, 40, 0),
      brightness: Brightness.dark);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: ServisPasaogluConstants.scaffoldMessengerKey,
      navigatorKey: ServisPasaogluConstants.navigatorKey,
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const <Locale>[
        Locale('en'),
        Locale('tr'),
      ],
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
