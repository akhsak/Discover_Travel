import 'package:flutter/material.dart';
import 'package:travel/widgets/bottombar.dart';

class BookingSucsess extends StatelessWidget {
  const BookingSucsess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.blue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(flex: 2),
            Image.asset(
              'assets/icon_white.png',
              height: 50,
              width: 50,
            ),
            // Icon(
            //   Icons.check_circle_outline,
            //   color: Colors.white,
            //   size: 100,
            // ),
            SizedBox(height: 20),
            Text(
              'Booking Successfully',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Get everything ready before your trips date',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            Spacer(flex: 3),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserBottomScreen()));
                  // Navigate back to home or perform another action
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.blue,
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text('Back to home'),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
