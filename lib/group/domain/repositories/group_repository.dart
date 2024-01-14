import 'package:hobihub/group/domain/entities/group_entity.dart';

abstract class GroupRepository {
  Stream<List<GroupEntity>> getGroups(GroupEntity group);
}
