

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios,color: Colors.black,)),
        title: Text('Privacy Policy', style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),),
        // backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   'Privacy Policy',
              //   style: TextStyle(
              //     fontSize: 24,
              //     fontWeight: FontWeight.bold,
              //     color: Colors.black,
              //   ),
              // ),
              SizedBox(height: 16),
              Text(
                'This Privacy Policy describes how Travel Booking Agency collects, uses, and shares information when you use our mobile application Discover. By using the App, you agree to the collection and use of information in accordance with this policy.',
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              SizedBox(height: 16),
              Text(
                'We may collect several types of information for various purposes to provide and improve our service to you.',
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              SizedBox(height: 16),
              Text(
                'Personal Data:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'While using our Service, we may ask you to provide us with certain personally identifiable information that can be used to contact or identify you ("Personal Data"). This may include, but is not limited to:',
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name: Akhsa',
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                    Text(
                      'Email: akhsamariyam2k2@gmail.com',
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                    Text(
                      'Phone: +919876543210',
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                    Text(
                      'Location: Malappuram',
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Text(
                'We may also collect information on how the Service is accessed and used. This Usage Data may include information such as your device\'s Internet Protocol address (e.g., IP address).',
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

