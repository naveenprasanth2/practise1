import 'package:flutter/material.dart';

class GuidelinesIndividualWidget extends StatelessWidget {
  final String type;
  final String value;
  const GuidelinesIndividualWidget({super.key, required this.type, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(type == "dos")
          const Icon(Icons.check, color: Colors.green,),
        if(type == "donts")
          const Icon(Icons.warning, color: Colors.red,),
        const SizedBox(width: 10,),
        Flexible(child: Text(value))
      ],
    );
  }
}
