import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hobihub/group/data/models/group_model.dart';
import 'package:hobihub/group/data/models/text_message_model.dart';
import 'package:hobihub/group/data/remote_data_source/group_remote_data_source.dart';
import 'package:hobihub/group/domain/entities/group_entity.dart';
import 'package:hobihub/group/domain/entities/text_message_entity.dart';

class GroupRemoteDataSourceImpl implements GroupRemoteDataSource {
  final FirebaseFirestore firestore;

  GroupRemoteDataSourceImpl({required this.firestore});

  @override
  Stream<List<GroupEntity>> getGroups(GroupEntity group) {
    final groupCollection = firestore.collection("group");
    return groupCollection
        .orderBy("createdAt", descending: false)
        .snapshots()
        .map((querySnapshot) =>
            querySnapshot.docs.map((e) => GroupModel.fromSnapshot(e)).toList());
  }

  @override
  Stream<List<TextMessageEntity>> getMessages(String channelId) {
    final messagesCollection = firestore
        .collection("groupChatChannel")
        .doc(channelId)
        .collection("messages");

    return messagesCollection.orderBy('time').snapshots().map((querySnap) => querySnap
        .docs
        .map((queryDoc) => TextMessageModel.fromSnapshot(queryDoc))
        .toList());
  }

@override
Future<void> sendTextMessage(TextMessageEntity textMessageEntity, String channelId) async {
  try {
    if (channelId != null && channelId.isNotEmpty) {
      final messagesCollection = firestore
          .collection("groupChatChannel")
          .doc(channelId)
          .collection("messages");

      final messageId = messagesCollection.doc().id;

      final newTextMessage = TextMessageModel(
              content: textMessageEntity.content,
              senderName: textMessageEntity.senderName,
              senderId: textMessageEntity.senderId,
              recipientId: textMessageEntity.recipientId,
              receiverName: textMessageEntity.receiverName,
              time: textMessageEntity.time,
              messageId: messageId,
              type: "TEXT")
          .toDocument();

      await messagesCollection.doc(messageId).set(newTextMessage);
    } else {
      print("Error sending message 1: 'channelId' is null or empty.");
    }
  } catch (e) {
    print("Error sending message 2: $e");
    throw e;
  }
}

}