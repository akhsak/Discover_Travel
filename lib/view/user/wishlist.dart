import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/controller/admin_provider.dart';
import 'package:travel/model/admin_model.dart';
import 'package:travel/view/user/home/booking_details_page.dart';

class WishList extends StatelessWidget {
  WishList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'WishList',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Consumer<AdminProvider>(builder: (context, value, child) {
              final wishlistItems = checkUser(value);

              if (wishlistItems.isEmpty) {
                return Center(
                  child: Text('No items in your wishlist.'),
                );
              }

              return ListView.builder(
                itemCount: wishlistItems.length,
                itemBuilder: (context, index) {
                  final item = wishlistItems[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookingDetailPage(
                            placeName: item.placeName!,
                            aboutTrip: item.aboutTrip!,
                            location: item.location!,
                            image: NetworkImage(item.image.toString()),
                            duration: item.duration!,
                            transportation: item.transportation!,
                            tripId: item.id ?? 'unknown id',
                            isAdmin: false,
                          ),
                        ),
                      );
                    },
                    child: Card(
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
                                image: item.image != null
                                    ? DecorationImage(
                                        image: NetworkImage(item.image!),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.placeName ?? 'Unknown',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: size.height * 0.01),
                                  Text(
                                    item.location ?? 'Unknown location',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: size.height * 0.01),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'From \$25',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '/person',
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
                                  SizedBox(
                                    height: size.height * 0.03,
                                    width: size.height * 0.16,
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        side: const BorderSide(
                                          color: Color.fromARGB(
                                              255, 205, 198, 198),
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(0),
                                        ),
                                      ),
                                      child: Text(
                                        item.duration ?? 'Unknown duration',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color:
                                              Color.fromARGB(255, 54, 52, 52),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Consumer<AdminProvider>(
                              builder: (context, value, child) {
                                final wish = value.wishListCheck(item);
                                return IconButton(
                                  onPressed: () {
                                    value.wishlistClicked(item.id!, wish);
                                  },
                                  icon: Icon(
                                    wish
                                        ? Icons.favorite_border
                                        : Icons.favorite,
                                    color: Colors.red,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  List<AdminModel> checkUser(AdminProvider adminProvider) {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return [];
    }
    final user = currentUser.email ?? currentUser.phoneNumber;
    return adminProvider.allTravelList
        .where((travel) => travel.wishList!.contains(user))
        .toList();
  }
}
