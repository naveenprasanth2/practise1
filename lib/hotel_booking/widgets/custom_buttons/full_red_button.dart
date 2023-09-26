import 'package:flutter/material.dart';

class FullRedButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String title;

  const FullRedButton({
    super.key,
    required this.onPressed,
    required this.title,
  });

  //TODO button still not working

  @override
  State<FullRedButton> createState() => _FullRedButtonState();
}

class _FullRedButtonState extends State<FullRedButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onPressed;
      },
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width * 0.85,
        decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
            child: Text(
          widget.title,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        )),
      ),
    );
  }
}
