import 'package:hobihub/group/domain/entities/group_entity.dart';

abstract class GroupRemoteDataSource {
  Stream<List<GroupEntity>> getGroups(GroupEntity group);
}
