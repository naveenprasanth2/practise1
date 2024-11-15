import 'package:flutter/material.dart';
import 'package:practise1/list_view_test/models/hotel_detail_model/room_type_model.dart';
import 'package:practise1/list_view_test/providers/calculation_provider.dart';
import 'package:practise1/list_view_test/widgets/room_type/room_images_only_widget.dart';
import 'package:provider/provider.dart';

import '../../utils/dart_helper/sizebox_helper.dart';
import '../../utils/price_helper/price_helper.dart';
import '../../utils/string_utils.dart';

class SelectRoomWidget extends StatelessWidget {
  final RoomTypeModel roomTypeModel;

  const SelectRoomWidget({super.key, required this.roomTypeModel});

  @override
  Widget build(BuildContext context) {
    return Consumer<CalculationProvider>(
        builder: (context, calculationProvider, _) {
      return Card(
        color: Colors.white,
        shadowColor: Colors.black,
        surfaceTintColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            color: Colors.white,
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
                  StringUtils.convertToSentenceCase(roomTypeModel.type),
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
                    Text(
                        "Max ${roomTypeModel.maxPeopleAllowed} adults per room"),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Text(
                      "₹ ${roomTypeModel.discountedPrice}",
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    //get data from price provider
                    Text(
                      "₹ ${roomTypeModel.price}",
                      style: const TextStyle(
                        decoration: TextDecoration.lineThrough,
                        decorationColor: Colors.black,
                        decorationThickness: 2.0,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "${PriceHelper.findPriceDiffInPercentage(roomTypeModel.price, roomTypeModel.discountedPrice)}% off",
                      style: const TextStyle(color: Colors.green),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    calculationProvider.setRoomType(roomTypeModel);
                  },
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          (calculationProvider
                                      .roomSelection.roomTypeModel?.type ==
                                  roomTypeModel.type)
                              ? const Text(
                                  "Selected",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                              : const Text(
                                  "Select",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                          SizedBoxHelper.sizedBox_5,
                          if (calculationProvider
                                  .roomSelection.roomTypeModel?.type ==
                              roomTypeModel.type)
                            const Icon(Icons.check),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
