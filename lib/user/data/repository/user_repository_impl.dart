

import 'package:hobihub/user/data/remote_data_source/user_remote_data_source.dart';
import 'package:hobihub/user/domain/entities/user_entity.dart';
import 'package:hobihub/user/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {

  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});


  @override
  Future<bool> isSignIn() async =>
      remoteDataSource.isSignIn();

  @override
  Future<void> signIn(UserEntity user) async =>
      remoteDataSource.signIn(user);

  @override
  Future<void> signOut() async =>
      remoteDataSource.signOut();

  @override
  Future<void> signUp(UserEntity user) async =>
      remoteDataSource.signUp(user);
      
  @override
  Future<void> getCreateCurrentUser(UserEntity user)async =>
      remoteDataSource.getCreateCurrentUser(user);

}