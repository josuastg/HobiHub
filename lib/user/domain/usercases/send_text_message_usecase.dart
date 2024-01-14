import 'package:hobihub/user/domain/entities/text_message_entity.dart';
import 'package:hobihub/user/domain/repository/group_repository.dart';

class SendTextMessageUseCase {
  final GroupRepository repository;

  SendTextMessageUseCase({required this.repository});

  Future<void> call(TextMessageEntity textMessageEntity, String channelId) async{
    return await repository.sendTextMessage(textMessageEntity, channelId);
  }
}