import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practise1/list_view_test/models/guest_policies/guest_policy_model.dart';

class GuestPoliciesWidget extends StatelessWidget {
  final List<GuestPolicyModel>? guestPolicies;
  final String? title;
  final IconData? iconData;

  const GuestPoliciesWidget({
    super.key,
    required this.guestPolicies,
    required this.title,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(iconData),
            const SizedBox(
              width: 5,
            ),
            Text(title!),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Text(guestPolicies != null
              ? guestPolicies!
                  .firstWhere((element) => element.title == title)
                  .description
                  .toString()
              : ""),
        ),
      ],
    );
  }
}
