import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hobihub/global/const/page_const.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final Future<void> _initFuture;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    // Set up the future in initState
    _initFuture = _initAsync();
  }

  Future<void> _initAsync() async {
    // Simulate some asynchronous operation
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: _initFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // Navigation after the splash screen is complete
              Navigator.pushNamedAndRemoveUntil(
                  context, PageConst.getStartedPage, (routes) => false);
            }
            // Display your splash screen content (e.g., logo)
            return SvgPicture.asset("assets/images/LOGO.svg");
          },
        ),
      ),
    );
  }
}
