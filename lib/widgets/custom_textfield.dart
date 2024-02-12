import 'package:flutter/material.dart';
import 'package:twitch/utils/colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, this.controller, this.onSubmitted});
  final TextEditingController? controller;
  final Function(String)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: onSubmitted,
      controller: controller,
      decoration: const InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: buttonColor,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: secondaryBackgroundColor,
          ),
        ),
      ),
    );
  }
}
