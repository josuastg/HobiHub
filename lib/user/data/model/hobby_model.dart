import 'package:hobihub/user/domain/entities/hobby_entity.dart';

class Hobby {
  final String groupName;
  final String groupProfileImage;

  Hobby({required this.groupName, required this.groupProfileImage});

  factory Hobby.fromEntity(HobbyEntity entity) {
    return Hobby(
      groupName: entity.groupName,
      groupProfileImage: entity.groupProfileImage,
    );
  }
}
