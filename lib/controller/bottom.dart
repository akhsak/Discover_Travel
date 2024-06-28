import 'package:flutter/material.dart';
import 'package:travel/view/admin/add_page.dart';
import 'package:travel/view/admin/admin_home_page.dart';
import 'package:travel/view/user/home/user_home_page.dart';
import 'package:travel/view/user/notification_page.dart';
import 'package:travel/view/user/profile/profile.dart';
import 'package:travel/view/user/wishlist.dart';

class BottomProvider extends ChangeNotifier {
  int currentIndex = 0;
  int adminCurrentIndex = 0;

  void onTap(index) {
    currentIndex = index;
    notifyListeners();
  }

  void adminOnTap(int index) {
    adminCurrentIndex = index;
    notifyListeners();
  }

  final List<Widget> screens = [
    UserHomepage(),
    WishList(),
    NotificationPage(),
    UserProfileScreen(),
  ];

  List adminScreens = [
    AdminHomeScreen(),
    AdminAddpage(),
  ];
}
