import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:travel/model/notification_model.dart';

class NotificationService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String notifications = 'notification';
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  late CollectionReference<NotificationModel> notification;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('medheal');

    var initializationSettingsIOS = const DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {},
    );
  }

  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channelId',
        'channelName',
        importance: Importance.max,
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    await notificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails(),
      payload: payload,
    );
  }

  NotificationService() {
    notification = firebaseFirestore
        .collection(notifications)
        .withConverter<NotificationModel>(fromFirestore: (snapshot, options) {
      return NotificationModel.fromJson(snapshot.id, snapshot.data()!);
    }, toFirestore: (value, options) {
      return value.toJson();
    });
  }

  Future<void> notifyAllUsers({
    required String locationName,
    required String place,
  }) async {
    final usersSnapshot = await firebaseFirestore.collection('user').get();
    for (var userDoc in usersSnapshot.docs) {
      String userId = userDoc.id;
      NotificationModel notification = NotificationModel(
        recieverId: userId,
        title: 'New Package Added ',
        body: 'location.$locationName and place $place',
      );
      await addNotification(notification);
    }
  }

  Future<void> addNotification(NotificationModel data) async {
    try {
      DocumentReference docRef = await notification.add(data);
      data.id = docRef.id;
      await docRef.set(data);
    } catch (error) {
      log('Error during adding package: $error');
      rethrow;
    }
  }

  Future<List<NotificationModel>> getAllNotification() async {
    final snapshot = await notification.get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  Future<void> deleteNotification(String notificationId) async {
    try {
      await notification.doc(notificationId).delete();
    } catch (error) {
      log('Error deleting notification with id $notificationId: $error');
      rethrow;
    }
  }

  Future<void> updateNotificationReadStatus(
      String notificationId, bool read) async {
    try {
      await notification.doc(notificationId).update({'read': read});
    } catch (error) {
      log('Error updating read status for notification with id $notificationId: $error');
      rethrow;
    }
  }
}
