import 'package:flutter/material.dart';

class PopOverWidget extends StatelessWidget {
  final String message;

  const PopOverWidget({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: double.infinity,
        color: Colors.white,
        child: Text(
          message,
          style: const TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
    );
  }
}
