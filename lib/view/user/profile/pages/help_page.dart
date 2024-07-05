// import 'package:flutter/material.dart';

// class HelpPage extends StatelessWidget {
//   const HelpPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Help Page'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Contact Us',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 20),
//             TextField(
//               decoration: InputDecoration(
//                 labelText: 'Email',
//                 border: OutlineInputBorder(),
//               ),
//               keyboardType: TextInputType.emailAddress,
//             ),
//             SizedBox(height: 20),
//             Text(
//               'Chat with Us',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 20),
//             Expanded(
//               child: Container(
//                 padding: const EdgeInsets.all(16.0),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: ListView(
//                   children: [
//                     // Example chat bubbles
//                     _buildChatBubble('Hello! How can I help you?',
//                         isUser: false),
//                     _buildChatBubble('I have an issue with my booking.',
//                         isUser: true),
//                     _buildChatBubble(
//                         'Sure, I can help with that. Can you provide more details?',
//                         isUser: false),
//                     // Add more chat bubbles as needed
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     decoration: InputDecoration(
//                       labelText: 'Type your message...',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: () {
//                     // Implement message sending functionality
//                   },
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildChatBubble(String message, {required bool isUser}) {
//     return Align(
//       alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 5),
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: isUser ? Colors.blueAccent : Colors.grey[300],
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Text(
//           message,
//           style: TextStyle(
//             color: isUser ? Colors.white : Colors.black,
//           ),
//         ),
//       ),
//     );
//   }
// }
// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:travel/view/user/chat/chat_page.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const ListTile(
              title: Text(
                'How to Order Spare Parts?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'To order spare parts, go to the Spare Parts section in the app. Browse through the available parts, select the ones you need, and proceed to checkout to complete your order.',
              ),
            ),
            const Divider(),
            const ListTile(
              title: Text(
                'Contact Support',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'If you have any further questions or need assistance, feel free to contact our support team at support@example.com.',
              ),
            ),
            const SizedBox(
              height: 300,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'For Know About Us Come Here',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserChatScreen(),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    radius: 20,
                    child: Image.asset('travel/assets/download.jpg'),
                    //  child: LottieBuilder.asset('assets/chat.json'),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
