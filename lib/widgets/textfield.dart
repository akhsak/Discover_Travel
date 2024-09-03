import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:travel/controller/booking_provider.dart';

class CustomTextFormField extends StatelessWidget {
  final String? labelText;
  final bool? obscureText;
  final TextEditingController controller;
  final OutlineInputBorder? enabledBorder;
  final OutlineInputBorder? focusedBorder;
  final OutlineInputBorder? focusErrorBorder;
  final Widget? suffixIcon;
  final String? hintText;
  final String? validateMsg;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.labelText,
    this.hintText,
    this.onChanged,
    this.obscureText,
    this.enabledBorder,
    this.focusedBorder,
    this.focusErrorBorder,
    this.suffixIcon,
    this.validateMsg,
    this.keyboardType,
    this.inputFormatters,
    required Icon prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText ?? false,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validateMsg ?? 'value is empty';
        } else {
          return null;
        }
      },
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      controller: controller,
      decoration: InputDecoration(
          suffixIcon: suffixIcon,
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.grey),
          fillColor: Colors.grey[200],
          filled: true,
          border: InputBorder.none,
          enabledBorder: enabledBorder,
          focusedBorder: focusedBorder,
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: focusErrorBorder),
    );
  }
}

poppinsText({text, color, fontWeight, double? fontSize, textAlign, overflow}) {
  return Text(text,
      overflow: overflow,
      textAlign: textAlign,
      style: GoogleFonts.poppins(
          color: color, fontWeight: fontWeight, fontSize: fontSize));
}

poppinsHeadText({text, textAlign, double? fontSize, color}) {
  return Text(text,
      textAlign: textAlign,
      style: GoogleFonts.poppins(
          color: color ?? const Color(0xFF101828),
          fontWeight: FontWeight.w600,
          fontSize: fontSize ?? 13));
}

poppinsSmallText({text, color, fontWeight, textAlign}) {
  return Text(text,
      // overflow: TextOverflow.ellipsis,
      textAlign: textAlign,
      style: GoogleFonts.poppins(
          color: color ?? Color.fromARGB(255, 11, 11, 11), fontSize: 12));
}

Widget travelDetailsText({String? value, double? fontsize, fontWeight, color}) {
  return Row(
    children: [
      Text(
        value!,
        style: GoogleFonts.poppins(
            fontSize: fontsize,
            fontWeight: fontWeight,
            color: color ?? Colors.black,
            letterSpacing: 1),
      ),
    ],
  );
}

Widget bookingDateTextFormField(
    BuildContext context, BookingProvider userProvider) {
  final RegExp dateRegex = RegExp(
    r'^\d{2}/\d{2}/\d{4}$',
  );

  final DateTime now = DateTime.now();
  final DateTime tomorrow = now.add(const Duration(days: 1));

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: tomorrow,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      final formattedDate =
          "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
      userProvider.userBookingDateController.text = formattedDate;
      userProvider.setSelectedDate(formattedDate);
    }
  }

  return TextFormField(
    controller: userProvider.userBookingDateController,
    readOnly: true,
    onTap: () {
      selectDate(context);
    },
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Pick a date';
      } else if (!dateRegex.hasMatch(value)) {
        return 'Pick a valid date';
      }
      return null;
    },
    decoration: InputDecoration(
      suffixIcon: const Icon(Icons.calendar_today),
      hintText: 'Booking Date',
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
  );
}
