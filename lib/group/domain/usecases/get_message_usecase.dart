import 'package:hobihub/group/domain/entities/text_message_entity.dart';
import 'package:hobihub/group/domain/repositories/group_repository.dart';

class GetMessageUseCase {
  final GroupRepository repository;

  GetMessageUseCase({required this.repository});
  
  Stream<List<TextMessageEntity>> call(String channelId) {
    return repository.getMessages(channelId);
  }
}