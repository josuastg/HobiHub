import 'package:hobihub/user/domain/entities/user_entity.dart';

abstract class UserRemoteDataSource {
  Future<void> getCreateCurrentUser(UserEntity user);
  Future<String> getCurrentUId();
  Future<bool> isSignIn();
  Future<void> signIn(UserEntity user);
  Future<void> signUp(UserEntity user);
  Future<void> signOut();
  Stream<List<UserEntity>> getAllUsers(UserEntity user);
  Stream<List<UserEntity>> getSingleUser(UserEntity user);
  Future<void> getUpdateUser(UserEntity user);
  Future<void> forgotPassword(String email);
}
