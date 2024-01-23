import 'package:hobihub/injection_container.dart';
import 'package:hobihub/storage/data/remote_data_source/cloud_storage_remote_data_source.dart';
import 'package:hobihub/storage/data/remote_data_source/cloud_storage_remote_data_source_impl.dart';
import 'package:hobihub/storage/data/repository/cloud_storage_repository_impl.dart';
import 'package:hobihub/storage/domain/repository/cloud_storage_repository.dart';
import 'package:hobihub/storage/domain/usecases/upload_profile_image_usecase.dart';

Future<void> storageInjectionContainer() async {
  ///UseCases
  sl.registerLazySingleton<UploadProfileImageUseCase>(
      () => UploadProfileImageUseCase(repository: sl.call()));

  /// Repository
  sl.registerLazySingleton<CloudStorageRepository>(
      () => CloudStorageRepositoryImpl(remoteDataSource: sl.call()));

  /// Remote DataSource
  sl.registerLazySingleton<CloudStorageRemoteDataSource>(
      () => CloudStorageRemoteDataSourceImpl(storage: sl.call()));
}
