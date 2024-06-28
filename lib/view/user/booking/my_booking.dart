import 'package:flutter/material.dart';

class MyBooking extends StatelessWidget {
  const MyBooking({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      title: Text('My Booking'),
      leading: IconButton(onPressed: (){
        Navigator.pop(context);
      }, icon: Icon(Icons.arrow_back_ios)),
    ),
    );
  }
}