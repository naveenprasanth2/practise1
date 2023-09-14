import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});
  final GlobalKey<FormState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BookAny"),
        automaticallyImplyLeading: true,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.pinkAccent, Colors.purpleAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.topRight)),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Expanded(
                child: TextFormField(
              key: _key,
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
              validator: (String? text) {
                if (text!.isEmpty) {
                  return "Please enter a city name";
                } else if (!text.contains(",")) {
                  return "Please select a valid name from dropdown";
                } else {
                  return null;
                }
              },
            )),
          ),
        ],
      ),
    );
  }

  void validateSearchBoxText() {
    if (_key.currentState!.validate()) {}
  }
}
