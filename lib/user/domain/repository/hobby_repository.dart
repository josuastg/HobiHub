import 'package:hobihub/user/domain/entities/hobby_entity.dart';

abstract class HobbyRepository {
  Future<List<HobbyEntity>> getHobbies();
}
