import 'package:flutter/material.dart';
import 'package:practise1/list_view_test/models/hotel_detail_model/room_type_model.dart';
import '../../widgets/images/images_list_view.dart';

class RoomImagesOnlyWidget extends StatefulWidget {
  final RoomTypeModel roomTypeModel;
  final String tabName;

  const RoomImagesOnlyWidget({
    Key? key,
    required this.roomTypeModel,
    required this.tabName,
  }) : super(key: key);

  @override
  State<RoomImagesOnlyWidget> createState() => _RoomImagesOnlyWidgetState();
}

class _RoomImagesOnlyWidgetState extends State<RoomImagesOnlyWidget>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  final List<String> tabs = [
    "Room",
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
                  centerTitle: false,
                  expandedHeight: 140,
                  bottom: PreferredSize(
                    preferredSize: const Size(30, 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TabBar(
                          isScrollable: true,
                          labelColor: Colors.black,
                          indicatorColor: Colors.red.shade400,
                          controller: _tabController,
                          tabs: tabs.map((value) => Tab(text: value)).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverFillRemaining(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      ImageListView(
                        images: widget.roomTypeModel.imageUrls,
                        allImages: widget.roomTypeModel.imageUrls,
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
