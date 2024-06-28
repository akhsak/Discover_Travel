import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:travel/model/user_model.dart';
import 'package:travel/view/authontication/otp_screen.dart';
import 'package:travel/widgets/bottombar.dart';
import 'package:travel/widgets/snackbar.dart';

class AuthService {
  String? verificationid;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String collection = 'User';
  Reference storage = FirebaseStorage.instance.ref();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference<UserModel> user;

  AuthService() {
    user = FirebaseFirestore.instance
        .collection(collection)
        .withConverter<UserModel>(
      fromFirestore: (snapshot, options) {
        return UserModel.fromJson(
          snapshot.data()!,
        );
      },
      toFirestore: (value, options) {
        return value.toJson();
      },
    );
  }

  Future<void> addUser(UserModel data) async {
    try {
      if (firebaseAuth.currentUser != null) {
        await user.doc(firebaseAuth.currentUser!.uid).set(data);
      } else {
        throw Exception('No current user found');
      }
    } catch (e) {
      log('Error adding user: $e');
      throw e;
    }
  }

  Future<UserModel?> getCurrentUser() async {
    try {
      if (firebaseAuth.currentUser == null) {
        throw Exception('No current user found');
      }
      final snapshot = await firestore
          .collection(collection)
          .doc(firebaseAuth.currentUser!.uid)
          .get();
      if (snapshot.exists && snapshot.data() != null) {
        return UserModel.fromJson(snapshot.data()!);
      } else {
        return null;
      }
    } catch (e) {
      log('Error getting current user: $e');
      throw e;
    }
  }

  Future<UserCredential> signUpWithEmail(String email, String password) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      log('Account created');
      return userCredential;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserCredential> signInWithEmail(String email, String password) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      log('User logged in');
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<User?> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      if (googleAuth == null) {
        log('Google authentication failed');
        throw Exception('Google authentication failed');
      }

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final User? guser = userCredential.user;
      log("User display Name: ${guser?.displayName}");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => UserBottomScreen()));
      return guser;
    } catch (e) {
      log('Google Sign-In Error: $e');
      throw e;
    }
  }

  Future<void> signOutWithGoogle() async {
    await GoogleSignIn().signOut();
  }

  Future<void> getOtp(context, phoneNumberCon) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException ex) {},
        codeSent: (String verificationId, int? resendtoken) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtpScreen(
                verificationId: verificationId,
              ),
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
        phoneNumber: phoneNumberCon);
  }

  Future<PhoneAuthCredential?> verifyOtp(String otp, context) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationid!, smsCode: otp);

      await firebaseAuth.signInWithCredential(credential);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => UserBottomScreen(),
          ),
          (route) => false);
      SnackBarWidget().showSuccessSnackbar(context, "OTP validated");
    } catch (e) {
      log("verify otp error $e");
      // return null;
    }
    return null;
  }

  void passwordReset({required email, context}) async {
    try {
      log('start');
      await firebaseAuth.sendPasswordResetEmail(email: email);
      log('success');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password reset email sent"),
        ),
      );
    } on FirebaseAuthException catch (e) {
      log('error occurred');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.message.toString(),
          ),
        ),
      );
    }
  }
}
