import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hobihub/group/data/models/group_model.dart';
import 'package:hobihub/group/data/remote_data_source/group_remote_data_source.dart';
import 'package:hobihub/group/domain/entities/group_entity.dart';

class GroupRemoteDataSourceImpl implements GroupRemoteDataSource {
  final FirebaseFirestore firestore;

  GroupRemoteDataSourceImpl({required this.firestore});

  @override
  Stream<List<GroupEntity>> getGroups(GroupEntity group) {
    final groupCollection = firestore.collection("group");
    return groupCollection
        .orderBy("createdAt", descending: false)
        .snapshots()
        .map((querySnapshot) =>
            querySnapshot.docs.map((e) => GroupModel.fromSnapshot(e)).toList());
  }
}
