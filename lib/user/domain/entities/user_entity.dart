import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? fullName;
  final String? email;
  final String? uid;
  final String? password;
  static String? token;

  const UserEntity({this.fullName, this.email, this.uid, this.password, token});
  @override
  List<Object?> get props => [fullName, email, uid, password, token];
}
