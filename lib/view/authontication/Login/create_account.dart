// ignore_for_file: must_be_immutable

import 'package:country_picker/country_picker.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/controller/authentication_provider.dart';
import 'package:travel/view/authontication/Login/login_page.dart';
import 'package:travel/view/authontication/Login/success_create.dart';
import 'package:travel/widgets/snackbar.dart';

class CreateAccount extends StatelessWidget {
  // bool isLoading = false;

  CreateAccount({super.key});

  //final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final createprovider = Provider.of<LoginProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: createprovider.createFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create Account',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  'Get the best out of derleng by creating an account',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: createprovider.userNameController,
                  decoration: InputDecoration(
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
                SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      width: 100,
                      child: Consumer<LoginProvider>(
                        builder: (context, value, child) => TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Container(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: InkWell(
                                onTap: () {
                                  showCountryPicker(
                                    context: context,
                                    countryListTheme: CountryListThemeData(
                                      bottomSheetHeight: 500,
                                    ),
                                    onSelect: (value) {
                                      createprovider.selectCountry = value;
                                    },
                                  );
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      value.selectCountry.flagEmoji,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "+${value.selectCountry.phoneCode}",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: createprovider.phoneController,
                        decoration: InputDecoration(
                          labelText: 'Phone',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          } else if (value.length != 10) {
                            return "Please enter a 10-digit number";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.number,
                  maxLength: 2,
                  controller: createprovider.createAgeController,
                  decoration: InputDecoration(
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
                SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: createprovider.createEmailController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!RegExp(r'^[\w-\.]+@gmail\.com$')
                        .hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                Consumer<LoginProvider>(
                  builder: (context, value, child) => TextFormField(
                    controller: createprovider.createPasswordController,
                    obscureText: value.createObscureText,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          value.createObscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          value.createObscureTextchange();
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 50),
                Center(
                  child: SizedBox(
                    width: 350,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (createprovider.createFormKey.currentState!
                            .validate()) {
                          try {
                            await createprovider.signupUser(
                                createprovider.createEmailController.text,
                                createprovider.createPasswordController.text);

                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SuccessAccount()));

                            createprovider.clearSignupControllers();
                            SnackBarWidget().showSuccessSnackbar(
                                context, 'Registration success');
                          } catch (e) {
                            SnackBarWidget().showErrorSnackbar(context,
                                'Already existed E-mail or invalid E-mail');
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        'Create Account',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 80),
                  child: Row(
                    children: [
                      Text("Already have an account?"),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          },
                          child: Text(
                            'sign in',
                            style: TextStyle(color: Colors.black),
                          ))
                    ],
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
