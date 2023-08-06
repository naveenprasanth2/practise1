import 'package:flutter/material.dart';
import 'package:practise1/list_view_test/providers/calculation_provider.dart';
import 'package:practise1/list_view_test/providers/date_provider.dart';
import 'package:provider/provider.dart';

import 'add_rooms_widget.dart';

class BookableDetailsWidget extends StatelessWidget {
  const BookableDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Booking details",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        Provider.of<DateProvider>(context, listen: false)
                            .setDate(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.calendar_month),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Dates"),
                            ],
                          ),
                          Text(
                            "${Provider.of<DateProvider>(context).checkInDateAndDay} - ${Provider.of<DateProvider>(context).checkOutDateAndDay}",
                            style: const TextStyle(
                                fontSize: 13, color: Colors.blue),
                          )
                        ],
                      ),
                    ),
                    const Divider(thickness: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.group),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Guests"),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              context: (context),
                              isScrollControlled: true,
                              builder: (context) {
                                return const AddRoomsWidget();
                              },
                            );
                          },
                          child: Text(
                            "${Provider.of<CalculationProvider>(context, listen: true).getNumberOfRooms()} rooms . "
                            "${Provider.of<CalculationProvider>(context, listen: true).getNumberOfGuests()} guests",
                            style: const TextStyle(
                                fontSize: 13, color: Colors.blue),
                          ),
                        )
                      ],
                    ),
                    const Divider(thickness: 1),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.person),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Booking for"),
                          ],
                        ),
                        Text(
                          "Naveen Prasanth",
                          style: TextStyle(fontSize: 13, color: Colors.blue),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
