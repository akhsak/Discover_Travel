// import 'package:flutter/material.dart';

// class MyBooking extends StatelessWidget {
//   const MyBooking({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My Booking'),
//         leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: Icon(Icons.arrow_back_ios)),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/controller/admin_provider.dart';
import 'package:travel/controller/authentication_provider.dart';
import 'package:travel/model/admin_model.dart';
import 'package:travel/model/booking_model.dart';
import 'package:travel/view/user/home/booking_details_page.dart';
import 'package:travel/view/user/home/detail_booking_page.dart';

class MyBooking extends StatelessWidget {
  const MyBooking({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
      ),
      body: Consumer<AdminProvider>(
        builder: (context, cartProvider, child) {
          return ListView.builder(
            itemCount: cartProvider.getOrders().length,
            itemBuilder: (context, index) {
              final order = cartProvider.getOrders()[index];
              return Card(
                elevation: 4.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: ListTile(
                  leading: SizedBox(
                    width: 50,
                    height: 50,
                    child: Image.network(
                      order.image!,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(order.placeName!),
                  subtitle: Text(order.location!),
                  onTap: () {
                    final product = AdminModel(
                      image: order.image,
                      id: order.id,
                      aboutTrip: order.aboutTrip,
                      duration: order.duration,
                      location: order.location,
                      placeName: order.placeName,
                      transportation: order.transportation,

                      // description: 'Product description here',
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookingDetailPage(
                          allbooking: product,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
