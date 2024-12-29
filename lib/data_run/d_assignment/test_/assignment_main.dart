import 'package:datarun/data_run/d_dashboard/dashboard_page.dart';
import 'package:datarun/generated/l10n.dart';
import 'package:datarun/utils/navigator_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() => runApp(ProviderScope(      
      child: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      supportedLocales: supportedLocales,
      localizationsDelegates: localizationsDelegates,
      title: 'DataRun',
      theme: ThemeData.dark(),
      home: DashboardPage(),
    );
  }

  final supportedLocales = const <Locale>[
    Locale('ar', ''),
    Locale('en', 'en_us'),
  ];

  final localizationsDelegates = const <LocalizationsDelegate<dynamic>>[
    // L.delegate,
    S.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];
  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     theme: ThemeData.dark(),
  //     home: AssignmentsPage(),
  //   );
  // }
}
