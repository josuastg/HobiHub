import 'package:cloud_firestore/cloud_firestore.dart';

class Hobby {
  final Timestamp? createdAt;
  final String? groupName;
  final String? groupProfileImage;
  final String? uid;

  Hobby(this.createdAt, this.groupName, this.groupProfileImage, this.uid);
}
