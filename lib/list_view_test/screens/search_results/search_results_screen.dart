import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practise1/list_view_test/models/hotel_search/hotel_search_model.dart';
import 'package:provider/provider.dart';

import '../../providers/count_provider.dart';
import '../../providers/date_provider.dart';
import '../../widgets/adult_child/adult_child_bottom_sheet.dart';
import '../../widgets/hotel_results/hotel_results_widget.dart';

class SearchResultsScreen extends StatefulWidget {
  const SearchResultsScreen({Key? key}) : super(key: key);

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  late Stream<HotelSearchModel?> _hotelSearchStream;

  @override
  void initState() {
    super.initState();
    _hotelSearchStream = loadHotelSearchResultsJson();
  }

  Stream<HotelSearchModel?> loadHotelSearchResultsJson() async* {
    final value = await rootBundle.loadString("assets/hotel_search_details.json");
    yield HotelSearchModel.fromJson(json.decode(value));
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
            automaticallyImplyLeading: true,
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.phone),
              ),
            ],
            backgroundColor: Colors.red.shade400,
            title: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    // Use a null-aware operator to avoid null errors
                    "Hotel Name Loading...",
                    style: TextStyle(color: Colors.white),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return const AdultChildBottomSheet();
                            },
                          );
                        },
                        child: Text(
                          "Adult ${Provider.of<CountProviders>(context, listen: true).adultCount} - Child ${Provider.of<CountProviders>(context, listen: true).childCount}",
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
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
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Use StreamBuilder to handle data stream
          StreamBuilder<HotelSearchModel?>(
            stream: _hotelSearchStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (snapshot.hasError) {
                return SliverFillRemaining(
                  child: Center(
                    child: Text('Error: ${snapshot.error}'),
                  ),
                );
              } else {
                final hotelSearchModel = snapshot.data;
                if (hotelSearchModel != null) {
                  // Data is available, build the SliverList with HotelResultsWidget
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            height: 400,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black26),
                            ),
                            child: HotelResultsWidget(
                              hotelSearchModel: hotelSearchModel,
                            ),
                          ),
                        );
                      },
                      childCount: 3,
                    ),
                  );
                } else {
                  // Data is null (error or empty), display a message
                  return const SliverFillRemaining(
                    child: Center(
                      child: Text('No data available'),
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
