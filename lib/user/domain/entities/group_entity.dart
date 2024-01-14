import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class GroupEntity extends Equatable {
  final String? uid;
  final String? groupName;
  final String? groupProfileImage;
  final String? createdAt;

  GroupEntity({
    this.uid,
    this.groupName,
    this.groupProfileImage,
    this.createdAt
  });

  @override

  List<Object?> get props => [
    uid,
    groupName,
    groupProfileImage,
    createdAt
  ];
}