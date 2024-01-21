import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GroupEntity extends Equatable {
  final Timestamp? createdAt;
  final String? groupName;
  final String? groupProfileImage;
  final String? uid;

  const GroupEntity({
    this.createdAt,
    this.groupName,
    this.groupProfileImage,
    this.uid,
  });

  @override
  List<Object?> get props => [
        createdAt,
        groupName,
        groupProfileImage,
        uid,
      ];
}
