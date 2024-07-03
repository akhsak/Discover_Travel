import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/controller/admin_provider.dart';
import 'package:travel/controller/authentication_provider.dart';
import 'package:travel/controller/booking_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travel/view/user/booking/conform_payment.dart';
import 'package:travel/model/user_model.dart';

class MyBooking extends StatelessWidget {
  const MyBooking({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Booking'),
      ),
      body: Consumer3<BookingProvider, LoginProvider, AdminProvider>(
        builder: (context, bookingProvider, logprovider, adminProvider, child) {
          final allBookingList = bookingProvider.allBookingList;
          if (allBookingList.isEmpty) {
            return const Center(child: Text('No bookings found.'));
          }

          return ListView.builder(
            itemCount: allBookingList.length,
            itemBuilder: (context, index) {
              final booking = allBookingList[index];
              final currentUser = FirebaseAuth.instance.currentUser;

              if (currentUser!.uid == booking.uId) {
                return FutureBuilder<UserModel?>(
                  future: logprovider.getUserById(booking.uId!),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Card(
                        elevation: 4.0,
                        margin: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: ListTile(
                          title: const Text('Loading...'),
                          subtitle: Text(booking.date ?? 'No Date'),
                          onTap: () {},
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Card(
                        elevation: 4.0,
                        margin: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: ListTile(
                          title: const Text('Error'),
                          subtitle: Text(booking.date ?? 'No Date'),
                          onTap: () {},
                        ),
                      );
                    } else {
                      final user = snapshot.data;
                      return Card(
                        elevation: 4.0,
                        margin: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: ListTile(
                          title: Text(user?.userName ??
                              'No Name'), // Adjust according to UserModel properties
                          subtitle: Text(booking.date ?? 'No Date'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ConfirmPayment(
                                  bookingData: booking,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                  },
                );
              }
              return Container();
            },
          );
        },
      ),
    );
  }
}
