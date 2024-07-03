import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel/model/admin_model.dart';

class TravelService {
  String travelPackages = 'travel';
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late CollectionReference<AdminModel> travel;
  Reference storage = FirebaseStorage.instance.ref();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final ImagePicker imagePicker = ImagePicker();

  TravelService() {
    travel = firebaseFirestore
        .collection(travelPackages)
        .withConverter<AdminModel>(fromFirestore: (snapshot, options) {
      return AdminModel.fromJson(snapshot.id, snapshot.data()!);
    }, toFirestore: (value, options) {
      return value.toJson();
    });
  }

  Future<void> addTravelPackage(AdminModel data) async {
    try {
      DocumentReference docref = await travel.add(data);
      data.id = docref.id;
      await docref.set(data);
    } catch (e) {
      log('Error while adding travel :$e');
    }
  }

  Future<void> deleteTravelPackage(String id) async {
    try {
      await travel.doc(id).delete();
    } catch (e) {
      log('Error while deleting travel: $e');
    }
  }

  Future<List<AdminModel>> getAllTravelPackages() async {
    final snapshot = await travel.get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  Future<void> wishListClicked(String id, bool status) async {
    try {
      if (status == true) {
        await travel.doc(id).update({
          'wishlist': FieldValue.arrayUnion([
            firebaseAuth.currentUser!.email ??
                firebaseAuth.currentUser!.phoneNumber
          ])
        });
      } else {
        await travel.doc(id).update({
          'wishlist': FieldValue.arrayRemove([
            firebaseAuth.currentUser!.email ??
                firebaseAuth.currentUser!.phoneNumber
          ])
        });
      }
    } catch (e) {
      log('got a error of :$e');
    }
  }

  // uploadImages(file, {String? filePath}) async {
  //   String fileName = await DateTime.now().millisecondsSinceEpoch.toString();
  //   try {
  //     Reference fileFolder = storage.child('Item Image').child('$fileName');

  //     if (filePath != null) {
  //       Reference deletefile = storage.child(filePath);
  //       await deletefile.delete();
  //       log('The current file Successfully deleted from Firebase Storage.');
  //     }
  //     await fileFolder.putFile(file);
  //     log('file successfully uploaded to Firebase Storage.');
  //     return fileFolder;
  //   } catch (e) {
  //     throw 'Error in Update profile pic : $e';
  //   }
  // }

  // Future<String> uploadImage(imageName, imageFile) async {
  //   Reference imageFolder = storage.child('productImage');
  //   Reference? uploadImage = imageFolder.child('$imageName.jpg');

  //   await uploadImage.putFile(imageFile);
  //   String downloadURL = await uploadImage.getDownloadURL();
  //   log('Image successfully uploaded to Firebase Storage.');
  //   return downloadURL;
  // }
  Future<String> uploadImage(String imageName, File imageFile) async {
    try {
      Reference imageFolder = storage.child('productImage');
      Reference uploadImage = imageFolder.child('$imageName.jpg');

      await uploadImage.putFile(imageFile);
      String downloadURL = await uploadImage.getDownloadURL();
      log('Image successfully uploaded to Firebase Storage.');
      return downloadURL;
    } catch (e) {
      log('Error uploading image: $e');
      throw 'Error uploading image: $e';
    }
  }

  Future<File?> pickImage(ImageSource source) async {
    final pickedFile = await imagePicker.pickImage(source: source);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  // Future<AdminModel?> getTravelPackageById(String id) async {
  //   try {
  //     final DocumentSnapshot<AdminModel> snapshot = await travel.doc(id).get();
  //     return snapshot.data();
  //   } catch (e) {
  //     log('Error fetching travel package: $e');
  //     return null;
  //   }
  // }
}
