import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:practise1/hotel_booking/models/hotel_search/hotel_search_model.dart';
import 'package:practise1/hotel_booking/screens/hotel_booking/hotel_detail_screen.dart';
import 'package:practise1/hotel_booking/utils/dart_helper/sizebox_helper.dart';
import 'package:practise1/hotel_booking/widgets/loading/three_dot_loading_widget.dart';
import 'package:practise1/hotel_booking/widgets/room_occupancy_details/add_rooms_widget.dart';
import 'package:provider/provider.dart';

import '../../providers/count_provider.dart';
import '../../providers/date_provider.dart';
import '../../widgets/hotel_results/hotel_results_widget.dart';

class SearchResultsScreen extends StatefulWidget {
  final String cityAndState;

  const SearchResultsScreen({
    Key? key,
    required this.cityAndState,
  }) : super(key: key);

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  late Stream<List<HotelSearchModel>?> _hotelSearchStream;

  @override
  void initState() {
    super.initState();
    _hotelSearchStream = loadHotelSearchResultsJson();
  }

  Stream<List<HotelSearchModel>> loadHotelSearchResultsJson() async* {
    final querySnapshot = await FirebaseFirestore.instance
        .collection(widget.cityAndState.split(",")[1].trim().toLowerCase())
        .doc(widget.cityAndState.split(",")[0].trim().toLowerCase())
        .collection("hotels")
        .get();
    List<dynamic> valuesList = querySnapshot.docs
        .map((doc) {
          return doc.data().values;
        })
        .expand((value) => value)
        .toList();

    List<HotelSearchModel> hotelSearchList = valuesList
        .map((element) => HotelSearchModel.fromJson(element))
        .toList();

    yield hotelSearchList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ... SliverAppBar and other widgets ...
          SliverAppBar(
            pinned: true,
            iconTheme: const IconThemeData(color: Colors.white),
            centerTitle: true,
            backgroundColor: Colors.red.shade400,
            automaticallyImplyLeading: true,
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  // Use a null-aware operator to avoid null errors
                  widget.cityAndState,
                  style: const TextStyle(color: Colors.white),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Builder(builder: (context) {
                          return InkWell(
                            onTap: () {
                              showBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return const AddRoomsWidget();
                                },
                              );
                            },
                            child: Text(
                              "Adult ${Provider.of<CountProvider>(context, listen: true).adultCount} - Child ${Provider.of<CountProvider>(context, listen: true).childCount}",
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          );
                        }),
                      ),
                      SizedBoxHelper.sizedBox_10,
                      Flexible(
                        child: InkWell(
                          onTap: () async {
                            Provider.of<DateProvider>(context, listen: false)
                                .setDate(context);
                          },
                          child: Text(
                            Provider.of<DateProvider>(context, listen: true)
                                    .date ??
                                Provider.of<DateProvider>(context, listen: true)
                                    .initialDate!,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Use StreamBuilder to handle data stream
          StreamBuilder<List<HotelSearchModel>?>(
            stream: _hotelSearchStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SliverFillRemaining(
                  child: Center(
                    child: ThreeDotLoadingWidget(),
                  ),
                );
              } else if (snapshot.hasError) {
                return SliverFillRemaining(
                  child: Center(
                    child: Text("${snapshot.error}error"),
                  ),
                );
              } else {
                final hotelSearchModel = snapshot.data;
                if (hotelSearchModel != null && hotelSearchModel.isNotEmpty) {
                  // Data is available, build the SliverList with HotelResultsWidget
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (builder) => HotelDetailScreen(
                                  hotelSearchModel: hotelSearchModel[index],
                                  cityAndState: widget.cityAndState,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            height: 400,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black26),
                            ),
                            child: HotelResultsWidget(
                              hotelSearchModel: hotelSearchModel[index],
                            ),
                          ),
                        );
                      },
                      childCount: hotelSearchModel.length,
                    ),
                  );
                } else {
                  // Data is null (error or empty), display a message
                  return const SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("No Hotels Found"),
                          Text("Don't worry, we are rapidly expanding"),
                        ],
                      ),
                    ),
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
