import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hobihub/screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); //locked orientation
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((fn) {
    runApp(const MyApp());
  });
}

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
