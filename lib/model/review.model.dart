import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  String? content;
  String? username;
  String? userPic;
  String? uId;
  String? reviewId;
  String? bookingId;
  int? like;
  DateTime? timeStamp;
  ReviewModel(
      {this.content,
      this.bookingId,
      this.username,
      this.reviewId,
      this.userPic,
      this.timeStamp,
      this.uId,
      this.like});
  factory ReviewModel.fromJson(json) {
    return ReviewModel(
      uId: json['uId'],
      reviewId: json['reviewId'],
      bookingId: json['courseId'],
      content: json['content'],
      like: json['like'],
      timeStamp: json['timeStamp'] != null
          ? (json['timeStamp'] as Timestamp).toDate()
          : null,
    );
  }
  toJson() {
    return {
      'uId': uId,
      'reviewId': reviewId,
      'courseId': bookingId,
      'content': content,
      'like': like,
      'timeStamp': timeStamp,
    };
  }
}
