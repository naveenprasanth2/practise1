import 'package:flutter/material.dart';
import 'package:validators/validators.dart' as validator;

class EmailTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final bool enabled;
  final TextEditingController textEditingController;

  const EmailTextField({
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
        if (value == null || value.isEmpty) {
          return 'Please enter an email address';
        } else if (!validator.isEmail(value)) {
          return 'Please enter a valid email address';
        }
        return null;
      },
    );
  }
}
