import 'package:hobihub/user/data/remote_data_source/user_remote_data_source.dart';
import 'package:hobihub/user/data/remote_data_source/user_remote_data_source_impl.dart';
import 'package:hobihub/user/data/repository/user_repository_impl.dart';
import 'package:hobihub/user/domain/repository/user_repository.dart';
import 'package:hobihub/user/domain/usercases/forgot_password_usecase.dart';
import 'package:hobihub/user/domain/usercases/get_all_users_usecase.dart';
import 'package:hobihub/user/domain/usercases/get_create_current_user_usecase.dart';
import 'package:hobihub/user/domain/usercases/get_current_uid_usecase.dart';
import 'package:hobihub/user/domain/usercases/get_single_user_usecase.dart';
import 'package:hobihub/user/domain/usercases/get_update_user_usecase.dart';
import 'package:hobihub/user/domain/usercases/is_sign_in_usecase.dart';
import 'package:hobihub/user/domain/usercases/sign_in_usecase.dart';
import 'package:hobihub/user/domain/usercases/sign_out_usecase.dart';
import 'package:hobihub/user/domain/usercases/sign_up_usecase.dart';
import 'package:hobihub/user/presentation/cubit/auth/auth_cubit.dart';
import 'package:hobihub/user/presentation/cubit/credential/credential_cubit.dart';

import '../injection_container.dart';

Future<void> userInjectionContainer() async {
//Cubit or Bloc
  sl.registerFactory<AuthCubit>(() => AuthCubit(
      isSignInUseCase: sl.call(),
      signOutUseCase: sl.call(),
      getCurrentUIDUseCase: sl.call()));

  sl.registerFactory<CredentialCubit>(() => CredentialCubit(
      forgotPasswordUseCase: sl.call(),
      signInUseCase: sl.call(),
      signUpUseCase: sl.call()));

  //UseCases
  sl.registerLazySingleton<ForgotPasswordUseCase>(
      () => ForgotPasswordUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetAllUsersUseCase>(
      () => GetAllUsersUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetCreateCurrentUserUseCase>(
      () => GetCreateCurrentUserUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetCurrentUIDUseCase>(
      () => GetCurrentUIDUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetSingleUserUseCase>(
      () => GetSingleUserUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetUpdateUserUseCase>(
      () => GetUpdateUserUseCase(repository: sl.call()));
  sl.registerLazySingleton<IsSignInUseCase>(
      () => IsSignInUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignInUseCase>(
      () => SignInUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignOutUseCase>(
      () => SignOutUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignUpUseCase>(
      () => SignUpUseCase(repository: sl.call()));

  // Repository
//Repository
  sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(remoteDataSource: sl.call()));

  // RemoteDataSource
  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(fireStore: sl.call(), auth: sl.call()));
}
