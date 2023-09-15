import 'package:flutter/material.dart';

class BookingDetailCard extends StatelessWidget {
  final String title;
  final String value;

  const BookingDetailCard(
      {super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
        tileColor: Colors.white,
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: Text(value),
      ),
    );
  }
}
