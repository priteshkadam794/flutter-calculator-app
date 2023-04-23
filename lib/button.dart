import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyButton extends StatelessWidget {
  final Color color;
  final Color textColor;
  final String text;
  final VoidCallback tapfun;

  const MyButton(
      {super.key,
      required this.color,
      required this.textColor,
      required this.text,
      required this.tapfun});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tapfun,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(21),
            color: color,
          ),
          child: Center(
            child: Text(
              text,
              style: GoogleFonts.montserrat(textStyle:  TextStyle(
               fontSize: 20,
                fontWeight: FontWeight.w500,
                color: textColor,
              ))
              ),
            ),
          ),
        ),
      );
  }
}
