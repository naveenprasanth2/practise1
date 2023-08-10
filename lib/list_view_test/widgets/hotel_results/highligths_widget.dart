import 'package:flutter/material.dart';

class HighLights extends StatelessWidget {
  final String value;

  const HighLights({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Container(
        height: 30,
        margin: const EdgeInsets.all(2.0),
        width: MediaQuery.of(context).size.width * 0.22,
        decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            value,
            style: const TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Colors.white),
          ),
        ),
      ),
    );
  }
}
