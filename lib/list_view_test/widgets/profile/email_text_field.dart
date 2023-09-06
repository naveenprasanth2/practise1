import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart' as validator;

import '../../providers/profile_provider.dart';

class EmailTextField extends StatefulWidget {
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
  State<EmailTextField> createState() => _EmailTextFieldState();
}

class _EmailTextFieldState extends State<EmailTextField> {
  String? initialValue;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    initialValue ??=
        Provider.of<ProfileProvider>(context, listen: true).emailId ?? '';
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    widget.textEditingController.text = initialValue!;
    return TextFormField(
      controller: widget.textEditingController,
      onChanged: (value){
        initialValue = value;
      },
      decoration: InputDecoration(
        hintText: widget.hintText,
        labelText: widget.labelText,
        enabled: widget.enabled,
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
