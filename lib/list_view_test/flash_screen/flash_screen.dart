import 'package:flutter/material.dart';

import '../screens/slivers.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({super.key});

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigateToHomeScreen();
  }

  void navigateToHomeScreen() async {
    await Future.delayed(const Duration(seconds: 1)).then((value) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (builder) => const SliversTest()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.pinkAccent, Colors.purpleAccent],
        ),
      ),
      child: const Center(
        child: Text(
          "BookAny",
          style: TextStyle(letterSpacing: 2, fontSize: 25),
        ),
      ),
    ));
  }
}
