import 'package:hobihub/group/data/remote_data_source/group_remote_data_impl.dart';
import 'package:hobihub/group/data/remote_data_source/group_remote_data_source.dart';
import 'package:hobihub/group/data/repositories/group_repository_impl.dart';
import 'package:hobihub/group/domain/repositories/group_repository.dart';
import 'package:hobihub/group/domain/usecases/get_group_usecase.dart';
import 'package:hobihub/group/presentation/cubits/group/group_cubit.dart';
import 'package:hobihub/injection_container.dart';

Future<void> groupInjectionContainer() async {
  //Future Cubit/Bloc
  sl.registerFactory<GroupCubit>(() => GroupCubit(getGroupsUseCase: sl.call()));

  //UseCases
  sl.registerLazySingleton<GetGroupsUseCase>(
      () => GetGroupsUseCase(repository: sl.call()));

  //Repository
  sl.registerLazySingleton<GroupRepository>(
      () => GroupRepositoryImpl(remoteDataSource: sl.call()));

  //Remote DataSource
  sl.registerLazySingleton<GroupRemoteDataSource>(
      () => GroupRemoteDataSourceImpl(firestore: sl.call()));
}
