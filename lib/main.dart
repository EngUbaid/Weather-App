import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/MyScreens/SplashSCreen/splash_screen.dart';
import 'package:weather/MyScreens/utils/our_themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: CustomThemes.lightTheme,
      darkTheme: CustomThemes.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      title: "Weather App",
      home: const SplashScreen(),
    );
  }
}
