import 'package:flutter/material.dart';
import 'package:practise1/list_view_test/models/hotel_detail_model/room_type_model.dart';
import 'package:practise1/list_view_test/widgets/room_type/select_room_widget.dart';

class RoomTypesWidget extends StatefulWidget {
  final List<RoomTypeModel> roomTypeModel;

  const RoomTypesWidget({
    Key? key,
    required this.roomTypeModel,
  }) : super(key: key);

  @override
  State<RoomTypesWidget> createState() => _RoomTypesWidgetState();
}

class _RoomTypesWidgetState extends State<RoomTypesWidget>
    with AutomaticKeepAliveClientMixin<RoomTypesWidget> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select a room of your preference",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(
              height: 20,
            ),
            DefaultTabController(
              length: widget.roomTypeModel.length,
              child: Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.zero,
                      child: TabBar(
                        isScrollable: true,
                        indicatorColor: Colors.red.shade400,
                        labelStyle: const TextStyle(fontSize: 13),
                        labelPadding: const EdgeInsets.only(right: 24.0),
                        physics: const BouncingScrollPhysics(),
                        tabs: widget.roomTypeModel
                            .map(
                              (roomTypes) => Tab(
                                text: roomTypes.type,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    SizedBox(
                      height: 400, // Set a specific height here
                      width: MediaQuery.of(context).size.width *  0.80,
                      child: TabBarView(
                        children: widget.roomTypeModel
                            .map(
                              (roomType) =>
                                  SelectRoomWidget(roomTypeModel: roomType),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
