import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_app/resources/app_colors.dart';

class SearchTextField extends StatelessWidget {
  SearchTextField(
      {super.key, required this.string, this.ontap});

  final String string;
  void Function()? ontap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width*0.95,
      height: 50,
      child: TextField(
        onTap:ontap,
        decoration: InputDecoration(
            iconColor: Colors.grey,
            hintText: string,
            hintStyle: GoogleFonts.montserrat(textStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            )),
            filled: true,
            fillColor: AppColors.whiteColor,
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(20.0),
            )
        ),
      ),
    );
  }
}