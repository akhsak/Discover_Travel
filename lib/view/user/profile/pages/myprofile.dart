// // import 'package:discover/controller/authentication_provider.dart';
// // import 'package:discover/view/user/profile/pages/edit_profile.dart';
// // import 'package:discover/view/user/profile/widget_prfl.dart';
// // import 'package:discover/widgets/text_style.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';

// // class MyProfile extends StatelessWidget {
// //   final LoginProvider value;
// //   final dynamic imageProvider;

// //   MyProfile({super.key, required this.value, this.imageProvider});

// //   final formKey = GlobalKey<FormState>();

// //   bool obscureText = true;

// //   final fullNameController = TextEditingController();
// //   final ageController = TextEditingController();
// //   final countryCodeController = TextEditingController(text: '+91');
// //   final phoneController = TextEditingController();
// //   final emailController = TextEditingController();

// //   @override
// //   Widget build(BuildContext context) {
// //     Size size = MediaQuery.of(context).size;
// //     double circleAvatarRadius = size.shortestSide * 0.20;
// //     final firebaseauth = FirebaseAuth.instance.currentUser;
// //     final effectiveImageProvider = imageProvider;

// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('My Profile'),
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: SingleChildScrollView(
// //           scrollDirection: Axis.vertical,
// //           child: Form(
// //             key: formKey,
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Center(
// //                   child: Column(
// //                     children: [
// //                       CircleAvatar(
// //                         radius: circleAvatarRadius,
// //                         backgroundColor:
// //                             const Color.fromARGB(255, 143, 189, 198),
// //                         backgroundImage: value.currentUser?.profilepic != null
// //                             ? NetworkImage(value.currentUser?.profilepic ?? '')
// //                             : effectiveImageProvider,
// //                       ),
// //                       SizedBox(height: size.height * .02),
// //                       ElevatedButton(
// //                         onPressed: () {
// //                           Navigator.push(
// //                             context,
// //                             MaterialPageRoute(
// //                               builder: (context) => EditProfile(),
// //                             ),
// //                           );
// //                         },
// //                         style: ElevatedButton.styleFrom(
// //                           backgroundColor: Colors.blue,
// //                           shape: RoundedRectangleBorder(
// //                             borderRadius: BorderRadius.circular(16),
// //                           ),
// //                         ),
// //                         child: Text(
// //                           'Edit',
// //                           style: TextStyle(color: Colors.white),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //                 SizedBox(height: 10),
// //                 userProfileDetailsListTile(
// //                   context,
// //                   titleText: 'Full name',
// //                   valueText: value.currentUser?.userName ?? 'unknown',
// //                 ),
// //                 SizedBox(height: 10),
// //                 Row(
// //                   children: [
// //                     //Container(

// //                     // child: TextFormField(
// //                     //   controller: countryCodeController,
// //                     //   decoration: InputDecoration(
// //                     //     prefixText: '+91',
// //                     //     border: OutlineInputBorder(),
// //                     //   ),
// //                     //   keyboardType: TextInputType.number,
// //                     //   inputFormatters: [
// //                     //     FilteringTextInputFormatter.digitsOnly,
// //                     //   ],
// //                     //   readOnly: true, // Make it read-only to prevent editing
// //                     // ),
// //                     // ),
// //                     SizedBox(width: 10),
// //                     Expanded(
// //                       child: userProfileDetailsListTile(
// //                         context,
// //                         titleText: 'Phone',
// //                         valueText: value.currentUser?.phoneNumber ?? 'unknown',
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //                 SizedBox(height: 10),
// //                 userProfileDetailsListTile(context,
// //                     titleText: 'Age',
// //                     valueText: value.currentUser?.age ?? 'unknown'),
// //                 // TextFormField(
// //                 //   controller: ageController,
// //                 //   decoration: InputDecoration(
// //                 //     labelText: 'Age',
// //                 //     border: OutlineInputBorder(),
// //                 //   ),
// //                 //   validator: (value) {
// //                 //     if (value == null || value.isEmpty) {
// //                 //       return 'Please enter your age';
// //                 //     }
// //                 //     return null;
// //                 //   },
// //                 // ),
// //                 SizedBox(height: 10),
// //                 userProfileDetailsListTile(
// //                   context,
// //                   titleText: 'Email',
// //                   valueText: value.currentUser?.email ??
// //                       firebaseauth?.email ??
// //                       'unknown',
// //                 ),
// //                 SizedBox(height: 50),
// //                 // Center(
// //                 //   child: ElevatedButton(
// //                 //     onPressed: () {
// //                 //       if (formKey.currentState?.validate() ?? false) {
// //                 //         // Handle account creation logic
// //                 //       }
// //                 //     },
// //                 //     style: ElevatedButton.styleFrom(
// //                 //       backgroundColor: Colors.blue,
// //                 //       padding:
// //                 //           EdgeInsets.symmetric(horizontal: 150, vertical: 20),
// //                 //       shape: RoundedRectangleBorder(
// //                 //         borderRadius: BorderRadius.circular(16),
// //                 //       ),
// //                 //     ),
// //                 //     child: Text(
// //                 //       'Submit',
// //                 //       style: TextStyle(color: Colors.white),
// //                 //     ),
// //                 //   ),
// //                 // ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:travel/controller/authentication_provider.dart';
// import 'package:travel/view/user/profile/pages/edit_profile.dart';
// import 'package:travel/view/user/profile/widget_prfl.dart';

// class MyProfile extends StatelessWidget {
//   final dynamic imageProvider;

//   MyProfile({super.key, this.imageProvider});

//   final formKey = GlobalKey<FormState>();

//   bool obscureText = true;

//   final fullNameController = TextEditingController();
//   final ageController = TextEditingController();
//   final countryCodeController = TextEditingController(text: '+91');
//   final phoneController = TextEditingController();
//   final emailController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final value = Provider.of<LoginProvider>(context);
//     Size size = MediaQuery.of(context).size;
//     double circleAvatarRadius = size.shortestSide * 0.17;
//     final firebaseauth = FirebaseAuth.instance.currentUser;
//     final effectiveImageProvider = imageProvider;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My Profile'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           child: Form(
//             key: formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Center(
//                   child: Column(
//                     children: [
//                       CircleAvatar(
//                         radius: circleAvatarRadius,
//                         backgroundColor:
//                             const Color.fromARGB(255, 143, 189, 198),
//                         backgroundImage: value.currentUser?.profilepic != null
//                             ? NetworkImage(value.currentUser?.profilepic ?? '')
//                             : effectiveImageProvider,
//                       ),
//                       SizedBox(height: size.height * .02),
//                       ElevatedButton(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => EditProfile(),
//                             ),
//                           );
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.blue,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(16),
//                           ),
//                         ),
//                         child: Text(
//                           'Edit',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 userProfileDetailsListTile(
//                   context,
//                   titleText: 'Full name',
//                   valueText: value.currentUser?.userName ?? 'unknown',
//                 ),
//                 SizedBox(height: 10),
//                 Row(
//                   children: [
//                     SizedBox(width: 10),
//                     Expanded(
//                       child: userProfileDetailsListTile(
//                         context,
//                         titleText: 'Phone',
//                         valueText: value.currentUser?.phoneNumber ?? 'unknown',
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 10),
//                 userProfileDetailsListTile(context,
//                     titleText: 'Age',
//                     valueText: value.currentUser?.age ?? 'unknown'),
//                 SizedBox(height: 10),
//                 userProfileDetailsListTile(
//                   context,
//                   titleText: 'Email',
//                   valueText: value.currentUser?.email ??
//                       firebaseauth?.email ??
//                       'unknown',
//                 ),
//                 SizedBox(height: 50),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travel/controller/authentication_provider.dart';
import 'package:travel/view/user/profile/pages/edit_profile.dart';
import 'package:travel/view/user/profile/widget_prfl.dart';

class MyProfile extends StatelessWidget {
  final dynamic imageProvider;

  MyProfile({Key? key, this.imageProvider}) : super(key: key);

  final formKey = GlobalKey<FormState>();

  bool obscureText = true;

  final fullNameController = TextEditingController();
  final ageController = TextEditingController();
  final countryCodeController = TextEditingController(text: '+91');
  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final value = Provider.of<LoginProvider>(context);
    Size size = MediaQuery.of(context).size;
    double circleAvatarRadius = size.shortestSide * 0.17;
    final firebaseauth = FirebaseAuth.instance.currentUser;
    final effectiveImageProvider = imageProvider;

    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
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
                              builder: (context) => EditProfile(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          'Edit',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                userProfileDetailsListTile(
                  context,
                  titleText: 'Full name',
                  valueText: value.currentUser?.userName ?? 'unknown',
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    SizedBox(width: 10),
                    Expanded(
                      child: userProfileDetailsListTile(
                        context,
                        titleText: 'Phone',
                        valueText: value.currentUser?.phoneNumber ?? 'unknown',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                userProfileDetailsListTile(
                  context,
                  titleText: 'Age',
                  valueText: value.currentUser?.age ?? 'unknown',
                ),
                SizedBox(height: 10),
                userProfileDetailsListTile(
                  context,
                  titleText: 'Email',
                  valueText: value.currentUser?.email ??
                      firebaseauth?.email ??
                      'unknown',
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
