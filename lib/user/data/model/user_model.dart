import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hobihub/user/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({String? fullName, String? email, String? uid})
      : super(
          fullName: fullName,
          email: email,
          uid: uid,
        );

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    var snapshotMap = snapshot.data() as Map<String, dynamic>;

    return UserModel(
        fullName: snapshotMap['name'],
        uid: snapshotMap['uid'],
        email: snapshotMap['email']);
  }

  Map<String, dynamic> toDocument() {
    return {
      "fullName": fullName,
      "email": email,
      "uid": uid,
    };
  }
}
