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
      Navigator.of(context).push(MaterialPageRoute(builder: (builder)=> const HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(color: Colors.red.shade400),
      child: const Center(
        child: Text(
          'BookAny', // Replace with your app name or logo
          style: TextStyle(
            fontSize: 50, // Set the font size// Set the font weight
            color: Colors.white, // Set the text color
          ),
        ),
      ),
    ));
  }
}
