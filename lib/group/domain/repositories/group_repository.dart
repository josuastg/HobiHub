import 'package:hobihub/group/domain/entities/group_entity.dart';
import 'package:hobihub/group/domain/entities/text_message_entity.dart';

abstract class GroupRepository {
  Stream<List<GroupEntity>> getGroups(GroupEntity group);
  Future<void> sendTextMessage(TextMessageEntity textMessageEntity,String channelId);
  Stream<List<TextMessageEntity>> getMessages(String channelId);
}
