import 'package:flutter/material.dart';
import 'package:practise1/hotel_booking/models/guest_policies/guest_policy_model.dart';

import '../../screens/guest_policies/guest_policies_screen.dart';
import '../hotel_details/guest_policies_widget.dart';

class GuestPoliciesMainWidget extends StatelessWidget {
  final List<GuestPolicyModel> guestPolicies;

  const GuestPoliciesMainWidget({super.key, required this.guestPolicies});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: 200,
        width: double.infinity,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Guest Policies",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (builder) => GuestPoliciesScreen(
                            guestPolicies: guestPolicies,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      "View All",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.red.shade400,
                      ),
                    ),
                  ),
                ],
              ),
              if (guestPolicies.length >= 3)
                Column(
                  children: [
                    GuestPoliciesWidget(
                      guestPolicies: guestPolicies,
                      title: guestPolicies[0].title,
                      iconData: Icons.favorite_outline_rounded,
                    ),
                    GuestPoliciesWidget(
                      guestPolicies: guestPolicies,
                      title: guestPolicies[1].title,
                      iconData: Icons.account_box_outlined,
                    ),
                    GuestPoliciesWidget(
                      guestPolicies: guestPolicies,
                      title: guestPolicies[2].title,
                      iconData: Icons.watch_later_outlined,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
