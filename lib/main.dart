import 'package:flutter/material.dart';
import 'package:note_flutter_local_database/core/features/app/presentation/home_screen.dart';
import 'package:note_flutter_local_database/core/features/splash/presentation/view/splash_screen.dart';
import 'package:note_flutter_local_database/core/storage/local/database/provider/database_provider.dart';
import 'package:note_flutter_local_database/routes/routes.dart';

import 'config/dependency_injection.dart';

void main() async {
  initModule();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splashScreen,
      routes: {
        Routes.splashScreen: (context) => const SplashScreen(),
        Routes.homeScreen: (context) => const HomeScreen()
      },
    );
  }
}
