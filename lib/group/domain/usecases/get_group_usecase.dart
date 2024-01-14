import 'package:hobihub/group/domain/entities/group_entity.dart';
import 'package:hobihub/group/domain/repositories/group_repository.dart';

class GetGroupsUseCase {
  final GroupRepository repository;

  GetGroupsUseCase({required this.repository});

  Stream<List<GroupEntity>> call(GroupEntity group) {
    return repository.getGroups(group);
  }
}
