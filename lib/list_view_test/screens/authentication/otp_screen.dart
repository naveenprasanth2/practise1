import 'package:flutter/material.dart';

import '../../utils/dart_helper/sizebox_helper.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;

  const OtpScreen({
    super.key,
    required this.verificationId,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 35),
              child: Column(
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red.shade500,
                    ),
                    child: Image.asset("assets/verification.png"),
                  ),
                  SizedBoxHelper.sizedBox20,
                  const Text(
                    "Verification",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBoxHelper.sizedBox10,
                  const Text(
                    "Please enter your code",
                    textAlign: TextAlign.center,
                  ),
                  SizedBoxHelper.sizedBox20,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
