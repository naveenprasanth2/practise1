// import 'package:flutter/material.dart';
//
// class CouldBeBetterWidget extends StatefulWidget {
//   final
//   const CouldBeBetterWidget({super.key});
//
//   @override
//   State<CouldBeBetterWidget> createState() => _CouldBeBetterWidgetState();
// }
//
// class _CouldBeBetterWidgetState extends State<CouldBeBetterWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         setState(() {
//           _selectedChipIndex = index;
//         });
//       },
//       child: Chip(
//         backgroundColor: _selectedChipIndex == index
//             ? Colors.red.shade400
//             : Colors.grey.shade200,
//         label: Text("Bedroom ${index + 1}",
//             style: TextStyle(
//               color: _selectedChipIndex == index
//                   ? Colors.white
//                   : Colors.black,
//             )),
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(20.0),
//             topRight: Radius.circular(20.0),
//             bottomLeft: Radius.circular(20.0),
//             bottomRight: Radius.circular(20.0),
//           ),
//         ),
//       ),
//     );
//   }
// }
