import 'package:flutter/material.dart';

class MyModalBottomSheet extends StatefulWidget {
  @override
  _MyModalBottomSheetState createState() => _MyModalBottomSheetState();
}

class _MyModalBottomSheetState extends State<MyModalBottomSheet> {
  int adultCount = 0;
  int childCount = 0;

  void incrementAdultCount() {
    setState(() {
      adultCount++;
    });
  }

  void decrementAdultCount() {
    setState(() {
      if (adultCount > 0) {
        adultCount--;
      }
    });
  }

  void incrementChildCount() {
    setState(() {
      childCount++;
    });
  }

  void decrementChildCount() {
    setState(() {
      if (childCount > 0) {
        childCount--;
      }
    });
  }

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
                        onTap: decrementAdultCount,
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey
                          ),
                          child: const Icon(Icons.remove),
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Text(adultCount.toString(),  style:const TextStyle(fontSize: 18),),
                      const SizedBox(width: 10,),
                      InkWell(
                        onTap: incrementAdultCount,
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey
                          ),
                          child: const Icon(Icons.add),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 40,),
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
                        onTap: decrementChildCount,
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey
                          ),
                          child: const Icon(Icons.remove),
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Text(childCount.toString(),  style:const TextStyle(fontSize: 18),),
                      const SizedBox(width: 10,),
                      InkWell(
                        onTap: incrementChildCount,
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey
                          ),
                          child: const Icon(Icons.add),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 40,),

              InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                      colors: [
                        Colors.purpleAccent,
                        Colors.pinkAccent
                      ],
                    )
                  ),
                  child: const Center(child: Text("submit")),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
