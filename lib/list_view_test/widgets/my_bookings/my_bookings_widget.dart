import 'package:flutter/material.dart';

class MyBookingsWidget extends StatelessWidget {
  const MyBookingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: 190,
        width: double.infinity,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.black26,
              width: 1.0,
            ),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26),
                        borderRadius: BorderRadius.circular(20)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: const Image(
                        image: NetworkImage(
                            "https://media.istockphoto.com/id/187363337/photo/modern-hotel-building-in-summer.jpg?s=1024x1024&w=is&k=20&c=eAOaQqAgWgAKxRcqW3ahTsB6zhZ-ieNW_y4_POUUxgI="),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(
                          child: Text(
                            "Bangalore",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              const Text('03 Jan - 04 Jan  '),
                              Container(
                                height: 5,
                                width: 5,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black,
                                    border: Border.all(color: Colors.black)),
                              ),
                              const Text("  2 Guests"),
                            ],
                          ),
                        ),
                        const Text("Hotel Name should appear here"),
                        const Text("Hotel Plot number and Street Name")
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 50,
                    width: 120,
                    margin: const EdgeInsets.all(2),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.calendar_month,
                          color: Colors.black,
                        ),
                        Text(
                          "Book again",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 120,
                    margin: const EdgeInsets.all(2),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.question_answer,
                          color: Colors.black,
                        ),
                        Text(
                          "Need help?",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
