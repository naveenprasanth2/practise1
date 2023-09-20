import 'package:flutter/material.dart';
import 'package:practise1/hotel_booking/screens/language/select_language_screen.dart';
import 'package:practise1/hotel_booking/utils/dart_helper/sizebox_helper.dart';

class DrawerTile extends StatelessWidget {
  final String tileName;
  final Icon icon;
  final VoidCallback onPressed;
  const DrawerTile({
    super.key,
    required this.tileName,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 60,
        color: Colors.white,
        child: Row(
          children: [
            icon,
            SizedBoxHelper.sizedBox_20,
            Text(
              tileName,
              style: const TextStyle(fontSize: 17),
            ),
          ],
        ),
      ),
    );
  }
}
