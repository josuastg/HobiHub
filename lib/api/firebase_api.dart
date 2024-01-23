import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hobihub/user/domain/entities/user_entity.dart';

class FirebaseApi {
  static FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initializeNotifications() async {
    await firebaseMessaging.requestPermission();
  }
  
  Future<void> saveTokenUsers(String token, UserEntity users) async {
    try {
      String userUid = users.uid!;

      await FirebaseFirestore.instance.collection('users').doc(userUid).set({
        'token': token,
      }, SetOptions(merge: true));

      print('Token berhasil disimpan di firebase');
    } catch (e) {
      print('Error saat menyimpan token di firebase : $e');
    }
  }
}

