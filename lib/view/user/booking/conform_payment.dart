// import 'package:flutter/material.dart';
// import 'package:travel/model/booking_model.dart';
// import 'package:travel/model/user_model.dart';
// import 'package:travel/service/authontication.dart';
// import 'package:travel/view/user/payment/payment.dart';

// class ConfirmPayment extends StatefulWidget {
//   final tripId;
//   final BookingModel bookingData;

//   const ConfirmPayment({Key? key, required this.bookingData, this.tripId})
//       : super(key: key);

//   @override
//   _ConfirmPaymentState createState() => _ConfirmPaymentState();
// }

// class _ConfirmPaymentState extends State<ConfirmPayment> {
//   UserModel? user;

//   @override
//   void initState() {
//     super.initState();
//     fetchUser();
//   }

//   Future<void> fetchUser() async {
//     AuthService authService = AuthService();
//     UserModel? fetchedUser =
//         await authService.getUserById(widget.bookingData.uId!);
//     setState(() {
//       user = fetchedUser;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;
//     double screenWidth = MediaQuery.of(context).size.width;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Confirm Payment'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Confirm Your Booking Details',
//                 style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 20),
//               user != null
//                   ? Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Name: ${user!.userName}',
//                           style: const TextStyle(fontSize: 18),
//                         ),
//                         const SizedBox(height: 10),
//                         Text(
//                           'Email: ${user!.email}',
//                           style: const TextStyle(fontSize: 18),
//                         ),
//                         const SizedBox(height: 10),
//                         Text(
//                           'Phone Number: ${user!.phoneNumber}',
//                           style: const TextStyle(fontSize: 18),
//                         ),
//                       ],
//                     )
//                   : const Center(child: CircularProgressIndicator()),
//               const SizedBox(height: 10),
//               Text(
//                 'Guest No: ${widget.bookingData.gestNo}',
//                 style: const TextStyle(fontSize: 18),
//               ),
//               const SizedBox(height: 10),
//               Text(
//                 'Booking Date: ${widget.bookingData.date}',
//                 style: const TextStyle(fontSize: 18),
//               ),
//               const SizedBox(height: 10),
//               Text(
//                 'ID Number: ${widget.bookingData.travelId}',
//                 style: const TextStyle(fontSize: 18),
//               ),
//               SizedBox(height: screenHeight * .43),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   SizedBox(
//                     width: 190,
//                     height: 50,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       style: ElevatedButton.styleFrom(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(17),
//                         ),
//                         backgroundColor:
//                             const Color.fromARGB(255, 244, 240, 240),
//                       ),
//                       child: const Text(
//                         'Back',
//                         style: TextStyle(
//                           color: Color.fromARGB(255, 133, 133, 133),
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: screenWidth * .4,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => PaymentScreen(
//                               tripId: widget.tripId,
//                             ),
//                           ),
//                         );
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(content: Text('Payment confirmed!')),
//                         );
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blue,
//                         padding: EdgeInsets.symmetric(
//                           vertical: screenHeight * 0.02,
//                         ),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(16),
//                         ),
//                       ),
//                       child: const Text(
//                         'Confirm',
//                         style: TextStyle(fontSize: 13, color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:travel/model/booking_model.dart';
import 'package:travel/model/user_model.dart';
import 'package:travel/service/authontication.dart';
import 'package:travel/view/user/payment/payment.dart';
import 'package:travel/widgets/container.dart';

class ConfirmPayment extends StatefulWidget {
  final tripId;
  final BookingModel bookingData;

  const ConfirmPayment({Key? key, required this.bookingData, this.tripId})
      : super(key: key);

  @override
  _ConfirmPaymentState createState() => _ConfirmPaymentState();
}

class _ConfirmPaymentState extends State<ConfirmPayment> {
  UserModel? user;

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  Future<void> fetchUser() async {
    AuthService authService = AuthService();
    UserModel? fetchedUser =
        await authService.getUserById(widget.bookingData.uId!);
    setState(() {
      user = fetchedUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(28),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Confirm Your Booking Details',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              user != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildDetailContainer(
                          title: 'Name',
                          content: user!.userName!,
                        ),
                        const SizedBox(height: 10),
                        buildDetailContainer(
                          title: 'Email',
                          content: user!.email!,
                        ),
                        const SizedBox(height: 10),
                        buildDetailContainer(
                          title: 'Phone Number',
                          content: user!.phoneNumber!,
                        ),
                      ],
                    )
                  : const Center(child: CircularProgressIndicator()),
              const SizedBox(height: 10),
              buildDetailContainer(
                title: 'Guest No',
                content: widget.bookingData.gestNo.toString(),
              ),
              const SizedBox(height: 10),
              buildDetailContainer(
                title: 'Booking Date',
                content: widget.bookingData.date!,
              ),
              const SizedBox(height: 10),
              buildDetailContainer(
                title: 'ID Number',
                content: widget.bookingData.travelId!,
              ),
              SizedBox(height: screenHeight * .25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 190,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17),
                        ),
                        backgroundColor:
                            const Color.fromARGB(255, 244, 240, 240),
                      ),
                      child: const Text(
                        'Back',
                        style: TextStyle(
                          color: Color.fromARGB(255, 133, 133, 133),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * .4,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaymentScreen(
                              tripId: widget.tripId,
                            ),
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Payment confirmed!')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.02,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'Confirm',
                        style: TextStyle(fontSize: 13, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
