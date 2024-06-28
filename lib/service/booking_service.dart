// import 'dart:developer';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:discover/model/booking_model.dart';

// class BookingService {
//   final CollectionReference<BookingModel> booking;

//   BookingService()
//       : booking = FirebaseFirestore.instance
//             .collection('booking')
//             .withConverter<BookingModel>(
//               fromFirestore: (snapshot, _) =>
//                   BookingModel.fromJson(snapshot.id, snapshot.data()!),
//               toFirestore: (model, _) => model.toJson(),
//             );

//   Future<List<BookingModel>> getUserBooking(String userId) async {
//     final querySnapshot =
//         await booking.where('userId', isEqualTo: userId).get();
//     return querySnapshot.docs.map((doc) => doc.data()).toList();
//   }

//   Future<void> addBooking(BookingModel data) async {
//     try {
//       DocumentReference docRef = await booking.add(data);
//       data.id = docRef.id;
//       await docRef.set(data);
//     } catch (error) {
//       log('Error during adding booking: $error');
//       throw error;
//     }
//   }

//   Future<void> deleteBooking(String id) async {
//     try {
//       await booking.doc(id).delete();
//     } catch (error) {
//       log('Error during deleting booking: $error');
//     }
//   }

//   Future<List<BookingModel>> getAllBooking() async {
//     final snapshot = await booking.get();
//     return snapshot.docs.map((doc) => doc.data()).toList();
//   }

//   Future<void> updateBooking(String id, BookingModel data) async {
//     try {
//       await booking.doc(id).update(data.toJson());
//     } catch (error) {
//       log('Error in updating booking: $error');
//     }
//   }

//   Future<List<BookingModel>> getCanceledBooking(String userId) async {
//     final querySnapshot = await booking
//         .where('userId', isEqualTo: userId)
//         .where('status', isEqualTo: 'canceled')
//         .get();
//     return querySnapshot.docs.map((doc) => doc.data()).toList();
//   }
// }

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:travel/model/booking_model.dart';
import 'package:travel/model/review.model.dart';
import 'package:travel/model/user_model.dart';

class BookingPageService {
  String booking = 'booking';
  late CollectionReference<BookingModel> bookings;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Reference storage = FirebaseStorage.instance.ref();

  BookingPageService() {
    bookings = firebaseFirestore
        .collection(booking)
        .withConverter<BookingModel>(fromFirestore: (snapshot, options) {
      return BookingModel.fromJson(snapshot.id, snapshot.data()!);
    }, toFirestore: (value, options) {
      return value.toJson();
    });
  }

  updateUserDetails(UserModel data) async {
    try {
      await firebaseFirestore
          .collection(booking)
          .doc(firebaseAuth.currentUser!.uid)
          .update(data.toJson());
      log('Profile Updated Successfully');
    } catch (e) {
      throw 'Profile Update Error : $e';
    }
  }

  updateProfilePic(imageFile, {String? imagePath}) async {
    String imageName = await DateTime.now().millisecondsSinceEpoch.toString();
    try {
      Reference imageFolder =
          storage.child('UserProfile').child('$imageName.jpg');

      if (imagePath != null) {
        Reference deleteImage = storage.child(imagePath);
        await deleteImage.delete();
        log('The current Image Successfully deleted from Firebase Storage.');
      }

      await imageFolder.putFile(imageFile);
      log('Image successfully uploaded to Firebase Storage.');
      return imageFolder;
    } catch (e) {
      throw 'Error in Update profile pic : $e';
    }
  }

  Future<List<BookingModel>> getUserBooking(String userId) async {
    final querySnapshot =
        await bookings.where('userId', isEqualTo: userId).get();
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  Future<void> addBooking(BookingModel data) async {
    try {
      DocumentReference docRef = await bookings.add(data);
      data.id = docRef.id;
      await docRef.set(data);
    } catch (error) {
      log('Error during adding booking: $error');
      throw error;
    }
  }

  Future<void> deleteBooking(String id) async {
    try {
      await bookings.doc(id).delete();
    } catch (error) {
      log('error during deleting booking :$error');
    }
  }

  Future<List<BookingModel>> getAllBooking() async {
    final snapshot = await bookings.get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  Future<void> updateBooking(String id, BookingModel data) async {
    try {
      await bookings.doc(id).update(
            data.toJson(),
          );
    } catch (e) {
      log("error in updating booking : $e");
    }
  }

  Future<List<BookingModel>> getCanceledBooking(String userId) async {
    final querySnapshot = await bookings
        .where('userId', isEqualTo: userId)
        .where('status', isEqualTo: 'canceled')
        .get();
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  Future<UserModel?> getCurrentUser() async {
    try {
      if (firebaseAuth.currentUser != null) {
        DocumentSnapshot<Map<String, dynamic>> snapshot =
            await FirebaseFirestore.instance
                .collection(booking)
                .doc(firebaseAuth.currentUser?.uid)
                .get();

        if (snapshot.exists) {
          return UserModel.fromJson(snapshot.id as Map<String, dynamic>);
        } else {
          log("User does not exist in alluser collection");
          return null;
        }
      }
      {
        return null;
      }
    } on FirebaseException catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<List<UserModel>> getAllUser() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await firebaseFirestore.collection(booking).get();

      List<UserModel> data =
          snapshot.docs.map((e) => UserModel.fromJson(e.data())).toList();

      return data;
    } catch (e) {
      log('get error: $e');
      throw e;
    }
  }

  addReview(ReviewModel data) async {
    try {
      await firebaseFirestore
          .collection(booking)
          .doc(data.bookingId)
          .collection('review')
          .doc(data.reviewId)
          .set(data.toJson());
    } catch (e) {
      throw 'Error in add Review $e';
    }
  }

  getAllReviews(String bookingId) async {
    try {
      final data = await firebaseFirestore
          .collection(booking)
          .doc(bookingId)
          .collection('review')
          .get();
      return data.docs
          .map((item) => ReviewModel.fromJson(item.data()))
          .toList();
    } catch (e) {
      throw 'Error in getDat: $e';
    }
  }

  getMyReviews() async {
    try {
      final data = await firebaseFirestore
          .collection(booking)
          .doc()
          .collection('review')
          .get();
      return data.docs
          .map((item) => ReviewModel.fromJson(item.data()))
          .toList();
    } catch (e) {
      throw 'Error in get my reviews: $e';
    }
  }
}
