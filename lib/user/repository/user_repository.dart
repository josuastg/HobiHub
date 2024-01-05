import 'package:hobihub/user/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<void> getCreateCurrentUser(UserEntity user);
  Future<bool> isSignIn();
  Future<void> signIn(UserEntity user);
  Future<void> signUp(UserEntity user);
  Future<void> signOut();
}
