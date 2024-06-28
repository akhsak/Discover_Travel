import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/controller/admin_provider.dart';
import 'package:travel/controller/authentication_provider.dart';
import 'package:travel/view/authontication/Login/login_page.dart';
import 'package:travel/view/user/home/booking_details_page.dart';
import 'package:travel/widgets/expanded_trip_card.dart';
import 'package:travel/widgets/snackbar.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final authProvider = Provider.of<LoginProvider>(context, listen: false);

    Provider.of<AdminProvider>(context, listen: false).getAllTravelPackage();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F5F5),
        toolbarHeight: 100,
        title: Padding(
          padding: EdgeInsets.symmetric(vertical: size.height * .02),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Consumer<AdminProvider>(
                  builder: (context, adminProvider, child) {
                    return TextField(
                      controller: adminProvider.searchController,
                      onChanged: adminProvider.search,
                      decoration: const InputDecoration(
                        hintText: 'Search destination',
                        border: InputBorder.none,
                      ),
                    );
                  },
                ),
              ),
              const Icon(Icons.search),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.white,
                side: const BorderSide(color: Color.fromARGB(255, 5, 4, 4)),
              ),
              onPressed: () {
                alertSheet(
                  context,
                  alertMessage: 'ARE YOU SURE TO LOGOUT?',
                  onPressed: () async {
                    await authProvider.googleSignOut();
                    await FirebaseAuth.instance.signOut();

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                      (route) => false,
                    );
                  },
                  confirmButtonLabel: 'LOGOUT',
                );
              },
              child: const Text(
                'Logout',
                style: TextStyle(decoration: TextDecoration.underline),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Consumer<AdminProvider>(
          builder: (context, adminProvider, child) {
            if (adminProvider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (adminProvider.searchList.isEmpty &&
                adminProvider.searchController.text.isNotEmpty) {
              return Center(
                child: Center(child: Text('No items found')),
              );
            } else if (adminProvider.searchList.isEmpty &&
                adminProvider.allTravelList.isEmpty) {
              return Center(
                child: Text(
                  'No data available',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
              );
            } else {
              final allPackages = adminProvider.searchController.text.isEmpty
                  ? adminProvider.allTravelList
                  : adminProvider.searchList;
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: allPackages.length,
                itemBuilder: (context, index) {
                  final trips = allPackages[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookingDetailScreen(
                            isAdmin: true,
                            tripId: trips.id ?? 'unknown id',
                            placeName: trips.placeName ?? 'Unknown Place',
                            aboutTrip:
                                trips.aboutTrip ?? 'No description available',
                            location: trips.location ?? 'Unknown location',
                            duration: trips.duration ?? 'Unknown duration',
                            image: NetworkImage(trips.image ?? ''),
                            transportation: trips.transportation ??
                                'Unknown transportation',
                          ),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        expandedTripCard(context, trip: trips),
                        SizedBox(height: size.height * .02),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
