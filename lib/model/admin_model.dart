class AdminModel {
  String? id;
  String? placeName;
  String? location;
  String? duration;
  String? transportation;
  String? aboutTrip;
  List? wishList;
  String? image;

  AdminModel({
    this.id,
    this.image,
    this.placeName,
    this.location,
    this.duration,
    this.transportation,
    this.aboutTrip,
    this.wishList,
  });

  factory AdminModel.fromJson(Map<String, dynamic> json) {
    return AdminModel(
        id: json['id'],
        image: json['image'],
        // (json['image'] as List<dynamic>?)
        //     ?.map((item) => item as String)
        //     .toList(),
        placeName: json['fullName'],
        duration: json['duration'],
        transportation: json['transportation'],
        location: json['location'],
        aboutTrip: json['aboutTrip'],
        wishList: List<String>.from(json['wishlist']));
    // (json['wishlist'] as List<dynamic>?)
    //     ?.map((item) => item as String)
    //     .toList(),
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'fullName': placeName,
      'location': location,
      'duration': duration,
      'transportation': transportation,
      'aboutTrip': aboutTrip,
      'wishlist': wishList,
    };
  }
}
