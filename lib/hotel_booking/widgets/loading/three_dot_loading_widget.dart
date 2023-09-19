import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ThreeDotLoadingWidget extends StatelessWidget {
  const ThreeDotLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Center(
        child: Lottie.asset('lottie_assets/three_dot_loader.json',
            repeat: true, reverse: false, animate: true),
      ),
    );
  }
}
