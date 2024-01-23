import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hobihub/user/data/model/user_model.dart';
import 'package:hobihub/user/data/remote_data_source/user_remote_data_source.dart';
import 'package:hobihub/user/domain/entities/user_entity.dart';

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseFirestore fireStore;
  final FirebaseAuth auth;

  UserRemoteDataSourceImpl({required this.fireStore, required this.auth});

  @override
  Future<void> getCreateCurrentUser(UserEntity user) async {
    final userCollection = fireStore.collection("users");

    final uid = await getCurrentUId();

    userCollection.doc(uid).get().then((userDoc) {
      if (!userDoc.exists) {
        final newUser = UserModel(
          email: user.email,
          uid: uid,
          fullName: user.fullName,
          imgUrl: user.imgUrl,
          token: UserEntity.token,
        ).toDocument();

        userCollection.doc(uid).set(newUser);
      } else {
        print("User already exists");
        return;
      }
    });
  }

  @override
  Future<bool> isSignIn() async {
    return auth.currentUser?.uid != null;
  }

  @override
  Future<void> signIn(UserEntity user) async {
    await auth.signInWithEmailAndPassword(
        email: user.email!, password: user.password!);
  }

  @override
  Future<void> signOut() async {
    await auth.signOut();
  }

  @override
  Future<void> signUp(UserEntity user) async {
    await auth
        .createUserWithEmailAndPassword(
            email: user.email!, password: user.password!)
        .then((value) {
      getCreateCurrentUser(user);
    });
  }

  @override
  Future<String> getCurrentUId() async => auth.currentUser!.uid;

  @override
  Stream<List<UserEntity>> getAllUsers(UserEntity user) {
    final userCollection = fireStore.collection("users");

    return userCollection
        .where("uid", isNotEqualTo: user.uid)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
    });
  }

  @override
  Stream<List<UserEntity>> getSingleUser(UserEntity user) {
    final userCollection = fireStore.collection("users");

    return userCollection
        .limit(1)
        .where("uid", isEqualTo: user.uid)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
    });
  }

  @override
  Future<void> getUpdateUser(UserEntity user) async {
    final userCollection = fireStore.collection("users");

    Map<String, dynamic> userInformation = Map();

    if (user.fullName != null && user.fullName != "") {
      userInformation['fullName'] = user.fullName;
    }

    if (user.email != null && user.email != "") {
      userInformation['email'] = user.email;
    }

    if (UserEntity.token != null && UserEntity.token != "") {
      userInformation['token'] = UserEntity.token;
    }

    await userCollection.doc(user.uid).update(userInformation);
  }

  @override
  Future<void> forgotPassword(String email) async {
    await auth.sendPasswordResetEmail(email: email);
  }
}
