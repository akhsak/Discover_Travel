// import 'package:discover/view/user/profile/pages/edit_profile.dart';
// import 'package:discover/widgets/textfield.dart';
// import 'package:flutter/material.dart';

// Widget userProfileScreenContainer(
//   Size size,
//   BuildContext context, {
//   required double height,
//   required double width,
//   required double sizedBoxWidth,
// }) {
//   return Container(
//     height: height,
//     width: width,
//     padding: const EdgeInsets.all(10),
//     decoration: BoxDecoration(
//       color: const Color(0xFFFFFFFF),
//       border: Border.all(
//         color: const Color(0xFFFFFFFF),
//       ),
//       borderRadius: BorderRadius.circular(18),
//     ),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         poppinsHeadText(text: 'Account Setting'),
//         GestureDetector(
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => const EditProfile(),
//               ),
//             );
//           },
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   Icon(Icons.person),
//                   SizedBox(width: sizedBoxWidth),
//                   poppinsSmallText(
//                     text: "Edit Profile",
//                   )
//                 ],
//               ),
//               const Icon(Icons.arrow_forward_ios_rounded,
//                   color: Color(0xFF888888))
//             ],
//           ),
//         ),

//       ],
//     ),
//   );
// }

import 'package:flutter/material.dart';
import 'package:travel/view/user/profile/pages/myprofile.dart';
import 'package:travel/widgets/textfield.dart';

Widget userProfileDetailsListTile(BuildContext context,
    {required String titleText, required String valueText}) {
  Size size = MediaQuery.of(context).size;
  return SizedBox(
    height: size.height * .09,
    width: size.width * .85,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        poppinsText(text: titleText, fontSize: 14, fontWeight: FontWeight.w500),
        const SizedBox(height: 2),
        Container(
          height: size.height * .06,
          width: size.width * .8,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            border: Border.all(color: const Color(0xFFFFFFFF)),
            borderRadius: BorderRadius.circular(18),
          ),
          child: poppinsHeadText(text: valueText),
        ),
      ],
    ),
  );
}

Widget userProfileScreenContainer(
  Size size,
  BuildContext context, {
  required double height,
  required double width,
  required double sizedBoxWidth,
  ImageProvider<Object>? imageProvider,
}) {
  return Container(
    height: height,
    width: width,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: const Color(0xFFFFFFFF),
      border: Border.all(
        color: const Color(0xFFFFFFFF),
      ),
      borderRadius: BorderRadius.circular(18),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        poppinsHeadText(text: 'Account Setting'),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyProfile(
                  // value: LoginProvider(),
                  imageProvider: imageProvider,
                ),
              ),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.person),
                  SizedBox(width: sizedBoxWidth),
                  poppinsSmallText(
                    text: "Edit Profile",
                  )
                ],
              ),
              const Icon(Icons.arrow_forward_ios_rounded,
                  color: Color(0xFF888888))
            ],
          ),
        ),
      ],
    ),
  );
}
