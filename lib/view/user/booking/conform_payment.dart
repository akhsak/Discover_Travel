import 'package:flutter/material.dart';

import 'package:travel/model/booking_model.dart';
import 'package:travel/view/user/payment/payment.dart';

class ConfirmPayment extends StatelessWidget {
  final BookingModel bookingData;

  ConfirmPayment({required this.bookingData});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirm Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Confirm Your Booking Details',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Name: ${bookingData.name}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Email: ${bookingData.email}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Guest No: ${bookingData.gestNo}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Phone Number: ${bookingData.phoneNumber}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Booking Date: ${bookingData.date}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'ID Number:${bookingData.travelId}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: screenHeight * .5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 190,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17),
                        ),
                        backgroundColor: Color.fromARGB(255, 244, 240, 240),
                      ),
                      child: const Text('Back',
                          style: TextStyle(
                              color: Color.fromARGB(255, 133, 133, 133),
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  //  child: Text('Go Back')),
                  SizedBox(
                    width: screenWidth * .4,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PaymentScreen()));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Payment confirmed!')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.02,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        'Confirm',
                        style: TextStyle(fontSize: 13, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
