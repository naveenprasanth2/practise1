import 'package:flutter/material.dart';
import '../../models/hotel_images_model/hotel_images_model.dart';
import '../../widgets/images/images_list_view.dart';

class HotelImagesBottomSheet extends StatefulWidget {
  final HotelImagesModel hotelImagesModel;
  final String tabName;

  const HotelImagesBottomSheet({
    Key? key,
    required this.hotelImagesModel,
    required this.tabName,
  }) : super(key: key);

  @override
  State<HotelImagesBottomSheet> createState() => _HotelImagesBottomSheetState();
}

class _HotelImagesBottomSheetState extends State<HotelImagesBottomSheet>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  final List<String> tabs = [
    "All",
    "Room",
    "Others",
    "Washroom",
    "Lobby",
    "Reception",
    "Facade"
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: tabs.indexOf(widget.tabName),
      length: tabs.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  pinned: true,
                  expandedHeight: 140,
                  bottom: TabBar(
                    isScrollable: true,
                    labelColor: Colors.black,
                    indicatorColor: Colors.red.shade400,
                    controller: _tabController,
                    tabs: tabs.map((value) => Tab(text: value)).toList(),
                  ),
                ),
                SliverFillRemaining(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      ImageListView(
                        images: widget.hotelImagesModel.allImages,
                        allImages: widget.hotelImagesModel.allImages,
                      ),
                      ImageListView(
                        images: widget.hotelImagesModel.room,
                        allImages: widget.hotelImagesModel.allImages,
                      ),
                      ImageListView(
                        images: widget.hotelImagesModel.others,
                        allImages: widget.hotelImagesModel.allImages,
                      ),
                      ImageListView(
                        images: widget.hotelImagesModel.washroom,
                        allImages: widget.hotelImagesModel.allImages,
                      ),
                      ImageListView(
                        images: widget.hotelImagesModel.lobby,
                        allImages: widget.hotelImagesModel.allImages,
                      ),
                      ImageListView(
                        images: widget.hotelImagesModel.reception,
                        allImages: widget.hotelImagesModel.allImages,
                      ),
                      ImageListView(
                        images: widget.hotelImagesModel.facade,
                        allImages: widget.hotelImagesModel.allImages,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 40,
              left: 10,
              child: IconButton(
                icon: const Icon(
                  Icons.close,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
