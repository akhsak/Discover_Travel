import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travel/controller/authentication_provider.dart';
import 'package:travel/view/user/profile/pages/edit_profile.dart';
import 'package:travel/view/user/profile/widget_prfl.dart';

class MyProfile extends StatelessWidget {
  final dynamic imageProvider;

  MyProfile({super.key, this.imageProvider});

  final formKey = GlobalKey<FormState>();

  bool obscureText = true;

  // final fullNameController = TextEditingController();
  // final ageController = TextEditingController();
  // final phoneController = TextEditingController();
  // final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final value = Provider.of<LoginProvider>(context);
    Size size = MediaQuery.of(context).size;
    double circleAvatarRadius = size.shortestSide * 0.17;
    final firebaseauth = FirebaseAuth.instance.currentUser;
    final effectiveImageProvider = imageProvider;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: circleAvatarRadius,
                        backgroundColor:
                            const Color.fromARGB(255, 143, 189, 198),
                        backgroundImage: value.currentUser?.profilepic != null
                            ? NetworkImage(value.currentUser!.profilepic!)
                            : effectiveImageProvider,
                      ),
                      SizedBox(height: size.height * .02),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EditProfile(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          'Edit',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                userProfileDetailsListTile(
                  context,
                  titleText: 'Full name',
                  valueText: value.currentUser?.userName ?? 'unknown',
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const SizedBox(width: 10),
                    Expanded(
                      child: userProfileDetailsListTile(
                        context,
                        titleText: 'Phone',
                        valueText: value.currentUser?.phoneNumber ?? 'unknown',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                userProfileDetailsListTile(
                  context,
                  titleText: 'Age',
                  valueText: value.currentUser?.age ?? 'unknown',
                ),
                const SizedBox(height: 10),
                userProfileDetailsListTile(
                  context,
                  titleText: 'Email',
                  valueText: value.currentUser?.email ??
                      firebaseauth?.email ??
                      'unknown',
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
