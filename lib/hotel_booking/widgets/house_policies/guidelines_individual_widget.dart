import 'package:flutter/material.dart';

import '../../utils/dart_helper/sizebox_helper.dart';

class GuidelinesIndividualWidget extends StatelessWidget {
  final String type;
  final String value;
  const GuidelinesIndividualWidget({super.key, required this.type, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(type == "dos")
              const Icon(Icons.check, color: Colors.green,),
            if(type == "donts")
              const Icon(Icons.do_not_disturb_alt_outlined, color: Colors.red,),
            SizedBoxHelper.sizedBox_10,
            Flexible(child: Text(value)),
          ],
        ),
        SizedBoxHelper.sizedBox10,
      ],
    );
  }
}
