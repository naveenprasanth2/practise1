import 'package:flutter/material.dart';
import 'package:practise1/list_view_test/models/hotel_detail_model/hotel_details_model.dart';
import 'package:practise1/list_view_test/providers/date_provider.dart';
import 'package:practise1/list_view_test/screens/hotel_booking/hotel_detail_screen.dart';
import 'package:practise1/list_view_test/widgets/location/city_widget.dart';
import 'package:provider/provider.dart';

import '../../constants/location_constants.dart';
import '../../widgets/adult_child/adult_child_bottom_sheet.dart';
import '../../providers/count_provider.dart';
import '../../widgets/left_drawer/my_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;
  final int itemCount = 4;
  final double scrollDuration = 2.0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _autoScroll(MediaQuery.of(context).size.width * 0.95);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _autoScroll(double itemWidth) async {
    final double maxScrollExtent = _scrollController.position.maxScrollExtent;
    final double itemExtent = itemWidth + 16.0; // Adjust with margin if any
    double currentScrollOffset = 0.0;

    while (true) {
      await Future.delayed(Duration(seconds: scrollDuration.toInt()));
      if (_scrollController.hasClients) {
        currentScrollOffset += itemExtent;
        if (currentScrollOffset >= maxScrollExtent) {
          await _scrollController.animateTo(
            currentScrollOffset,
            duration: Duration(seconds: scrollDuration.toInt()),
            curve: Curves.easeInOut,
          );
          currentScrollOffset = 0.0;
          await _scrollController.animateTo(
            currentScrollOffset,
            duration: Duration(seconds: scrollDuration.toInt()),
            curve: Curves.easeInOut,
          );
        } else {
          await _scrollController.animateTo(
            currentScrollOffset,
            duration: Duration(seconds: scrollDuration.toInt()),
            curve: Curves.easeInOut,
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
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
                      letterSpacing: 1,
                      fontSize: 25,
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
                    padding: const EdgeInsets.only(top: 60),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: TextField(
                            controller: TextEditingController(),
                            decoration: InputDecoration(
                              hintText: "Enter city name",
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
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
                                                    listen: true)
                                                .initialDate,
                                        hintStyle: const TextStyle(
                                            color: Colors.black54),
                                        border: OutlineInputBorder(
                                            borderSide: Divider.createBorderSide(
                                                context),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide:
                                                Divider.createBorderSide(context),
                                            borderRadius: BorderRadius.circular(10)),
                                        enabledBorder: OutlineInputBorder(borderSide: Divider.createBorderSide(context), borderRadius: BorderRadius.circular(10)),
                                        disabledBorder: OutlineInputBorder(borderSide: Divider.createBorderSide(context), borderRadius: BorderRadius.circular(10)),
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
                                      return const AdultChildBottomSheet();
                                    },
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 30),
                                  child: TextField(
                                    controller: TextEditingController(),
                                    decoration: InputDecoration(
                                      hintText:
                                          "Adult ${Provider.of<CountProviders>(context, listen: true).adultCount} - Child ${Provider.of<CountProviders>(context, listen: true).childCount}",
                                      hintStyle: const TextStyle(
                                          color: Colors.black54),
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
                                          borderRadius:
                                              BorderRadius.circular(10)),
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
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (builder) => HotelDetailScreen(
                                        hotelDetailsModel: HotelDetailsModel(
                                            hotelName: "Naveen Hotels",
                                            townName: "hebbal",
                                            cityName: "Bangalore",
                                            mapViewData: "Near Bangalore"),
                                      )));
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
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  color: Colors.grey.shade200,
                  height: 130, // Set the height of the horizontal list
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    // Set the scroll direction to horizontal
                    itemCount: LocationConstants.locationImages.length,
                    // Set the number of items in the list
                    itemBuilder: (BuildContext context, int index) {
                      return CityWidget(
                        cityName: LocationConstants.locationImages[index],
                        onPressed: () {},
                      );
                    },
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 200.0,
                  child: ListView.builder(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: itemCount,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        width: MediaQuery.of(context).size.width * 0.95,
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/offerBanner.jpg"),
                              fit: BoxFit.cover),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
