import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? fullName;
  final String? email;
  final String? uid;
  final String? password;
  final String? imgUrl;
  static String? token;

  const UserEntity(
      {this.fullName, this.email, this.uid, this.password, this.imgUrl, this.token});

  @override
  List<Object?> get props => [fullName, email, uid, password, imgUrl, token];
}
