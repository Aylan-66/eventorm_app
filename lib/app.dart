import 'package:flutter/material.dart';
import 'package:eventorm_app/screens/splash_screen.dart';
import 'package:eventorm_app/styles/theme.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeData,
      home: SplashScreen(),
    );
  }
}
