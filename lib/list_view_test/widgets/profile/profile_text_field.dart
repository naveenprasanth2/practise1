import 'package:flutter/material.dart';
import 'package:practise1/list_view_test/providers/profile_provider.dart';
import 'package:provider/provider.dart';

class ProfileTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final bool enabled;
  final TextEditingController textEditingController;

  const ProfileTextField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.enabled,
    required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      autocorrect: false,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        enabled: enabled,
        hintStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 15,
            color: Colors.grey.shade600),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.black12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.black12),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.black12),
        ),
      ),
      validator: (value) {
        if (value != null && value.length > 2) {
          return null;
        }else{
          return "Please enter your name";
        }
      },
    );
  }
}
