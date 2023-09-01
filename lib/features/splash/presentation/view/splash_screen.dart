import 'package:flutter/material.dart';
import 'package:note_flutter_local_database/core/constants.dart';

import '../../../../../routes/routes.dart';
import '../../../../core/resources/manager_colors.dart';
import '../../../../core/resources/manager_font_sizes.dart';
import '../../../../core/resources/manager_strings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(
        seconds: Constants.splashTime,
      ),
      () => Navigator.pushReplacementNamed(
        context,
        Routes.homeScreen,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [
            ManagerColors.primaryColor,
            ManagerColors.white,
          ],
        )),
        child: Center(
          child: Text(
            ManagerStrings.appName,
            style: TextStyle(
              fontSize: ManagerFontSizes.s26,
            ),
          ),
        ),
      ),
    );
  }
}
