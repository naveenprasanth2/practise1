import 'package:flutter/material.dart';
import 'package:practise1/list_view_test/widgets/house_policies/safety_guidelines_widget.dart';

class HousePoliciesWidget extends StatelessWidget {
  const HousePoliciesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SizedBox(
            height: 150,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "House Policies",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.vpn_key_outlined,
                          size: 30,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: [
                            Text(
                              "Check-in",
                              style: TextStyle(fontSize: 15),
                            ),
                            Text(
                              "12:00PM",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.door_back_door_outlined,
                          size: 30,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: [
                            Text(
                              "Check-out",
                              style: TextStyle(fontSize: 15),
                            ),
                            Text(
                              "11:00AM",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const Divider(
                  thickness: 0.5,
                ),
                const Row(
                  children: [
                    Icon(Icons.shield_outlined),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Follow safety measures advised at hotels"),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 35.0),
                  child: InkWell(
                    onTap: () {
                      showBottomSheet(
                          context: context,
                          backgroundColor: Colors.white,
                          builder: (context) {
                            return SafetyGuidelinesWidget();
                          });
                    },
                    child: const Text(
                      "View safety measures",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
