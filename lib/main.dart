import 'package:daily_task_analyzer/firebase_options.dart';
import 'package:daily_task_analyzer/hive/hive_registrar.g.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:forui/forui.dart';
import 'package:hivez_flutter/hivez_flutter.dart';

import 'l10n/app_localizations.dart';
import 'pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Hive.registerAdapters();
  runApp(const DailyTaskApp());
}

class DailyTaskApp extends StatefulWidget {
  const DailyTaskApp({super.key});

  @override
  State<DailyTaskApp> createState() => _DailyTaskAppState();
}

class _DailyTaskAppState extends State<DailyTaskApp> {
  Locale _locale = const Locale('en');

  @override
  Widget build(BuildContext context) {
    final theme = FThemes.zinc.dark;
    return MaterialApp(
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
      theme: theme.toApproximateMaterialTheme(),
      themeMode: ThemeMode.dark,
      locale: _locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('ar')],
      builder: (context, child) => FAnimatedTheme(data: theme, child: child!),
      home: HomePage(onLocaleChange: _setLocale),
      debugShowCheckedModeBanner: false,
    );
  }

  void _setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }
}
