import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

lebelText(
        {required String labelText,
        required double size,
        required Color color}) =>
    Text(
      labelText,
      style: GoogleFonts.poppins(
          fontSize: size, fontWeight: FontWeight.w500, color: color),
    );

headingTxt({
  required String labelText,
  required double size,
  required Color color,
  required FontWeight fontWight,
}) =>
    Text(
      labelText,
      style: GoogleFonts.poppins(
          fontSize: size, fontWeight: fontWight, color: color),
    );
