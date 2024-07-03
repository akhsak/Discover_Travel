import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:travel/controller/authentication_provider.dart';
import 'package:travel/controller/revie_controller.dart';
import 'review.dart';

class ReviewSection extends StatelessWidget {
  const ReviewSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final reviewState = Provider.of<ReviewState>(context);
    final userName =
        Provider.of<LoginProvider>(context).currentUser?.userName ??
            'Anonymous';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Reviews',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            Text('( ${reviewState.reviews.length} reviews)',
                style: TextStyle(color: Colors.grey)),
            Spacer(),
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    TextEditingController reviewController =
                        TextEditingController();
                    return AlertDialog(
                      title: Text('Add a Review'),
                      content: TextField(
                        controller: reviewController,
                        decoration: InputDecoration(
                          hintText: 'Write your review here',
                        ),
                        maxLines: 3,
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            reviewState.addReview(
                                reviewController.text, userName);
                            Navigator.pop(context);
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: Icon(Icons.message),
            ),
          ],
        ),
        SizedBox(height: 10),
        Column(
          children: reviewState.reviews.map((review) {
            return ReviewCard(
              name: review['name']!,
              date: review['date']!,
              review: review['review']!,
              description: review['description']!,
            );
          }).toList(),
        ),
      ],
    );
  }
}
