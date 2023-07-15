import 'package:flutter/material.dart';
import 'package:practise1/list_view_test/providers/count_providers.dart';
import 'package:provider/provider.dart';

class MyModalBottomSheet extends StatefulWidget {
  const MyModalBottomSheet({super.key});

  @override
  MyModalBottomSheetState createState() => MyModalBottomSheetState();
}

class MyModalBottomSheetState extends State<MyModalBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: 300,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Adult',
                    style: TextStyle(fontSize: 18),
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Provider.of<CountProviders>(context, listen: false)
                              .decrementAdultCount();
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.grey),
                          child: const Icon(Icons.remove),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        Provider.of<CountProviders>(context, listen: true)
                            .tempAdultCount
                            .toString(),
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Provider.of<CountProviders>(context, listen: false)
                              .incrementAdultCount();
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.grey),
                          child: const Icon(Icons.add),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Child',
                    style: TextStyle(fontSize: 18),
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Provider.of<CountProviders>(context, listen: false)
                              .decrementChildCount();
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.grey),
                          child: const Icon(Icons.remove),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        Provider.of<CountProviders>(context, listen: false)
                            .tempChildCount
                            .toString(),
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Provider.of<CountProviders>(context, listen: false)
                              .incrementChildCount();
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.grey),
                          child: const Icon(Icons.add),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              InkWell(
                onTap: () {
                  Provider.of<CountProviders>(context, listen: false)
                      .notifyAdultListeners();
                  Provider.of<CountProviders>(context, listen: false)
                      .notifyChildListeners();
                  Navigator.pop(context);
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.red.shade400,
                  ),
                  child: const Center(
                      child: Text(
                    "submit",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                    ),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
