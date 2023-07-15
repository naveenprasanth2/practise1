import 'package:flutter/material.dart';
import 'package:practise1/list_view_test/models/hotel_details_model.dart';

class HotelDetailScreen extends StatefulWidget {
  final HotelDetailsModel hotelDetailsModel;
   HotelDetailScreen({super.key, required this.hotelDetailsModel});

  @override
  State<HotelDetailScreen> createState() => _HotelDetailScreenState();
}

class _HotelDetailScreenState extends State<HotelDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            automaticallyImplyLeading: true,
            backgroundColor: Colors.red.shade400,
            title:  Text(
              widget.hotelDetailsModel.hotelName,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 200,
              child: ListView.builder(
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      margin:  const EdgeInsets.symmetric(horizontal: 8.0),
                      decoration:  const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/offerBanner.jpg"),
                            fit: BoxFit.cover),
                      ),
                    );
                  }),
            ),
          ),
           const SliverToBoxAdapter(
            child: SizedBox(
              height: 5,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding:  const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.white,
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        widget.hotelDetailsModel.hotelName,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            "${widget.hotelDetailsModel.townName},",
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            widget.hotelDetailsModel.cityName,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        const SizedBox(width: 10,),
                        Flexible(
                          child: InkWell(
                            onTap: () {},
                            child: const Text(
                              "Map View",
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
