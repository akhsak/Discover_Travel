class BookingModel {
  String? id;
  String? uId;
  String? idd;
  String? travelId;
  String? date;
  String? gestNo;

  BookingModel({
    this.id,
    this.idd,
    this.uId,
    this.travelId,
    this.date,
    this.gestNo,
  });

  factory BookingModel.fromJson(String id, Map<String, dynamic> json) {
    return BookingModel(
      id: id,
      idd: json['idd'],
      uId: json['userId'],
      travelId: json['docId'],
      date: json['date'],
      gestNo: json['gestNo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': uId,
      'idd': idd,
      'travelId': travelId,
      'id': id,
      'date': date,
      'gestNo': gestNo,
    };
  }
}
