import 'package:flutter/material.dart';

class CityWidget extends StatelessWidget {
  final String cityName;
  final VoidCallback? onPressed;

  const CityWidget({super.key, required this.cityName, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        width: 110,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40, // Set the radius of the circular widget
              backgroundColor: Colors.grey.shade200,
              backgroundImage: AssetImage(
                  cityName), // Set the background color of the circular widget
            ),
            Text(
              cityName.split("/")[1].split(".")[0].substring(0, 1).toUpperCase() +
                  cityName
                      .split("/")[1]
                      .split(".")[0]
                      .substring(1, cityName.split("/")[1].split(".")[0].length),
              style: const TextStyle(
                color: Colors.black, // Set the text color
                fontSize: 18, // Set the font size
                fontWeight: FontWeight.normal, // Set the font weight
              ),
            ),
          ],
        ),
      ),
    );
  }
}
