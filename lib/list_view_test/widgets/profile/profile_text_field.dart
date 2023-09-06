import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/profile_provider.dart';

class ProfileTextField extends StatefulWidget {
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
  State<ProfileTextField> createState() => _ProfileTextFieldState();
}

class _ProfileTextFieldState extends State<ProfileTextField> {
  String? initialValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    initialValue ??= Provider.of<ProfileProvider>(context, listen: true).name ?? '';
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    widget.textEditingController.text = initialValue!;
    return TextFormField(
      controller: widget.textEditingController,
      autocorrect: false,
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
        if (value != null && value.length > 2) {
          return null;
        } else {
          return "Please enter your name";
        }
      },
    );
  }
}
