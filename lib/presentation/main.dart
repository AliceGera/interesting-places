import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:interesting_places/data/di/injector.dart';
import 'package:interesting_places/domain/di/injector.dart';
import 'package:interesting_places/presentation/di/injector.dart';
import 'package:interesting_places/presentation/screens/tutorial/tutorial_screen.dart';

void main() {
  configureDependencies();
  runApp(const MyApp());
}

Future<void> configureDependencies() async {
  await configureDataDependencies();
  await configureDomainDependencies();
  await configurePresentationDependencies();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          elevation: 0.0,
          centerTitle: true,
          color: Colors.transparent,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
        ),
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      initialRoute: TutorialScreen.routeName,
      routes: {
        TutorialScreen.routeName: (context) => const TutorialScreen(),
      },
    );
  }
}
