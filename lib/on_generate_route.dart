import 'package:flutter/material.dart';
import 'package:hobihub/global/const/page_const.dart';
import 'package:hobihub/screens/change_password_screen.dart';
import 'package:hobihub/screens/get_started_screen.dart';
import 'package:hobihub/screens/home_screen.dart';
import 'package:hobihub/screens/info_app_screen.dart';
import 'package:hobihub/screens/login_screen.dart';
import 'package:hobihub/screens/my_profile_screen.dart';
import 'package:hobihub/screens/register_screen.dart';

class OnGenerateRoute {
  static Route<dynamic> route(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case PageConst.loginPage:
        {
          return materialPageBuilder(widget: const LoginScreen());
        }
      case PageConst.getStartedPage:
        {
          return materialPageBuilder(widget: const GetStartedScreen());
        }
      case PageConst.registrationPage:
        {
          return materialPageBuilder(widget: const RegisterScreen());
        }
      case PageConst.homePage:
        {
          return materialPageBuilder(
              widget: const HomePage(
            uid: '',
          ));
        }
      case PageConst.myProfilePage:
        {
          return materialPageBuilder(widget: const MyProfileScreen());
        }
      case PageConst.infoAppPage:
        {
          return materialPageBuilder(widget: const InfoApplication());
        }
      case PageConst.changePasswordPage:
        {
          return materialPageBuilder(widget: const ChangePassword());
        }
      default:
        return materialPageBuilder(widget: const ErrorPage());
    }
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("error"),
      ),
      body: const Center(
        child: Text("error"),
      ),
    );
  }
}

MaterialPageRoute materialPageBuilder({required Widget widget}) {
  return MaterialPageRoute(builder: (_) => widget);
}
