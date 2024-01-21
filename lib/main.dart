// ignore_for_file: library_prefixes
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hobihub/group/domain/usecases/get_group_usecase.dart';
import 'package:hobihub/group/presentation/cubits/group/group_cubit.dart';
import 'package:hobihub/on_generate_route.dart';
import 'package:hobihub/screens/home_screen.dart';
import 'package:hobihub/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hobihub/user/presentation/cubit/auth/auth_cubit.dart';
import 'package:hobihub/user/presentation/cubit/credential/credential_cubit.dart';
import 'firebase_options.dart';
import 'group/presentation/cubits/chat/chat_cubit.dart';
import 'injection_container.dart' as depedencyInjection;

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //locked orientation
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await depedencyInjection.init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((fn) async {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
            create: (_) => depedencyInjection.sl<AuthCubit>()..appStarted()),
        BlocProvider<CredentialCubit>(
            create: (_) => depedencyInjection.sl<CredentialCubit>()),
        BlocProvider<GroupCubit>(
            create: (context) => GroupCubit(
                getGroupsUseCase: depedencyInjection.sl<GetGroupsUseCase>())),
        BlocProvider<ChatCubit>(
            create: (_) => depedencyInjection.sl<ChatCubit>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        onGenerateRoute: OnGenerateRoute.route,
        routes: {
          "/": (context) {
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authState) {
                if (authState is Authenticated) {
                  return HomePage(
                    uid: authState.uid,
                  );
                } else {
                  return const SplashScreen();
                }
              },
            );
          }
        },
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'Poppins',
        ),
      ),
    );
  }
}
