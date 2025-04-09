import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class txtHelper {
  Widget headingText(
    String heading,
  ) =>
      Text(
        heading,
        style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600),
      );

  Widget heading1Text(String heading, double fontsize, Color? color) => Text(
        heading,
        style: GoogleFonts.poppins(
            fontSize: fontsize, fontWeight: FontWeight.w600, color: color),
      );
}
