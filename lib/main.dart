import 'package:flutter/material.dart';
import 'package:note_flutter_local_database/features/app/presentation/view/add_note_screen.dart';
import 'package:note_flutter_local_database/features/app/presentation/view/note_details_screen.dart';
import 'package:note_flutter_local_database/routes/routes.dart';

import 'config/dependency_injection.dart';
import 'features/app/presentation/view/home_screen.dart';
import 'features/splash/presentation/view/splash_screen.dart';

void main() async {
  initModule();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splashScreen,
      routes: {
        Routes.splashScreen: (context) => const SplashScreen(),
        Routes.homeScreen: (context) => const HomeScreen(),
        Routes.addNoteScreen: (context) => const AddNoteScreen(),
        Routes.noteDetailsScreen: (context) => const NoteDetailsScreen(),
      },
    );
  }
}
