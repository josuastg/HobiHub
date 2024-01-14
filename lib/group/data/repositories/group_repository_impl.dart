import 'package:hobihub/group/data/remote_data_source/group_remote_data_source.dart';
import 'package:hobihub/group/domain/entities/group_entity.dart';
import 'package:hobihub/group/domain/repositories/group_repository.dart';

class GroupRepositoryImpl implements GroupRepository {
  final GroupRemoteDataSource remoteDataSource;

  GroupRepositoryImpl({required this.remoteDataSource});

  @override
  Stream<List<GroupEntity>> getGroups(GroupEntity group) =>
      remoteDataSource.getGroups(group);
}
