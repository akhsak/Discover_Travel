// import 'package:discover/controller/admin_provider.dart';
// import 'package:discover/model/admin_model.dart';
// import 'package:discover/view/user/wishlist.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class SearchPage extends StatelessWidget {
//   const SearchPage({Key? key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios, color: Colors.black),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: Container(
//           padding:
//               EdgeInsets.symmetric(horizontal: 8.0), // Adjust padding as needed
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             border: Border.all(
//               color: Colors.grey,
//               width: 1.0,
//             ),
//           ),
//           child: TextField(
//             decoration: InputDecoration(
//               hintText: 'Where do you plan to go?',
//               border: InputBorder.none,
//               // contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
//               suffixIcon: Icon(Icons.search),
//             ),
//             onSubmitted: (value) {},
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Search bar
//             // TextField(
//             //   decoration: InputDecoration(
//             //     prefixIcon: Icon(Icons.search),
//             //     hintText: 'Where do you plan to go?',
//             //     border: OutlineInputBorder(
//             //       borderRadius: BorderRadius.circular(8),
//             //       borderSide: BorderSide.none,
//             //     ),
//             //     fillColor: Colors.grey[200],
//             //     filled: true,
//             //   ),
//             // ),
//             SizedBox(height: 16),
//             // Recommended section
//             Text(
//               'Recommended',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 16),
//             Expanded(
//               child: ListView(
//                 children: [
//                   recommendedCard(context, 'Long-Tail Boat Charter',
//                       'assets/splash1.img.jpeg'),
//                   recommendedCard(
//                       context, 'Koh Rong Samloem', 'assets/splash1.img.jpeg'),
//                   recommendedCard(
//                       context, 'Tokyo, Japan', 'assets/splash1.img.jpeg'),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget recommendedCard(BuildContext context, String title, String imagePath) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Stack(
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(8),
//                 child: Image.asset(
//                   imagePath,
//                   fit: BoxFit.cover,
//                   width: double.infinity,
//                   height: 200,
//                 ),
//               ),
//               Positioned(
//                 top: 8,
//                 right: 8,
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: IconButton(
//                     icon: Icon(Icons.favorite_border),
//                     onPressed: () {
//                       final adminProvider =
//                           Provider.of<AdminProvider>(context, listen: false);
//                       final tripPackage = adminProvider.allTravelList.first;
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (context) => WishList()));
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 8),
//           Text(
//             title,
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           Text(
//             'Lorem ipsum dolor sit amet.',
//             style: TextStyle(color: Colors.grey),
//           ),
//         ],
//       ),
//     );
//   }
// }
//  // return Scaffold(
//     //   appBar: AppBar(
//     //     leading: IconButton(
//     //       onPressed: () {
//     //         Navigator.pop(context);
//     //       },
//     //       icon: Icon(Icons.arrow_back_ios),
//     //     ),
//     //     title: Container(
//     //       padding: EdgeInsets.symmetric(horizontal: 8.0), // Adjust padding as needed
//     //       decoration: BoxDecoration(
//     //         borderRadius: BorderRadius.circular(10),
//     //         border: Border.all(
//     //           color: Colors.grey,
//     //           width: 1.0,
//     //         ),
//     //       ),
//     //       child: TextField(
//     //         decoration: InputDecoration(
//     //           hintText: 'Search destination',
//     //           border: InputBorder.none,
//     //           // contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
//     //           suffixIcon: Icon(Icons.search),
//     //         ),
//     //         onSubmitted: (value) {},
//     //       ),
//     //     ),
//     //   ),
//     //   body: Container(),
//     // );