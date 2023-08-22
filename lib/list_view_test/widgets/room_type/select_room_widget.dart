import 'package:flutter/material.dart';
import 'package:practise1/list_view_test/models/hotel_detail_model/room_type_model.dart';
import 'package:practise1/list_view_test/widgets/room_type/room_images_only_widget.dart';

class SelectRoomWidget extends StatelessWidget {
  final RoomTypeModel roomTypeModel;

  const SelectRoomWidget({super.key, required this.roomTypeModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return RoomImagesOnlyWidget(
                      roomTypeModel: roomTypeModel,
                      tabName: "Room",
                    );
                  },
                );
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(roomTypeModel.imageUrls[0])),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              roomTypeModel.type,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            Row(
              children: [
                Text("${roomTypeModel.size} sqft"),
                const SizedBox(
                  width: 5,
                ),
                const Text("."),
                const SizedBox(
                  width: 5,
                ),
                Text("Max ${roomTypeModel.maxPeopleAllowed} adults per room"),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Text(
                  "₹ ${roomTypeModel.roomPrice}",
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 10,
                ),
                //get data from price provider
                const Text(
                  "₹ 5999",
                  style: TextStyle(
                    decoration: TextDecoration.lineThrough,
                    decorationColor: Colors.black,
                    decorationThickness: 2.0,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  "73% off",
                  style: TextStyle(color: Colors.green),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              height: 30,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                child: Text("Selected"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
