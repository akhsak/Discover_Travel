import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/controller/authentication_provider.dart';
import 'package:travel/widgets/bottombar.dart';
import 'package:travel/widgets/button.dart';
import 'package:travel/widgets/normal_widget.dart';
import 'package:travel/widgets/snackbar.dart';
import 'package:travel/widgets/text_style.dart';

class OtpScreen extends StatelessWidget {
  final String verificationId;
  OtpScreen({super.key, required this.verificationId});
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final authProvider = Provider.of<LoginProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: textPoppins(
            name: 'Verify OTP', fontsize: 20, fontweight: FontWeight.bold),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                height: size.height * .5,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/phonecall-img.png'),
                      fit: BoxFit.cover),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 17),
                height: size.height * .4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    otpTextFormField(context),
                    ButtonWidgets().rectangleButton(size, name: 'V E R I F Y',
                        onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        try {
                          PhoneAuthCredential credential =
                              PhoneAuthProvider.credential(
                                  verificationId: verificationId,
                                  smsCode:
                                      authProvider.otpController.text.trim());
                          await FirebaseAuth.instance
                              .signInWithCredential(credential);
                          authProvider.clearOtpController();

                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserBottomScreen()),
                              (route) => false);
                        } catch (e) {
                          log('Error during OTP verification: $e');
                          SnackBarWidget()
                              .showErrorSnackbar(context, 'Invalid OTP');
                        }
                      } else {
                        log('Form validation failed');
                      }
                    })
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
