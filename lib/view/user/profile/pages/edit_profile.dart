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
  final countryCodeController = TextEditingController(text: '+91');
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
      // countryCodeController.text = currentUser.countryCode ?? '';
      phoneController.text = currentUser.phoneNumber ?? '';
      emailController.text = currentUser.email ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
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
                      width: 60,
                      child: TextFormField(
                        controller: countryCodeController,
                        decoration: const InputDecoration(
                          prefixText: '+',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
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
                          countryCodeController.text,
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

                  // child: ElevatedButton(
                  //   onPressed: () {
                  //     if (formKey.currentState?.validate() ?? false) {
                  //       final loginProvider =
                  //           Provider.of<LoginProvider>(context, listen: false);
                  //       loginProvider.updateUser(
                  //         fullNameController.text,
                  //         ageController.text,
                  //       );
                  //       Navigator.pop(context); // Go back to MyProfile screen
                  //     }
                  //   },
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor: Colors.blue,
                  //     padding: const EdgeInsets.symmetric(
                  //         horizontal: 150, vertical: 20),
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(16),
                  //     ),
                  //   ),
                  //   child: const Text(
                  //     'Update',
                  //     style: TextStyle(color: Colors.white),
                  //   ),
                  // ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
