import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hobihub/user/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({String? fullName, String? email, String? uid, String? token})
      : super(
          fullName: fullName,
          email: email,
          uid: uid,
          token: token,
        );

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    var snapshotMap = snapshot.data() as Map<String, dynamic>;

    return UserModel(
        fullName: snapshotMap['fullName'],
        uid: snapshotMap['uid'],
        email: snapshotMap['email'],
        token: snapshotMap['token']);
  }

  Map<String, dynamic> toDocument() {
    return {
      "fullName": fullName,
      "email": email,
      "uid": uid,
      "token": UserEntity.token,
    };
  }
}
