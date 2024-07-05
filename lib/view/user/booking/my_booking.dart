import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/controller/admin_provider.dart';
import 'package:travel/controller/authentication_provider.dart';
import 'package:travel/controller/booking_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travel/model/booking_model.dart';
import 'package:travel/view/user/booking/conform_payment.dart';
import 'package:travel/model/user_model.dart';
import 'package:travel/model/admin_model.dart';

class MyBooking extends StatelessWidget {
  const MyBooking({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Booking'),
      ),
      body: Consumer3<BookingProvider, LoginProvider, AdminProvider>(
        builder: (context, bookingProvider, logprovider, adminProvider, child) {
          final allBookingList = bookingProvider.allBookingList;
          final currentUser = FirebaseAuth.instance.currentUser;

          if (allBookingList.isEmpty) {
            return const Center(child: Text('No bookings found.'));
          }

          final userBookings = allBookingList
              .where((booking) => currentUser!.uid == booking.uId)
              .toList();

          if (userBookings.isEmpty) {
            return const Center(child: Text('No bookings found.'));
          }

          return ListView.builder(
            itemCount: userBookings.length,
            itemBuilder: (context, index) {
              final booking = userBookings[index];

              return FutureBuilder<UserModel?>(
                future: logprovider.getUserById(booking.uId!),
                builder: (context, userSnapshot) {
                  return FutureBuilder<AdminModel?>(
                    future: adminProvider.getTravelPackageById(
                        booking.id!), // Fetch admin data by ID
                    builder: (context, adminSnapshot) {
                      if (userSnapshot.connectionState ==
                              ConnectionState.waiting ||
                          adminSnapshot.connectionState ==
                              ConnectionState.waiting) {
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
                      } else if (userSnapshot.hasError ||
                          adminSnapshot.hasError) {
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
                        final adminData = adminSnapshot.data;
                        // return GestureDetector(
                        // onTap: () {
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => ConfirmPayment(
                        //         bookingData: booking,
                        //       ),
                        //     ),
                        //   );
                        // },
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: size.height * 0.13,
                                  width: size.width * 0.3,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    image: adminData?.image != null
                                        ? DecorationImage(
                                            image:
                                                NetworkImage(adminData!.image!),
                                            fit: BoxFit.cover,
                                          )
                                        : null,
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 0.05,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        adminData?.placeName ?? 'No Place Name',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: size.height * 0.01),
                                      Text(
                                        adminData?.location ?? 'No Location',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(height: size.height * 0.01),
                                      Text(
                                        booking.date ?? 'No Date',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(height: size.height * 0.01),
                                      RichText(
                                        text: const TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Details',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            TextSpan(
                                              text: '',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: size.height * 0.01),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    _showDeleteConfirmationDialog(
                                        context, bookingProvider, booking);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                        //  );
                      }
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context,
      BookingProvider bookingProvider, BookingModel booking) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this booking?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                bookingProvider.deleteBooking(booking.id!);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
