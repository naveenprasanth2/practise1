import 'package:flutter/material.dart';
import 'package:practise1/tests/test_page.dart';

class MyCircle extends StatelessWidget {
  final String title;

  const MyCircle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        onTap: () {
          if (title == "cat") {
            Navigator.push(
                context, MaterialPageRoute(builder: (e) => const TestPage()));
          }
        },
        child: Container(
          height: 100,
          width: 100,
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: Colors.pink),
          child: Center(child: Text(title)),
        ),
      ),
    );
  }
}
