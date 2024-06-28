// import 'package:discover/model/admin_model.dart';

// class BookingModel {
//   String? id;
//   String? uId;
//   String? travelId;
//   String? date;
//   String? name;
//   String? gestNo;
//   String? email;
//   String? phoneNumber;

//   AdminModel? travel;

//   BookingModel(
//       {this.id,
//       this.uId,
//       this.travelId,
//       this.date,
//       this.name,
//       this.email,
//       this.gestNo,
//       this.phoneNumber,
//       this.travel});

//   factory BookingModel.fromJson(String id, Map<String, dynamic> json) {
//     return BookingModel(
//       id: id,
//       uId: json['userId'],
//       travelId: json['docId'],
//       date: json['date'],
//       name: json['name'],
//       gestNo: json['gestNo'],
//       email: json['email'],
//       phoneNumber: json['phoneNumber'],
//       travel: null,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'userId': uId,
//       'travelId': travelId,
//       'id': id,
//       'date': date,
//       'name': name,
//       'gestNo': gestNo,
//       'email': email,
//       'phoneNumber': phoneNumber,
//     };
//   }
// }

import 'package:travel/model/admin_model.dart';

class BookingModel {
  String? id;
  String? uId;
  String? travelId;
  String? date;
  String? name;
  String? gestNo;
  String? email;
  String? phoneNumber;

  AdminModel? travel;

  BookingModel(
      {this.id,
      this.uId,
      this.travelId,
      this.date,
      this.name,
      this.email,
      this.gestNo,
      this.phoneNumber,
      this.travel});

  factory BookingModel.fromJson(String id, Map<String, dynamic> json) {
    return BookingModel(
      id: id,
      uId: json['userId'],
      travelId: json['docId'],
      date: json['date'],
      name: json['name'],
      gestNo: json['gestNo'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      travel: null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': uId,
      'travelId': travelId,
      'id': id,
      'date': date,
      'name': name,
      'gestNo': gestNo,
      'email': email,
      'phoneNumber': phoneNumber,
    };
  }
}
