import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:travel/controller/admin_provider.dart';
import 'package:travel/model/admin_model.dart';
import 'package:travel/view/user/booking/widget/reviewsection_widget.dart';
import 'package:travel/view/user/home/detail_booking_page.dart';

class BookingDetailPage extends StatelessWidget {
  final AdminModel? allbooking;
  final String? placeName;

  final String? aboutTrip;
  final String? location;
  final ImageProvider? image;
  final String? duration;
  final transportation;
  String? tripId;
  final bool? isAdmin;

  BookingDetailPage({
    super.key,
    this.allbooking,
    this.placeName,
    this.aboutTrip,
    this.location,
    this.image,
    this.duration,
    this.transportation,
    this.tripId,
    this.isAdmin,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final adminProvider = Provider.of<AdminProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Booking',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        actions: isAdmin!
            ? [
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Delete Trip'),
                        content: const Text(
                            'Are you sure you want to delete this trip?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              adminProvider.deleteTravelPackage(tripId!);
                              Navigator.pop(context);
                              Navigator.pop(
                                  context); // Go back to the previous screen
                            },
                            child: const Text(
                              'Delete',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(Icons.delete, color: Colors.red),
                ),
              ]
            : null,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: size.height * 0.3,
                  width: size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: image!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  child: Container(
                    color: Colors.black54,
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      placeName!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'About',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      travelDetailsText(
                        value: aboutTrip!,
                        color: const Color.fromARGB(255, 7, 7, 7),
                        fontsize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                      const SizedBox(height: 40),
                      const Divider(color: Colors.grey),
                      const SizedBox(height: 30),
                      const Text(
                        'What is included',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              side: const BorderSide(
                                color: Color.fromARGB(255, 205, 198, 198),
                              ),
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                            ),
                            icon: const Icon(Icons.train, color: Colors.black),
                            label: travelDetailsText(
                              value: '$transportation\nTransportation',
                              color: const Color.fromARGB(255, 7, 7, 7),
                              fontsize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: size.width * 0.03),
                          ElevatedButton.icon(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              side: const BorderSide(
                                color: Color.fromARGB(255, 205, 198, 198),
                              ),
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                            ),
                            icon: const Icon(Icons.punch_clock,
                                color: Colors.black),
                            label: travelDetailsText(
                              value: '$duration\nDuration',
                              color: const Color.fromARGB(255, 7, 7, 7),
                              fontsize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 50),
                        ],
                      ),
                      const SizedBox(height: 40),
                      const Divider(color: Colors.grey),
                      const SizedBox(height: 40),
                      const Text(
                        'Where will you stay',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        placeName!,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 10),
                      Image.asset(
                        'assets/download.jpg', // Placeholder for the map image
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        location!,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            //   child: Image(image: image,
                            // ),

                            child: Image.asset(
                              'assets/splash1.img.jpeg',
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            // child: Image(image: image),

                            child: Image.asset(
                              'assets/splash1.img.jpeg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 170),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                                side: const BorderSide(
                                  color: Color.fromARGB(255, 205, 198, 198),
                                ),
                              ),
                            ),
                            child: const Text(
                              'See all photos',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const ReviewSection(),
                      const SizedBox(height: 20),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              //'\$600/Person',
                              '₹600 Amount',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                            SizedBox(
                                width: 200,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DetailBooking(tripId: tripId)
                                          //DatePage(),
                                          ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 40,
                                      vertical: 20,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  child: const Text(
                                    'Book Now',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ))
                          ])
                    ])),
          ],
        ),
      ),
    );
  }

  Widget travelDetailsText({
    required String value,
    required Color color,
    required double fontsize,
    required FontWeight fontWeight,
  }) {
    return Text(
      value,
      style: TextStyle(
        color: color,
        fontSize: fontsize,
        fontWeight: fontWeight,
      ),
    );
  }
}
