import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:travel/controller/authentication_provider.dart';
import 'package:travel/controller/booking_provider.dart';
import 'package:travel/model/booking_model.dart';
import 'package:travel/view/user/booking/conform_payment.dart';
import 'package:travel/widgets/textfield.dart';
import 'package:country_picker/country_picker.dart';

class DetailBooking extends StatelessWidget {
  final tripId;
  const DetailBooking({super.key, this.tripId});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final detailBookProvider =
        Provider.of<BookingProvider>(context, listen: false);
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: SingleChildScrollView(
          child: Form(
            key: detailBookProvider.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Detail Booking',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: screenHeight * 0.03,
                  ),
                ),
                Gap(screenHeight * 0.02),
                Text(
                  'Get the best out of derleng by creating an account',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: screenHeight * 0.02,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                // TextFormField(
                //   controller: detailBookProvider.guestNameController,
                //   decoration: InputDecoration(
                //     labelText: 'Guest name',
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(10.0),
                //     ),
                //   ),
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please enter guest name';
                //     }
                //     return null;
                //   },
                // ),
                SizedBox(height: screenHeight * 0.02),
                TextFormField(
                  controller: detailBookProvider.guestNumberController,
                  decoration: InputDecoration(
                    labelText: 'Guest number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter guest number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: screenHeight * 0.02),
                bookingDateTextFormField(context, detailBookProvider),
                SizedBox(height: screenHeight * 0.02),
                // Row(
                //   children: [
                //     Container(
                //       width: 100,
                //       child: Consumer<LoginProvider>(
                //         builder: (context, value, child) => TextFormField(
                //           readOnly: true,
                //           decoration: InputDecoration(
                //             prefixIcon: Container(
                //               padding:
                //                   const EdgeInsets.symmetric(horizontal: 12),
                //               child: InkWell(
                //                 onTap: () {
                //                   showCountryPicker(
                //                     context: context,
                //                     countryListTheme:
                //                         const CountryListThemeData(
                //                       bottomSheetHeight: 500,
                //                     ),
                //                     onSelect: (country) {
                //                       loginProvider.selectCountry = country;
                //                     },
                //                   );
                //                 },
                //                 child: Row(
                //                   children: [
                //                     Text(
                //                       value.selectCountry.flagEmoji,
                //                       style: const TextStyle(fontSize: 20),
                //                     ),
                //                     const SizedBox(width: 5),
                //                     Text(
                //                       "+${value.selectCountry.phoneCode}",
                //                       style: const TextStyle(
                //                           fontSize: 16,
                //                           fontWeight: FontWeight.bold),
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //             ),
                //             border: OutlineInputBorder(
                //               borderRadius: BorderRadius.circular(10.0),
                //             ),
                //           ),
                //         ),
                //     ),
                //   ),
                // Gap(10),
                // SizedBox(
                //   width: screenWidth - 160,
                //   child: TextFormField(
                //     controller: detailBookProvider.phoneController,
                //     //  maxLength: 10,
                //     decoration: InputDecoration(
                //       labelText: 'Phone',
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(10.0),
                //       ),
                //     ),
                //     keyboardType: TextInputType.number,
                //     inputFormatters: [
                //       FilteringTextInputFormatter.digitsOnly
                //     ],
                //     validator: (value) {
                //       if (value == null || value.isEmpty) {
                //         return 'Please enter phone number';
                //       } else if (value.length != 10) {
                //         return 'Phone number must be exactly 10 digits';
                //       }
                //       return null;
                //     },
                //   ),
                //   ),
                //  ],
                //  ),
                //  SizedBox(height: screenHeight * 0.02),
                // TextFormField(
                //   controller: detailBookProvider.emailController,
                //   decoration: InputDecoration(
                //     labelText: 'Email',
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(10.0),
                //     ),
                //   ),
                //   keyboardType: TextInputType.emailAddress,
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please enter email';
                //     }
                //     if (!RegExp(r'^[\w-\.]+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$')
                //         .hasMatch(value)) {
                //       return 'Please enter a valid Gmail address';
                //     }
                //     return null;
                //   },
                // ),
                SizedBox(height: screenHeight * 0.02),
                TextFormField(
                  controller: detailBookProvider.idNumberController,
                  obscureText: detailBookProvider.obscureText,
                  decoration: InputDecoration(
                    labelText: 'ID Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        detailBookProvider.idPasswordVisibility();
                      },
                      icon: Icon(
                        detailBookProvider.obscureText
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter id number';
                    } else if (value.length != 2) {
                      return 'ID number must be exactly 2 digits';
                    }
                    return null;
                  },
                ),
                SizedBox(height: screenHeight * 0.15),
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
                          backgroundColor: Color.fromARGB(255, 244, 240, 240),
                        ),
                        child: const Text('Back',
                            style: TextStyle(
                                color: Color.fromARGB(255, 133, 133, 133),
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    SizedBox(
                      width: screenWidth * 0.4,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (detailBookProvider.formKey.currentState!
                              .validate()) {
                            final currentUser =
                                FirebaseAuth.instance.currentUser;
                            BookingModel bookingModel = BookingModel(
                              uId: currentUser!.uid,
                              // name: detailBookProvider.guestNameController.text,
                              gestNo:
                                  detailBookProvider.guestNumberController.text,
                              // phoneNumber:
                              //     detailBookProvider.phoneController.text,
                              // email: detailBookProvider.emailController.text,
                              idd: tripId,
                              travelId:
                                  detailBookProvider.idNumberController.text,
                              date: detailBookProvider.selectedDate ?? '',
                            );

                            bool success = await detailBookProvider.addBooking(
                              bookingModel,
                              (message) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(message)),
                                );
                              },
                            );

                            if (success) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ConfirmPayment(
                                    bookingData: bookingModel,
                                    tripId: tripId,
                                  ),
                                ),
                              );
                            }
                          }
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
                        child: Text(
                          'Next',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
