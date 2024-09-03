import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:travel/controller/admin_provider.dart';
import 'package:travel/main.dart';
import 'package:travel/view/user/booking/my_booking.dart';
import 'package:travel/widgets/bottombar.dart';

class PaymentScreen extends StatefulWidget {
  final tripId;
  const PaymentScreen({super.key, this.tripId});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final GlobalKey<FormState> formkey = GlobalKey();
  late TextEditingController amountController;
  late Razorpay razorpay;

  @override
  void initState() {
    super.initState();
    amountController = TextEditingController();
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  @override
  void dispose() {
    razorpay.clear();
    amountController.dispose();
    super.dispose();
  }

  Future<void> handlerPaymentSuccess(PaymentSuccessResponse response) async {
    Fluttertoast.showToast(
      msg: 'Payment Success: ${response.paymentId}',
      toastLength: Toast.LENGTH_SHORT,
    );

    var cartProvider = Provider.of<AdminProvider>(context, listen: false);
    if (cartProvider.allTravelList.isNotEmpty) {
      for (var item in cartProvider.allTravelList) {
        log('start add order');
        cartProvider.addOrder(item);
        log('start add updatecart');
        cartProvider.updateCart(id: item.id);
      }

      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        'your_channel_id',
        'your_channel_name',
        channelDescription: 'your_channel_description',
        importance: Importance.max,
        priority: Priority.high,
        showWhen: false,
      );
      const NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);
      await flutterLocalNotificationsPlugin.show(
        0,
        'Payment Successful',
        'Your payment was successful.',
        platformChannelSpecifics,
        payload: 'item x',
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => UserBottomScreen()),
      );
    } else {
      log('No items in the booking list');
    }
  }

  void handlerErrorFailure(PaymentFailureResponse response) {
    Fluttertoast.showToast(
      msg: 'Payment failed: ${response.message}',
      toastLength: Toast.LENGTH_SHORT,
    );
    log('Payment failed: ${response.message}');
  }

  void handlerExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
      msg: 'External Wallet: ${response.walletName}',
      toastLength: Toast.LENGTH_SHORT,
    );
    log('External Wallet: ${response.walletName}');
  }

  void _showConfirmationDialog({tripId}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Payment'),
          content:
              const Text('Are you sure you want to proceed with the payment?'),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop();
                var options = {
                  "key": "rzp_test_CYrnTOG3W2cDCB",
                  "amount": (num.parse(amountController.text) * 100).toString(),
                  "name": "Discover",
                  "description": "Payment for our product",
                  "prefill": {
                    "contact": "8590314865",
                    "email": "discover@gmail.com",
                  },
                  "external": {
                    "wallet": ["paytm"]
                  },
                };
                try {
                  razorpay.open(options);
                } catch (e) {
                  log('Error: $e');
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color.fromARGB(255, 14, 121, 243);
    const secondaryColor = Color.fromARGB(255, 9, 2, 104);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 5,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: const LinearGradient(
                    colors: [primaryColor, secondaryColor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Text(
                            '𝘿𝙞𝙨𝙘𝙤𝙫𝙚𝙧 𝙥𝙖𝙮𝙢𝙚𝙣𝙩',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          'Enter Amount',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: amountController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Enter the amount',
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter the amount";
                            }
                            if (num.tryParse(value) == null) {
                              return "Please enter a valid number";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              if (!formkey.currentState!.validate()) {
                                return;
                              }
                              formkey.currentState!.save();
                              _showConfirmationDialog(tripId: widget.tripId);
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: primaryColor,
                              backgroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Pay Now',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
