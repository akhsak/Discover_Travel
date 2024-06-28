import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TermsCondition extends StatelessWidget {
  const TermsCondition({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms & Conditions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            buildSectionTitle('1. Booking Information:'),
            buildSectionContent(
                'Users can book travel services like flights, accommodations, and activities. Provide accurate personal and payment details for bookings.'),
            buildSectionTitle('2. Payments:'),
            buildSectionContent(
                'Users are responsible for payments using accepted methods. Prices subject to change based on availability.'),
            buildSectionTitle('3. Cancellations and Refunds:'),
            buildSectionContent(
                'Policies vary by service provider. Refunds follow provider cancellation policies.'),
            buildSectionTitle('4. User Conduct:'),
            buildSectionContent('Use Discover lawfully and responsibly.'),
            buildSectionTitle('5. Intellectual Property:'),
            buildSectionContent('All content is property of Travel Booking.'),
            buildSectionTitle('6. Privacy Policy:'),
            buildSectionContent(
                'Personal data collected and processed according to Privacy Policy.'),
            buildSectionTitle('7. Disclaimer:'),
            buildSectionContent(
                'Discover does not guarantee information accuracy. Not liable for losses due to app use.'),
            buildSectionTitle('8. Changes to Terms and Conditions:'),
            buildSectionContent(
                'Travel Booking reserves right to update terms.'),
            SizedBox(height: 20),
            Text(
              'By using Discover, you accept these terms. If not, please refrain from using the app.',
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget buildSectionContent(String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        content,
        style: TextStyle(fontSize: 14, color: Colors.black87),
      ),
    );
  }
}
