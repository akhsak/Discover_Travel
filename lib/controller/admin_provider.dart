import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel/model/admin_model.dart';
import 'package:travel/service/admin_service.dart';
import 'package:travel/service/booking_service.dart';
import 'package:travel/service/noti_service.dart';

class AdminProvider extends ChangeNotifier {
  File? pickedImage;
  String imageName = DateTime.now().microsecondsSinceEpoch.toString();
  String? downloadUrls;
  bool isLoading = false;
  bool isAddingData = false;
  //bool isImagePickerActive = false;

  final GlobalKey<FormState> packageAddFormkey = GlobalKey<FormState>();

  final TravelService travelService = TravelService();
  final ImagePicker imagePicker = ImagePicker();
  final FirebaseStorage storage = FirebaseStorage.instance;

  final TextEditingController searchController = TextEditingController();
  final TextEditingController placeNameController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController transportationController =
      TextEditingController();
  NotificationService notificationService = NotificationService();
  final BookingPageService bookingPageService = BookingPageService();
  List<AdminModel> searchList = [];
  List<AdminModel> allTravelList = [];
  List<AdminModel> allbookinglist = [];
  List<AdminModel> allbooking = [];

  void setIsAddingData(bool value) {
    isAddingData = value;
    notifyListeners();
  }

  void clearTravelControllers() {
    placeNameController.clear();
    aboutController.clear();
    locationController.clear();
    durationController.clear();
    amountController.clear();
    transportationController.clear();
    pickedImage = null;
  }

  Future<void> addTravelPackage(AdminModel data) async {
    await travelService.addTravelPackage(data);
    notifyListeners();
    await notificationService.showNotification(
      body: ' New Trip is Available',
      title: 'New Trip Unlocked',
    );
    getAllTravelPackage();
  }

  Future<void> deleteTravelPackage(String id) async {
    await travelService.deleteTravelPackage(id);
    getAllTravelPackage();
  }

  Future<void> getAllTravelPackage() async {
    isLoading = true;
    notifyListeners();
    allTravelList = await travelService.getAllTravelPackages();
    searchList = allTravelList;
    isLoading = false;
    notifyListeners();
  }

  Future<String> uploadImage(File image, String imageName) async {
    try {
      String downloadUrl = await travelService.uploadImage(imageName, image);
      log(downloadUrl);
      notifyListeners();
      return downloadUrl;
    } catch (e) {
      // log('got an error of $e');
      rethrow;
    }
  }

  // Future<void> getImage(ImageSource source) async {
  //   if (isImagePickerActive) {
  //     return; // Return immediately if the image picker is already active
  //   }

  //   isImagePickerActive = true;

  //   try {
  //     final pickedFile = await imagePicker.pickImage(source: source);

  //     if (pickedFile != null) {
  //       pickedImage = File(pickedFile.path);
  //       log("Image picked");
  //       notifyListeners();
  //     }
  //   } catch (e) {
  //     log('Image picker error: $e');
  //   } finally {
  //     isImagePickerActive = false;
  //   }
  // }
  Future getImage(ImageSource source) async {
    final pickedFile = await imagePicker.pickImage(source: source);

    if (pickedFile != null) {
      pickedImage = File(pickedFile.path);
      log("Image picked");
      notifyListeners();
    }
  }

  void search(String value) {
    if (value.isEmpty) {
      searchList = allTravelList;
    } else {
      searchList = allTravelList
          .where((AdminModel travel) =>
              travel.placeName!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  Future<void> wishlistClicked(String id, bool status) async {
    await travelService.wishListClicked(id, status);
    getAllTravelPackage();
  }

  bool wishListCheck(AdminModel package) {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final user = currentUser.email ?? currentUser.phoneNumber;
      return !package.wishList!.contains(user);
    } else {
      return true;
    }
  }

  void addOrder(AdminModel booked) {
    allbookinglist.add(booked);
    notifyListeners();
  }

  List<AdminModel> getOrders() {
    return allbookinglist;
  }

  Future<void> updateCart({id}) async {
    await bookingPageService.updateIsOrder(id);
  }

  Future<AdminModel?> getTravelPackageById(String id) async {
    try {
      return await travelService.getTravelPackageById(id);
    } catch (e) {
      log('Error fetching travel package by id: $e');
      return null;
    }
  }
  // Future<AdminModel?> getAdminDataById(String id) async {
  //   try {
  //     final DocumentSnapshot<AdminModel> snapshot =
  //         await travelService.travel.doc(id).get();
  //     return snapshot.data();
  //   } catch (e) {
  //     log('Error fetching admin data by id: $e');
  //     return null;
  //   }
}
