import 'package:flutter/material.dart';

class AmenitiesWidget extends StatelessWidget {
  final IconData iconData;
  final String title;

  const AmenitiesWidget({
    super.key,
    required this.iconData,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.black, // Border color
                width: 2.0,
              ),
            ),
            child: Center(child: Icon(iconData)),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
         Flexible(child: Text(title, style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 10),)),
      ],
    );
  }
}
