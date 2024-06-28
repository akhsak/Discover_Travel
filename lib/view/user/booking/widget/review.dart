import 'package:flutter/material.dart';

class ReviewCard extends StatelessWidget {
  final String name;
  final String date;
  final String review;
  final String description;

  const ReviewCard({
    Key? key,
    required this.name,
    required this.date,
    required this.review,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$name - $date',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(review),
            SizedBox(height: 8),
            Text(description),
          ],
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';

// class ReviewCard extends StatelessWidget {
//   final String name;
//   final String date;
//   final String review;

//   const ReviewCard({
//     Key? key,
//     required this.name,
//     required this.date,
//     required this.review,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: ListTile(
//         title: Text(name),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(date, style: TextStyle(fontSize: 12, color: Colors.grey)),
//             SizedBox(height: 5),
//             Text(review),
//           ],
//         ),
//       ),
//     );
//   }
// }
