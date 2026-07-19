import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:hive_flutter/hive_flutter.dart';

import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

import 'services/notification_service.dart';

import 'screens/auth_gate.dart';

import 'l10n/app_localizations.dart';

void main() async {

  WidgetsFlutterBinding
      .ensureInitialized();

  /// FIREBASE
  await Firebase.initializeApp(

    options:
        DefaultFirebaseOptions
            .currentPlatform,
  );

  /// HIVE
  await Hive.initFlutter();

  /// OPEN BOXES
  await Hive.openBox(
      "tasksBox");

  await Hive.openBox(
      "studyTimeBox");

  await Hive.openBox(
      "subjectsBox");

  await Hive.openBox(
      "profileBox");

  await Hive.openBox(
      "settingsBox");

  await Hive.openBox(
      "submissionsBox");

  /// NOTIFICATIONS
  await NotificationService
      .init();

  runApp(
      const StudyPlannerApp());
}

class StudyPlannerApp
    extends StatelessWidget {

  const StudyPlannerApp(
      {super.key});

  @override
  Widget build(
      BuildContext context) {

    final settingsBox =
        Hive.box(
            "settingsBox");

    return ValueListenableBuilder(

      valueListenable:
          settingsBox
              .listenable(),

      builder:
          (context, box, _) {

        /// DARK MODE
        bool isDarkMode =
            box.get(

          "darkMode",

          defaultValue: false,
        );

        /// LANGUAGE
        String languageCode =
            box.get(

          "languageCode",

          defaultValue: "en",
        );

        return MaterialApp(

          debugShowCheckedModeBanner:
              false,

          title:
              "Study Planner",

          /// LOCALE
          locale:
              Locale(
                  languageCode),

          /// SUPPORTED LANGUAGES
          supportedLocales:
              const [

            Locale('en'),

            Locale('te'),

            Locale('hi'),

            Locale('ta'),

            Locale('kn'),

            Locale('sv'),
          ],

          /// LOCALIZATION
          localizationsDelegates:
              const [

            AppLocalizations
                .delegate,

            GlobalMaterialLocalizations
                .delegate,

            GlobalWidgetsLocalizations
                .delegate,

            GlobalCupertinoLocalizations
                .delegate,
          ],

          /// LIGHT THEME
          theme:
              ThemeData.light(),

          /// DARK THEME
          darkTheme:
              ThemeData.dark(),

          /// THEME MODE
          themeMode:

              isDarkMode

                  ? ThemeMode.dark

                  : ThemeMode.light,

          /// AUTH GATE
          home:
              const AuthGate(),
        );
      },
    );
  }
}