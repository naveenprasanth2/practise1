import 'package:flutter/material.dart';
import 'package:practise1/hotel_booking/screens/search_results/search_results_screen.dart';

class CityWidget extends StatelessWidget {
  final String cityName;

  const CityWidget({
    super.key,
    required this.cityName,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        String cityAndStateName = "";
        if (getCityName() == "Chennai") {
          cityAndStateName = "${getCityName()} , Tamilnadu";
        } else if (getCityName() == "Bangalore") {
          cityAndStateName += "${getCityName()} , Karnataka";
        } else if (getCityName() == "Delhi") {
          cityAndStateName += "${getCityName()} , Delhi";
        } else if (getCityName() == "Hyderabad") {
          cityAndStateName += "${getCityName()} , Telangana";
        } else if (getCityName() == "Kolkata") {
          cityAndStateName += "${getCityName()} , West Bengal";
        } else if (getCityName() == "Mumbai") {
          cityAndStateName += "${getCityName()} , Maharastra";
        } else if (getCityName() == "Trivandrum") {
          cityAndStateName += "${getCityName()} , Kerala";
        }

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (builder) =>
                    SearchResultsScreen(cityAndState: cityAndStateName)));
      },
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
              getCityName(),
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

  String getCityName() {
    return cityName.split("/")[1].split(".")[0].substring(0, 1).toUpperCase() +
        cityName
            .split("/")[1]
            .split(".")[0]
            .substring(1, cityName.split("/")[1].split(".")[0].length);
  }
}
