class UserModel {
  String? uId;
  String? userName;
  String? email;
  String? phoneNumber;
  String? age;
  String? profilepic;

  UserModel({
    this.uId,
    this.userName,
    this.email,
    this.age,
    this.phoneNumber,
    this.profilepic,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        uId: json['userId'],
        userName: json['name'],
        age: json['age'],
        email: json['email'],
        phoneNumber: json['phoneNumber'],
        profilepic: json['profilepic']);
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': uId,
      'name': userName,
      'age': age,
      'email': email,
      'phoneNumber': phoneNumber,
      'profilePic': profilepic,
    };
  }
}
