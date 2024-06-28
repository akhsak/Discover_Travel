import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget textPoppins({name, color, fontweight, double? fontsize}) {
  return Text(name!,
      style: GoogleFonts.poppins(
          color: color, fontWeight: fontweight, fontSize: fontsize));
}

Widget textAbel({name, color, fontweight, double? fontsize}) {
  return Text(name,
      style: GoogleFonts.abel(
          color: color, fontWeight: fontweight, fontSize: fontsize));
}

class TextWidget {
  text({data, size, weight, color, align, style}) {
    return Text(
      data,
      style: GoogleFonts.aBeeZee(
        fontSize: size,
        fontWeight: weight,
        color: color,
        fontStyle: style,
      ),
      textAlign: align,
      overflow: TextOverflow.ellipsis,
    );
  }
}
