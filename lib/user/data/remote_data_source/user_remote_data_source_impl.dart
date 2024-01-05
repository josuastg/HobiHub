import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hobihub/user/data/remote_data_source/user_remote_data_source.dart';
import 'package:hobihub/user/domain/entities/user_entity.dart';

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseFirestore fireStore;
  final FirebaseAuth auth;

  UserRemoteDataSourceImpl({required this.fireStore, required this.auth});

  @override
  Future<void> getCreateCurrentUser(UserEntity user) {
    // TODO: implement getCreateCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<bool> isSignIn() {
    // TODO: implement isSignIn
    throw UnimplementedError();
  }

  @override
  Future<void> signIn(UserEntity user) async {
    await auth.signInWithEmailAndPassword(
        email: user.email!, password: user.password!);
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<void> signUp(UserEntity user) async {
    await auth.createUserWithEmailAndPassword(
        email: user.email!, password: user.password!);
  }
}
