import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReviewState extends ChangeNotifier {
  final List<Map<String, String>> reviews = [
    {
      'name': 'Jack Daniel',
      'date': 'Dec 2021',
      'review': 'Good Place',
      'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    },
  ];

  void addReview(String reviewText, String userName) {
    final String currentDate = DateFormat.yMMMd().format(DateTime.now());
    reviews.add({
      'name': userName,
      'date': currentDate,
      'review': reviewText,
      'description': 'New review description',
    });
    notifyListeners();
  }
}
