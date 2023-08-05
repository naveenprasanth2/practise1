import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practise1/list_view_test/widgets/house_policies/guidelines_individual_widget.dart';

import '../../models/safe_guidelines_model/safe_guidelines_model.dart';

class SafetyGuidelinesWidget extends StatelessWidget {
  String? response;

  SafetyGuidelinesWidget({super.key});

  Future<SafetyGuidelinesModel> fetchPolicyData() async {
    response = await rootBundle.loadString('assets/safe_guidelines.json');
    return SafetyGuidelinesModel.fromJson(jsonDecode(response!));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SafetyGuidelinesModel>(
      future: fetchPolicyData(),
      builder: (BuildContext context, AsyncSnapshot<SafetyGuidelinesModel> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(height: 10,),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Do's",
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10,),
                        Column(
                          children: snapshot.data!.dos
                              .map((dosText) =>
                              GuidelinesIndividualWidget(type: "dos", value: dosText))
                              .toList(),
                        ),
                        const SizedBox(height: 20,),
                        const Text(
                          "Dont's",
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10,),
                        Column(
                          children: snapshot.data!.donts
                              .map((dosText) => GuidelinesIndividualWidget(
                              type: "donts", value: dosText))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
