import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hobihub/user/domain/entities/hobby_entity.dart';
import 'package:hobihub/user/domain/repository/hobby_repository.dart';

class HobbyRepositoryImpl implements HobbyRepository {
  @override
  Future<List<HobbyEntity>> getHobbies() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('group').get();

      return snapshot.docs
          .where((doc) =>
              doc.data() != null &&
              doc.data()!['groupProfileImage'] != null &&
              doc.data()!['groupName'] != null)
          .map((doc) => HobbyEntity(
                groupName: doc.data()!['groupName'],
                groupProfileImage: doc.data()!['groupProfileImage'],
              ))
          .toList();
    } catch (error) {
      print('Error fetching hobbies: $error');
      throw error;
    }
  }
}
