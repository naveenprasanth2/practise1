import 'package:flutter/material.dart';

class GuestPoliciesScreen extends StatefulWidget {
  final List<MapEntry<String, dynamic>>? guestPolicies;

  const GuestPoliciesScreen({super.key, this.guestPolicies});

  @override
  State<GuestPoliciesScreen> createState() => _GuestPoliciesScreenState();
}

class _GuestPoliciesScreenState extends State<GuestPoliciesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Guest policies",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        backgroundColor: Colors.red.shade400,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Container(
          child: ListView.builder(
            itemCount: widget.guestPolicies!.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.guestPolicies![index].key,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.guestPolicies![index].value.toString(),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
