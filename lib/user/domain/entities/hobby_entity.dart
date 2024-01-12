import 'package:hobihub/user/data/model/hobby_model.dart';

class HobbyEntity {
  final String groupName;
  final String groupProfileImage;

  HobbyEntity({required this.groupName, required this.groupProfileImage});

  factory HobbyEntity.fromHobby(Hobby hobby) {
    return HobbyEntity(
      groupName: hobby.groupName,
      groupProfileImage: hobby.groupProfileImage,
    );
  }

  Hobby toHobby() {
    return Hobby(
      groupName: this.groupName,
      groupProfileImage: this.groupProfileImage,
    );
  }
}
