import 'package:travel/model/admin_model.dart';

class BookingModel {
  String? id;
  String? uId;
  String? travelId;
  String? date;
  String? gestNo;

  BookingModel({
    this.id,
    this.uId,
    this.travelId,
    this.date,
    this.gestNo,
  });

  factory BookingModel.fromJson(String id, Map<String, dynamic> json) {
    return BookingModel(
      id: id,
      uId: json['userId'],
      travelId: json['docId'],
      date: json['date'],
      gestNo: json['gestNo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': uId,
      'travelId': travelId,
      'id': id,
      'date': date,
      'gestNo': gestNo,
    };
  }
}
