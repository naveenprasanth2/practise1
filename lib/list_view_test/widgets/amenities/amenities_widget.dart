import 'package:flutter/material.dart';

import 'circle_container_widget.dart';

class AmenitiesWidget extends StatelessWidget {
  final IconData iconData;
  final String title;
  final bool isAvailable;

  const AmenitiesWidget({
    super.key,
    required this.iconData,
    required this.title,
    required this.isAvailable,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: CircleContainer(
            color: Colors.white,
            size: 30,
            isTrue: isAvailable,
            iconData: iconData,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Flexible(
          child: Text(
            title,
            style: isAvailable
                ? const TextStyle(fontWeight: FontWeight.normal, fontSize: 10)
                : const TextStyle(fontWeight: FontWeight.normal, fontSize: 10, color: Colors.black54,),
          ),
        ),
      ],
    );
  }
}
