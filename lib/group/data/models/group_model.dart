import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hobihub/group/domain/entities/group_entity.dart';

class GroupModel extends GroupEntity {
  const GroupModel({
    final Timestamp? createdAt,
    final String? groupName,
    final String? groupProfileImage,
    final String? uid,
  }) : super(
          createdAt: createdAt,
          groupName: groupName,
          groupProfileImage: groupProfileImage,
          uid: uid,
        );

  factory GroupModel.fromSnapshot(DocumentSnapshot snapshot) {
    return GroupModel(
      createdAt: snapshot.get('createdAt'),
      groupName: snapshot.get('groupName'),
      groupProfileImage: snapshot.get('groupProfileImage'),
      uid: snapshot.get('uid'),
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "createdAt": createdAt,
      "groupName": groupName,
      "groupProfileImage": groupProfileImage,
      "uid": uid,
    };
  }
}
