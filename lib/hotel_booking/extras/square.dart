import 'package:flutter/material.dart';

class MySquare extends StatelessWidget {
  final String title;

  const MySquare({super.key, required this.title, required int index});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      height: 500,
      decoration: BoxDecoration(
          color: Colors.purpleAccent,
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Expanded(
            child: PageView(
              padEnds: true,
              pageSnapping: true,
              physics: const BouncingScrollPhysics(),
              allowImplicitScrolling: true,
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                  width: 400,
                  decoration: BoxDecoration(
                      color: Colors.pink, borderRadius: BorderRadius.circular(10)),
                ),
                Container(
                  width: 400,
                  decoration: BoxDecoration(
                      color: Colors.pink, borderRadius: BorderRadius.circular(10)),
                ),
                Container(
                  width: 400,
                  decoration: BoxDecoration(
                      color: Colors.pink, borderRadius: BorderRadius.circular(10)),
                ),
                Container(
                  width: 400,
                  decoration: BoxDecoration(
                      color: Colors.pink, borderRadius: BorderRadius.circular(10)),
                ),
                Container(
                  width: 400,
                  decoration: BoxDecoration(
                      color: Colors.pink, borderRadius: BorderRadius.circular(10)),
                ),
                Container(
                  width: 400,
                  decoration: BoxDecoration(
                      color: Colors.pink, borderRadius: BorderRadius.circular(10)),
                ),
                Container(
                  width: 400,
                  decoration: BoxDecoration(
                      color: Colors.pink, borderRadius: BorderRadius.circular(10)),
                ),
              ],
            ),
          ),
         const SizedBox(
            height: 10,
          ),

          Expanded(
            flex: 1,
            child: Container(
              width: 500,
              decoration: BoxDecoration(
                  color: Colors.pink, borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ],
      ),
    );
  }
}
