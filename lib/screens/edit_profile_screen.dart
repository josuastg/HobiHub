import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hobihub/global/const/page_const.dart';
import 'package:hobihub/user/domain/entities/user_entity.dart';
import 'package:hobihub/user/presentation/cubit/single_user/single_user_cubit.dart';
import 'package:hobihub/user/presentation/cubit/user/user_cubit.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  @override
  void initState() {
    BlocProvider.of<SingleUserCubit>(context)
        .getSingleUserProfile(user: UserEntity(uid: auth.currentUser!.uid));
    super.initState();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
              color: Colors.white,
              iconSize: 30,
            ),
            title: const Text(
              'Edit Profile',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 22),
            ),
            backgroundColor: const Color.fromARGB(255, 181, 93, 190)),
        body: BlocBuilder<SingleUserCubit, SingleUserState>(
          builder: (context, singleUserState) {
            if (singleUserState is SingleUserLoaded) {
              return _bodyWidget(singleUserState.currentUser);
            }
            return const Center(child: CircularProgressIndicator());
          },
        ));
  }

  Widget _bodyWidget(UserEntity currentUser) {
    _fullNameController.value =
        TextEditingValue(text: "${currentUser.fullName}");
    _emailController.value = TextEditingValue(text: "${currentUser.email}");
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 150,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              controller: _fullNameController,
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 181, 93, 190), width: 3)),
                  labelText: 'Name',
                  labelStyle:
                      TextStyle(color: Color.fromARGB(255, 181, 93, 190))),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 10),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 181, 93, 190), width: 3)),
                labelText: 'Email',
                labelStyle: TextStyle(
                  color: Color.fromARGB(255, 181, 93, 190),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Container(
            width: 310,
            height: 35,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color.fromARGB(255, 181, 93, 190),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () => _fullNameController.text.isEmpty ||
                      _emailController.text.isEmpty
                  ? null
                  : _updateProfile(currentUser.uid!),
              child: const Text(
                'Change Profile',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _updateProfile(String uid) {
    BlocProvider.of<UserCubit>(context)
        .getUpdateUser(
            user: UserEntity(
      uid: uid,
      fullName: _fullNameController.text,
      email: _emailController.text,
    ))
        .then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Update Profile successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pushNamed(context, PageConst.myProfilePage);
    }).catchError((err) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Update Profile Failed!, $err'),
          backgroundColor: Colors.red,
        ),
      );
    });
  }
}
