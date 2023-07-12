import 'package:flutter/material.dart';
import 'package:practise1/list_view_test/home_page_test/circle.dart';
import 'package:practise1/list_view_test/home_page_test/square.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final List<String> _list = ["post", "cat", "mat", "bat", "summa","post", "cat", "mat", "bat", "summa"];

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
              colors: [
                Colors.pinkAccent,
                Colors.purpleAccent
              ],
              begin: Alignment.topLeft,
              end: Alignment.topRight
            )
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Expanded(child: TextField(
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
          Expanded(
            flex: 0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _list.length,
              itemBuilder: (context, index){
                return MyCircle(title: _list[index],);
              },
            ),
          ),
          Expanded(
            flex: 4,
            child: ListView.builder(
              itemCount: _list.length,
              itemBuilder: (context, index) {
                return MySquare(
                  title: _list[index], index: index
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
