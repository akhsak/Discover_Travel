import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/controller/authentication_provider.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final forgetprovider = Provider.of<LoginProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: forgetprovider.forgotPasswordFormkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/icon_color.png', // Placeholder for the logo image
                height: 100,
              ),
              SizedBox(height: 20),
              Text(
                'Forget password',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Enter your email or phone we will send the verification code to reset your password',
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: forgetprovider.loginEmailController,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.endsWith('@gmail.com')) {
                    return 'Email must be a @gmail.com';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              SizedBox(height: 20),
              Center(
                child: SizedBox(
                  width: 360,
                  height: 62,
                  child: ElevatedButton(
                    onPressed: () {
                      if (forgetprovider.forgotPasswordFormkey.currentState!
                          .validate()) {
                        forgetprovider.forgotPassword(context,
                            email: forgetprovider.loginEmailController.text
                                .trim());
                      }
                      forgetprovider.clearLoginControllers();
                      // if (_formKey
                      //.currentState!.validate()) {
                      //   // Handle request code
                      // }
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>Createnewpassword()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      // padding: EdgeInsets.symmetric(horizontal: 40,),
                    ),
                    child: Text(
                      // 'Request code',
                      'submit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
