import 'package:flutter/material.dart';

class UpcomingAssistanceWidget extends StatelessWidget {
  final IconData iconData;
  final VoidCallback onPressed;
  final String title;
  const UpcomingAssistanceWidget({
    super.key,
    required this.iconData,
    required this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.grey.shade100,
            ),
            child: Icon(
              iconData,
            ),
          ),
          Text(title),
        ],
      ),
    );
  }
}
