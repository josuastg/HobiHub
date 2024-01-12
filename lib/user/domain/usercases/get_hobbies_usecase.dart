import 'package:hobihub/user/domain/entities/hobby_entity.dart';
import 'package:hobihub/user/domain/repository/hobby_repository.dart';

class GetHobbiesUsecase {
  final HobbyRepository repository;

  GetHobbiesUsecase(this.repository);

  Future<List<HobbyEntity>> call() async {
    return repository.getHobbies();
  }
}
