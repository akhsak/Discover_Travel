import 'package:flutter/material.dart';
import 'package:travel/widgets/text_style.dart';

class SnackBarWidget {
  void showSuccessSnackbar(BuildContext context, String message) {
    final snackbar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3),
      backgroundColor: const Color(0xFF00246B),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  void showErrorSnackbar(BuildContext context, String message) {
    final snackbar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}

alertSheet(BuildContext context,
    {onPressed, alertMessage, confirmButtonLabel}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Column(
          children: [
            textPoppins(
                name: alertMessage, fontweight: FontWeight.w600, fontsize: 15),
          ],
        ),
        actions: [
          ElevatedButton(
              style: const ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(Color.fromARGB(255, 4, 5, 5)),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: textPoppins(name: 'CANCEL', color: Colors.white)),
          ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(Color.fromARGB(255, 1, 1, 1))),
              onPressed: onPressed,
              child:
                  textPoppins(name: confirmButtonLabel, color: Colors.white)),
        ],
      );
    },
  );
}
