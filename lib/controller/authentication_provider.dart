import 'dart:developer';

import 'package:country_picker/country_picker.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel/model/user_model.dart';
import 'package:travel/service/authontication.dart';
import 'package:travel/widgets/admint_bottombar.dart';
import 'package:travel/widgets/bottombar.dart';
import 'package:travel/widgets/snackbar.dart';

class LoginProvider extends ChangeNotifier {
  final AuthService authService = AuthService();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  TextEditingController userNameController = TextEditingController();
  // final createFullNameController = TextEditingController();
  final createEmailController = TextEditingController();
  final createPasswordController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController createAgeController = TextEditingController();

  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final fillAccountFormkey = GlobalKey<FormState>();

  final createFormKey = GlobalKey<FormState>();

  final otpFormKey = GlobalKey<FormState>();
  final forgotPasswordFormkey = GlobalKey<FormState>();
  bool isAdminHome = false;

  String? emailError;
  String? passwordError;
  // bool obscureText = true;
  int currentIndex = 0;
  UserModel? currentUser;
  bool showPassword = true;
  bool showOtpField = false;
  Country selectCountry = Country(
      phoneCode: '91',
      countryCode: "IN",
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: "INDIA",
      example: "INDIA",
      displayName: "INDIA",
      displayNameNoCountryCode: "IN",
      e164Key: "");

  bool loginObscureText = true;
  void loginObscureTextchange() {
    loginObscureText = !loginObscureText;
    notifyListeners();
  }

  bool createObscureText = true;
  void createObscureTextchange() {
    createObscureText = !createObscureText;
    notifyListeners();
  }

  Future<void> forgotPassword(context, {email}) async {
    authService.passwordReset(email: email, context: context);
  }

  void clearPhoneController() {
    createAgeController.clear();
  }

  void clearOtpController() {
    otpController.clear();
  }

  void clearSignupControllers() {
    userNameController.clear();
    createEmailController.clear();
    createPasswordController.clear();
    phoneController.clear();
    createAgeController.clear();
  }

  void clearLoginControllers() {
    loginEmailController.clear();
    loginPasswordController.clear();
  }

  // void validateEmail(String value) {
  //   if (value.isEmpty) {
  //     emailError = 'Please enter your email';
  //   } else if (!RegExp(r'^[\w-\.]+@gmail\.com$').hasMatch(value)) {
  //     emailError = 'Please enter a valid @gmail.com email address';
  //   } else {
  //     emailError = null;
  //   }
  //   notifyListeners();
  // }
  void validateEmail(String value) {
    if (value.isEmpty) {
      emailError = 'Please enter your email';
    } else if (!RegExp(r'^[\w-\.]+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$')
        .hasMatch(value)) {
      emailError = 'Please enter a valid email address';
    } else {
      emailError = null;
    }
    notifyListeners();
  }

  void validatePassword(String value) {
    if (value.isEmpty) {
      passwordError = 'Please enter your password';
    } else {
      passwordError = null;
    }
    notifyListeners();
  }

  Future<UserCredential> signupUser(String email, String password, String age,
      String phoneNumber, String userName) async {
    return await authService.signUpWithEmail(
        email: email,
        password: password,
        age: age,
        userName: userName,
        phoneNumber: phoneNumber);
  }

  Future<UserCredential> loginWithEmail(String email, String password) async {
    return await authService.signInWithEmail(email, password);
  }

  // Future<void> signOutWithEmail() async {
  //   return await authService.signOutEmail();
  // }

  Future<void> googleSignIn(BuildContext context) async {
    try {
      await authService.signInWithGoogle(context);
      notifyListeners();
    } catch (e) {
      notifyListeners();
    }
  }

  Future<void> googleSignOut() async {
    await authService.signOutWithGoogle();

    notifyListeners();
  }

  addUser() async {
    final user = UserModel(
      email: createEmailController.text,
      userName: userNameController.text,
      phoneNumber: createAgeController.text,
      uId: firebaseAuth.currentUser!.uid,
    );
    await authService.addUser(user);
    getUser();
  }

  Future<void> getUser() async {
    currentUser = await authService.getCurrentUser();
    if (currentUser != null) {
      log(currentUser!.email!);
    }
    notifyListeners();
  }

  // updateUser(userid, UserModel data) async {
  //   await authService.updateUser(data);
  //   clearSignupControllers();
  //   notifyListeners();
  // }
  Future<void> updateUserProfile(
      String fullName,
      String age,
      String countryCode,
      String phoneNumber,
      String email,
      String profilepic) async {
    if (currentUser != null) {
      currentUser!.userName = fullName;
      currentUser!.age = age;
      // currentUser!.countryCode = countryCode;
      currentUser!.phoneNumber = phoneNumber;
      currentUser!.email = email;
      currentUser!.profilepic = profilepic;
      // Update the user profile in your backend/database
      await authService.updateUser(currentUser!);

      notifyListeners();
    }
  }

  Future<void> getOtp(phoneCon) async {
    await authService.getOtp(phoneCon);
    notifyListeners();
  }

  Future<void> verifyOtp(otp, context) async {
    await authService.verifyOtp(otp, context);
    notifyListeners();
  }

  countrySelection(value) {
    selectCountry = value;
    notifyListeners();
  }

  Future<void> showOtp() async {
    showOtpField = true;
    notifyListeners();
  }

  Future clearControllers() async {
    userNameController.clear();
    loginEmailController.clear();
    loginPasswordController.clear();
    phoneController.clear();
    createAgeController.clear();
    otpController.clear();
    notifyListeners();
  }

  onTabTapped(int index) {
    currentIndex = index;
    notifyListeners();
  }

  adminKey(context, SnackBarWidget snackBarWidget, {String? message}) async {
    try {
      if (loginEmailController.text == 'discover@gmail.com' &&
          loginPasswordController.text == '123') {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const AdminBottomBar()),
            (route) => false);
        clearControllers();
      } else {
        await loginWithEmail(
            loginEmailController.text, loginPasswordController.text);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => UserBottomScreen()),
            (route) => false);
        clearControllers();
      }
    } catch (error) {
      snackBarWidget.showErrorSnackbar(context, message!);
    }
  }

  Future<UserModel?> getUserById(String userId) async {
    try {
      UserModel? user = await authService.getUserById(userId);
      return user;
    } catch (e) {
      log('Error fetching user by ID in AuthenticationProvider: $e');
      return null;
    }
  }
}
