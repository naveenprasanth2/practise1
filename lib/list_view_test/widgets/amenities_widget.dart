import 'package:flutter/material.dart';

class AmenitiesWidget extends StatelessWidget {
  const AmenitiesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.black, // Border color
                width: 2.0, //
              ),
            ),
            child: const Center(child: Icon(Icons.add, size: 20)),
          ),
        ),
        const SizedBox(width: 10,),
        const Text("Summa"),
      ],
    );
  }
}
