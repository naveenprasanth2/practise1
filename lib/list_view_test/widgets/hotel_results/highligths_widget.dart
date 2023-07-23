import 'package:flutter/material.dart';

class HighLights extends StatelessWidget {
  final String value;

  const HighLights({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Container(
        height: 300,
        margin: const EdgeInsets.all(2.0),
        width: MediaQuery.of(context).size.width * 0.30,
        decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            value,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Colors.white),
          ),
        ),
      ),
    );
  }
}
