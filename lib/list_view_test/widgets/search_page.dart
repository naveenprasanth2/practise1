import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Expanded(
                child: TextField(
              controller: TextEditingController(),
              decoration: InputDecoration(
                hintText: "enter city name",
                border: OutlineInputBorder(
                    borderSide: Divider.createBorderSide(context),
                    borderRadius: BorderRadius.circular(10)),
                focusedBorder: OutlineInputBorder(
                    borderSide: Divider.createBorderSide(context),
                    borderRadius: BorderRadius.circular(10)),
                enabledBorder: OutlineInputBorder(
                    borderSide: Divider.createBorderSide(context),
                    borderRadius: BorderRadius.circular(10)),
                filled: false,
                contentPadding: const EdgeInsets.all(8),
              ),
              keyboardType: TextInputType.text,
              obscureText: false,
            )),
          ),
        ],
      ),
    );
  }
}
