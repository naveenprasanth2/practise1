import 'package:flutter/material.dart';

import '../../models/room_occupancy/room_model.dart';

class AddRoomsWidget extends StatefulWidget {
  const AddRoomsWidget({super.key});

  @override
  State<AddRoomsWidget> createState() => _AddRoomsWidgetState();
}

class _AddRoomsWidgetState extends State<AddRoomsWidget> {
  List<RoomModel> rooms = [RoomModel()];
  final ScrollController _scrollController = ScrollController();

  // Step 4: Add a new room to the list
  void addRoom() {
    setState(() {
      rooms.add(RoomModel());
      _scrollController.animateTo(
        _scrollController.position.minScrollExtent + 200,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    });
  }

  // Step 6: Remove a room from the list
  void removeRoom(int index) {
    setState(() {
      rooms.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              shrinkWrap: true,
              itemCount: rooms.length,
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
                              Text(
                                "Room ${index + 1}: ",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.grey),
                              ),
                              _buildRoomSection(
                                title: 'Adults:',
                                count: rooms[index].adults,
                                onIncrement: () {
                                  setState(() {
                                    if (rooms[index].adults < 2) {
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
              onTap: () => addRoom(),
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
