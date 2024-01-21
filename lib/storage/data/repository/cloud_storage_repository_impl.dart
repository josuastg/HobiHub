import 'dart:io';

import 'package:hobihub/storage/data/remote_data_source/cloud_storage_remote_data_source.dart';
import 'package:hobihub/storage/domain/repository/cloud_storage_repository.dart';

class CloudStorageRepositoryImpl implements CloudStorageRepository {
  final CloudStorageRemoteDataSource remoteDataSource;

  CloudStorageRepositoryImpl({required this.remoteDataSource});

  @override
  Future<String> uploadProfileImage({required File file}) async =>
      remoteDataSource.uploadProfileImage(file: file);
}
