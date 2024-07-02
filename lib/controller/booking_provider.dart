import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travel/model/booking_model.dart';
import 'package:travel/service/booking_service.dart';

class BookingProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  final guestNameController = TextEditingController();
  final guestNumberController = TextEditingController();
  final countryCodeController = TextEditingController(text: '+91');
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final idNumberController = TextEditingController();
  TextEditingController userBookingDateController = TextEditingController();

  bool obscureText = true;

  // final BookingService bookingService = BookingService();
  final BookingPageService bookingService = BookingPageService();

  final appointmentFormKey = GlobalKey<FormState>();

  List<BookingModel> allBookingList = [];
  bool isLoading = false;

  String? selectedDate;
  String? selectedTime;

  void idPasswordVisibility() {
    obscureText = !obscureText;
    notifyListeners();
  }

  void setSelectedTime(String time) {
    selectedTime = selectedTime == time ? null : time;
    notifyListeners();
  }

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void setSelectedDate(String date) {
    selectedDate = date;
    notifyListeners();
  }

  Future<bool> addBooking(BookingModel data, Function(String) onError) async {
    setLoading(true);
    bool success = false;
    try {
      await bookingService.addBooking(data);
      clearBookingControllers();
      await getAllBooking();
      success = true;
    } catch (error) {
      log('Error during adding boooking: $error');
      onError('Slot is already booked');
    }
    setLoading(false);
    return success;
  }

  Future<void> deleteBooking(String id) async {
    setLoading(true);
    await bookingService.deleteBooking(id);
    await getAllBooking();
    setLoading(false);
  }

  Future<void> getAllBooking() async {
    setLoading(true);
    allBookingList = await bookingService.getAllBooking();
    setLoading(false);
  }

  Future<void> updateBooking(String id, BookingModel data) async {
    setLoading(true);
    await bookingService.updateBooking(id, data);
    await getAllBooking();
    setLoading(false);
  }

  void clearBookingControllers() {
    userBookingDateController.clear();
    guestNameController.clear();
    guestNumberController.clear();
    countryCodeController.clear();
    phoneController.clear();
    emailController.clear();
    idNumberController.clear();
    selectedTime = null;
    notifyListeners();
  }

  Future<void> getUserBookings() async {
    setLoading(true);
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      allBookingList = await bookingService.getUserBooking(userId);
      setLoading(false);
    } catch (error) {
      setLoading(false);
      rethrow;
    }
  }

  List<BookingModel> canceledAppointmentList = [];

  Future<void> getUserCanceledBookings() async {
    setLoading(true);
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      canceledAppointmentList = await bookingService.getCanceledBooking(userId);
      setLoading(false);
    } catch (error) {
      setLoading(false);
      log('Error fetching user canceled appointments: $error');
      throw error;
    }
  }
}
