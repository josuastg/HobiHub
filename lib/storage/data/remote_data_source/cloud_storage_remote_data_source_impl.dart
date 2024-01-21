import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:hobihub/storage/data/remote_data_source/cloud_storage_remote_data_source.dart';

class CloudStorageRemoteDataSourceImpl implements CloudStorageRemoteDataSource {
  final FirebaseStorage storage;

  CloudStorageRemoteDataSourceImpl({required this.storage});

  @override
  Future<String> uploadProfileImage({required File file}) async {
    final ref = storage.ref().child(
          "profileImages/${DateTime.now().millisecondsSinceEpoch}${getNameOnly(file.path)}",
        );

    final uploadTask = ref.putFile(file);

    final imageUrl =
        (await uploadTask.whenComplete(() {})).ref.getDownloadURL();

    return imageUrl;
  }

  static String getNameOnly(String path) {
    return path.split('/').last.split('%').last.split("?").first;
  }
}
