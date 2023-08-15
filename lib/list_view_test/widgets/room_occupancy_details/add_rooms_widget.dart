import 'package:flutter/material.dart';
import 'package:practise1/list_view_test/providers/calculation_provider.dart';
import 'package:practise1/list_view_test/providers/count_provider.dart';
import 'package:provider/provider.dart';

import '../../models/room_occupancy/room_model.dart';

class AddRoomsWidget extends StatefulWidget {
  const AddRoomsWidget({super.key});

  @override
  State<AddRoomsWidget> createState() => _AddRoomsWidgetState();
}

class _AddRoomsWidgetState extends State<AddRoomsWidget> {
  late List<RoomModel> rooms;
  final ScrollController _scrollController = ScrollController();
  final listViewKey = GlobalKey();

  void addRoom() {
    setState(() {
      rooms.add(RoomModel());
      if (!isItemVisible(rooms.length - 1)) {
        _scrollController
            .jumpTo(_scrollController.position.maxScrollExtent + 100);
      }
    });
  }

  bool isItemVisible(int index) {
    var itemKey = GlobalKey();
    RenderBox? itemRenderBox =
        itemKey.currentContext?.findRenderObject() as RenderBox?;
    RenderBox? listRenderBox =
        listViewKey.currentContext?.findRenderObject() as RenderBox?;

    if (itemRenderBox != null && listRenderBox != null) {
      double itemStart =
          itemRenderBox.localToGlobal(Offset.zero, ancestor: listRenderBox).dy;
      double itemEnd = itemStart + itemRenderBox.size.height;

      return (itemEnd > _scrollController.position.extentBefore) &&
          (itemStart < _scrollController.position.extentAfter);
    } else {
      return false;
    }
  }

  // Step 6: Remove a room from the list
  void removeRoom(int index) {
    setState(() {
      rooms.removeAt(index);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //creating a deep copy of the rooms model instead of shallow copy like List.from()
    rooms = context
        .read<CountProvider>()
        .roomsInfo
        .map((room) => room.clone())
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CalculationProvider>(
      builder: (context, calculationProvider, _) {
        return SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            children: [
              Row(
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  IconButton(
                    onPressed: () {
                      rooms = List.from(
                          Provider.of<CountProvider>(context, listen: false)
                              .roomsInfo);
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  shrinkWrap: true,
                  itemCount: rooms.length,
                  key: listViewKey,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Container(
                            height: 170,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Room ${index + 1}: ",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Colors.grey),
                                      ),
                                      Text(
                                        "${rooms[index].adults + rooms[index].children} guests",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Colors.grey),
                                      )
                                    ],
                                  ),
                                  _buildRoomSection(
                                    title: 'Adults:',
                                    count: rooms[index].adults,
                                    onIncrement: () {
                                      setState(() {
                                        if (rooms[index].adults < calculationProvider.roomSelection.maxPeopleAllowed) {
                                          rooms[index].adults++;
                                        }
                                      });
                                    },
                                    onDecrement: () {
                                      setState(() {
                                        if (rooms[index].adults > 1) {
                                          rooms[index].adults--;
                                        }
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: CustomPaint(
                                      painter: DottedLinePainter(),
                                    ),
                                  ),
                                  _buildRoomSection(
                                    title: 'Children:',
                                    count: rooms[index].children,
                                    onIncrement: () {
                                      setState(() {
                                        if (rooms[index].children < 1) {
                                          rooms[index].children++;
                                        }
                                      });
                                    },
                                    onDecrement: () {
                                      setState(() {
                                        if (rooms[index].children > 0) {
                                          rooms[index].children--;
                                        }
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: CustomPaint(
                                      painter: DottedLinePainter(),
                                    ),
                                  ),
                                  if (index == 0) const SizedBox(height: 30),
                                  if (index != 0)
                                    InkWell(
                                      onTap: () => removeRoom(index),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.delete,
                                              color: Colors.red.shade300,
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              'Remove Room',
                                              style: TextStyle(
                                                color: Colors.red.shade300,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          if (index == rooms.length - 1 && index < 4)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: InkWell(
                                onTap: () => addRoom(),
                                child: Container(
                                  height: 30,
                                  // Increase the height to accommodate the content
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                  child: const Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.add),
                                        SizedBox(width: 5),
                                        Text('Add Room'),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 100, left: 10, right: 10),
                child: InkWell(
                  onTap: () {
                    Provider.of<CountProvider>(context, listen: false)
                        .setRoomsDetails(rooms);
                    Provider.of<CalculationProvider>(context, listen: false)
                        .setRoomsInfo(rooms);
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 30,
                    // Increase the height to accommodate the content
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.red.shade400,
                    ),
                    child: const Center(
                      child: Text(
                        'Apply',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }

  Widget _buildRoomSection({
    required String title,
    required int count,
    required VoidCallback onIncrement,
    required VoidCallback onDecrement,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Container(
          height: 30,
          width: 120, // Adjust the width as needed
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: onDecrement,
                icon: const Icon(Icons.remove),
                iconSize: 18,
              ),
              Text(
                count.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              IconButton(
                onPressed: onIncrement,
                icon: Icon(
                  Icons.add,
                  color: (count < 2) ? Colors.black : Colors.grey,
                ),
                iconSize: 18,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    const gap = 3;
    const dashWidth = 3;
    var startX = 0.0;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + gap;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
