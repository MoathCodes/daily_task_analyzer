import 'package:daily_task_analyzer/firebase_options.dart';
import 'package:daily_task_analyzer/models/daily_task_entry.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hivez_flutter/hivez_flutter.dart';

import 'l10n/app_localizations.dart';
import 'pages/home_page.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Hive.registerAdapter(DailyTaskEntryAdapter());

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
    final theme = buildDarkTheme();
    return MaterialApp(
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
      theme: theme,
      darkTheme: theme,
      themeMode: ThemeMode.dark,
      locale: _locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('ar')],
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
