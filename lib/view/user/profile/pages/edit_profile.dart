// import 'package:country_picker/country_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:travel/controller/authentication_provider.dart'; // Adjust import as per your project structure

// class EditProfile extends StatefulWidget {
//   const EditProfile({Key? key}) : super(key: key);

//   @override
//   State<EditProfile> createState() => _EditProfileState();
// }

// class _EditProfileState extends State<EditProfile> {
//   final formKey = GlobalKey<FormState>();

//   final fullNameController = TextEditingController();
//   final ageController = TextEditingController();
//   final countryCodeController = TextEditingController();
//   final phoneController = TextEditingController();
//   final emailController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     final loginProvider = Provider.of<LoginProvider>(context, listen: false);
//     final currentUser = loginProvider.currentUser;

//     if (currentUser != null) {
//       fullNameController.text = currentUser.userName ?? '';
//       ageController.text = currentUser.age ?? '';
//       // countryCodeController.text = currentUser.countryCode ?? '';
//       phoneController.text = currentUser.phoneNumber ?? '';
//       emailController.text = currentUser.email ?? '';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final createprovider = Provider.of<LoginProvider>(context, listen: false);

//     // Size size = MediaQuery.of(context).size;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Edit Profile'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           child: Form(
//             key: formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 TextFormField(
//                   controller: fullNameController,
//                   decoration: const InputDecoration(
//                     labelText: 'Full name',
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your full name';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 10),
//                 Row(
//                   children: [
//                     SizedBox(
//                       width: 60,
//                       child: Consumer<LoginProvider>(
//                         builder: (context, value, child) => TextFormField(
//                           decoration: InputDecoration(
//                             prefixIcon: Container(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 12),
//                               child: InkWell(
//                                 onTap: () {
//                                   showCountryPicker(
//                                     context: context,
//                                     countryListTheme:
//                                         const CountryListThemeData(
//                                       bottomSheetHeight: 500,
//                                     ),
//                                     onSelect: (value) {
//                                       createprovider.selectCountry = value;
//                                     },
//                                   );
//                                 },
//                                 child: Row(
//                                   children: [
//                                     Text(
//                                       value.selectCountry.flagEmoji,
//                                       style: const TextStyle(fontSize: 20),
//                                     ),
//                                     const SizedBox(
//                                       width: 10,
//                                     ),
//                                     Text(
//                                       "+${value.selectCountry.phoneCode}",
//                                       style: const TextStyle(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.bold),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             border: const OutlineInputBorder(),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                     Expanded(
//                       child: TextFormField(
//                         controller: phoneController,
//                         decoration: const InputDecoration(
//                           labelText: 'Phone',
//                           border: OutlineInputBorder(),
//                         ),
//                         keyboardType: TextInputType.phone,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter your phone number';
//                           }
//                           return null;
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 10),
//                 TextFormField(
//                   controller: ageController,
//                   decoration: const InputDecoration(
//                     labelText: 'Age',
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your age';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 10),
//                 TextFormField(
//                   controller: emailController,
//                   decoration: const InputDecoration(
//                     labelText: 'Email',
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your email';
//                     } else if (!RegExp(r'^[\w-\.]+@gmail\.com$')
//                         .hasMatch(value)) {
//                       return 'Please enter a valid Gmail address';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 50),
//                 Center(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       if (formKey.currentState?.validate() ?? false) {
//                         final loginProvider =
//                             Provider.of<LoginProvider>(context, listen: false);
//                         loginProvider.updateUserProfile(
//                           fullNameController.text,
//                           ageController.text,
//                           countryCodeController.text,
//                           phoneController.text,
//                           emailController.text,
//                         );
//                         Navigator.pop(context); // Go back to MyProfile screen
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue,
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 150, vertical: 20),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                     ),
//                     child: const Text(
//                       'Update',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/controller/authentication_provider.dart'; // Adjust import as per your project structure

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final formKey = GlobalKey<FormState>();

  final fullNameController = TextEditingController();
  final ageController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    final currentUser = loginProvider.currentUser;

    if (currentUser != null) {
      fullNameController.text = currentUser.userName ?? '';
      ageController.text = currentUser.age ?? '';
      phoneController.text = currentUser.phoneNumber ?? '';
      emailController.text = currentUser.email ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final createprovider = Provider.of<LoginProvider>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    double circleAvatarRadius = size.shortestSide * 0.20;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: circleAvatarRadius,
                    backgroundColor: const Color.fromARGB(255, 143, 189, 198),
                    backgroundImage: const AssetImage(
                        'assets/profile_avatar.jpg'), // Replace with the path to your profile image
                  ),
                ),
                TextFormField(
                  controller: fullNameController,
                  decoration: const InputDecoration(
                    labelText: 'Full name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    SizedBox(
                      width: 100,
                      child: Consumer<LoginProvider>(
                        builder: (context, value, child) => TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(
                            prefixIcon: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: InkWell(
                                onTap: () {
                                  showCountryPicker(
                                    context: context,
                                    countryListTheme:
                                        const CountryListThemeData(
                                      bottomSheetHeight: 500,
                                    ),
                                    onSelect: (country) {
                                      createprovider.selectCountry = country;
                                    },
                                  );
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      value.selectCountry.flagEmoji,
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      "+${value.selectCountry.phoneCode}",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: phoneController,
                        decoration: const InputDecoration(
                          labelText: 'Phone',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: ageController,
                  decoration: const InputDecoration(
                    labelText: 'Age',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your age';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!RegExp(r'^[\w-\.]+@gmail\.com$')
                        .hasMatch(value)) {
                      return 'Please enter a valid Gmail address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 50),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState?.validate() ?? false) {
                        final loginProvider =
                            Provider.of<LoginProvider>(context, listen: false);
                        loginProvider.updateUserProfile(
                          fullNameController.text,
                          ageController.text,
                          createprovider.selectCountry.phoneCode,
                          phoneController.text,
                          emailController.text,
                        );
                        Navigator.pop(context); // Go back to MyProfile screen
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 150, vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
