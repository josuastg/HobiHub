import 'package:flutter/material.dart';
import 'package:hobihub/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

var kColorScheme = ColorScheme.fromSeed(seedColor: const Color(0xffB55DBE));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const Scaffold(
        body: SplashScreen(),
      ),
    );
  }
}
