import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hobihub/global/const/page_const.dart';
import 'package:hobihub/user/domain/entities/user_entity.dart';
import 'package:hobihub/user/presentation/cubit/single_user/single_user_cubit.dart';
import 'package:hobihub/widgets/bottom_sheet_menu.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    BlocProvider.of<SingleUserCubit>(context)
        .getSingleUserProfile(user: UserEntity(uid: auth.currentUser!.uid));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: IconButton(
                icon: const Icon(Icons.menu),
                color: Colors.white,
                iconSize: 40,
                padding: const EdgeInsets.only(top: 1),
                onPressed: () => _openBottomSheetMenu(context)),
          ),
          title: const Text(
            'Profile',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w700, fontSize: 22),
          ),
          backgroundColor: const Color.fromARGB(255, 181, 93, 190)),
      body: BlocBuilder<SingleUserCubit, SingleUserState>(
        builder: (context, singleUserState) {
          if (singleUserState is SingleUserLoaded) {
            return _bodyWidget(context, singleUserState.currentUser);
          }
          return const Center(
              child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 181, 93, 190)));
        },
      ),
    );
  }

  Widget _bodyWidget(BuildContext context, UserEntity currentUser) {
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 180,
            ),
            Text(
              currentUser.fullName as String,
              style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 181, 93, 190),
                  fontSize: 16),
            ),
            Text(
              currentUser.email as String,
              style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 181, 93, 190),
                  fontSize: 16),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              width: 300,
              height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 181, 93, 190),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, PageConst.editProfilePage);
                },
                child: const Text(
                  'Edit Profile',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            //will be implement in next time
            // Container(
            //   width: 300,
            //   height: 40,
            //   child: ElevatedButton(
            //     style: ElevatedButton.styleFrom(
            //       foregroundColor: Colors.white,
            //       backgroundColor: const Color.fromARGB(255, 181, 93, 190),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(30),
            //       ),
            //     ),
            //     onPressed: () {
            //       Navigator.pushNamed(context, PageConst.changePasswordPage);
            //     },
            //     child: const Text('Change Password',
            //         style:
            //             TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

void _openBottomSheetMenu(BuildContext context) {
  showModalBottomSheet(
    showDragHandle: true,
    useSafeArea: true,
    context: context,
    builder: (ctx) => const BottomSheetMenu(),
  );
}
