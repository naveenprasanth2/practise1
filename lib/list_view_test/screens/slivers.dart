import 'package:flutter/material.dart';
import 'package:practise1/list_view_test/providers/date_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/bottom_sheet.dart';
import '../providers/count_providers.dart';
import '../widgets/my_drawer.dart';

class SliversTest extends StatefulWidget {
  const SliversTest({super.key});

  @override
  State<SliversTest> createState() => _SliversTestState();
}

class _SliversTestState extends State<SliversTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: GestureDetector(
              onTap: () {},
              child: Text(
                "BookAny",
                style: TextStyle(
                  color: Colors.red.shade400,
                  letterSpacing: 3,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            centerTitle: true,
            expandedHeight: 300,
            backgroundColor: Colors.white,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.none,
              centerTitle: true,
              background: Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextField(
                        controller: TextEditingController(),
                        decoration: InputDecoration(
                          hintText: "enter city name",
                          border: OutlineInputBorder(
                              borderSide: Divider.createBorderSide(context),
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: Divider.createBorderSide(context),
                              borderRadius: BorderRadius.circular(10)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: Divider.createBorderSide(context),
                              borderRadius: BorderRadius.circular(10)),
                          filled: false,
                          contentPadding: const EdgeInsets.all(8),
                        ),
                        keyboardType: TextInputType.text,
                        obscureText: false,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: InkWell(
                              onTap: () async {
                                Provider.of<DateProvider>(context,
                                        listen: false)
                                    .setDate(context);
                              },
                              child: TextField(
                                controller: TextEditingController(),
                                decoration: InputDecoration(
                                    hintText: Provider.of<DateProvider>(context,
                                                listen: true)
                                            .date ??
                                        Provider.of<DateProvider>(context,
                                            listen: true).initialDate,
                                    hintStyle:
                                        const TextStyle(color: Colors.black54),
                                    border: OutlineInputBorder(
                                        borderSide:
                                            Divider.createBorderSide(context),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            Divider.createBorderSide(context),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            Divider.createBorderSide(context),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    disabledBorder: OutlineInputBorder(
                                        borderSide:
                                            Divider.createBorderSide(context),
                                        borderRadius: BorderRadius.circular(10)),
                                    filled: false,
                                    contentPadding: const EdgeInsets.all(8),
                                    enabled: false),
                                keyboardType: TextInputType.text,
                                obscureText: false,
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return const MyModalBottomSheet();
                                },
                              );
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 30),
                              child: TextField(
                                controller: TextEditingController(),
                                decoration: InputDecoration(
                                  hintText:
                                      "Adult ${Provider.of<CountProviders>(context, listen: true).adultCount} - Child ${Provider.of<CountProviders>(context, listen: true).childCount}",
                                  hintStyle:
                                  const TextStyle(color: Colors.black54),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          Divider.createBorderSide(context),
                                      borderRadius: BorderRadius.circular(10)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          Divider.createBorderSide(context),
                                      borderRadius: BorderRadius.circular(10)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          Divider.createBorderSide(context),
                                      borderRadius: BorderRadius.circular(10)),
                                  disabledBorder: OutlineInputBorder(
                                      borderSide:
                                          Divider.createBorderSide(context),
                                      borderRadius: BorderRadius.circular(10)),
                                  filled: false,
                                  contentPadding: const EdgeInsets.all(8),
                                ),
                                keyboardType: TextInputType.text,
                                obscureText: false,
                                enabled: false,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Flexible(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (builder) => const SliversTest()));
                        },
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.85,
                          decoration: BoxDecoration(
                            color: Colors.red.shade400,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                              child: Text(
                            "search",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return ListTile(
                  title: Text("Item $index"),
                  leading: const Icon(Icons.add),
                );
              },
              childCount: 100,
            ),
          ),
        ],
      ),
    );
  }
}
