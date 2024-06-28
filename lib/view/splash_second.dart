import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/controller/authentication_provider.dart';
import 'package:travel/view/authontication/Login/login_page.dart';
import 'package:travel/widgets/bottombar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    goToLogin(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 200,
          height: 150,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/splash_icon.png'),
          )),
        ),
      ),
    );
  }

  goToLogin(context) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    final UserPrvd = Provider.of<LoginProvider>(context, listen: false);

    if (currentUser == null) {
      await Future.delayed(
        Duration(seconds: 2),
      );
      return Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    } else {
      CircularProgressIndicator();
      await UserPrvd.getUser();
      await Future.delayed(
        Duration(seconds: 2),
      );
      return Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => UserBottomScreen()));
    }
  }
}
