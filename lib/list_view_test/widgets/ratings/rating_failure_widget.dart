import 'package:flutter/material.dart';

class RatingFailureWidget extends StatelessWidget {
  const RatingFailureWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
            8.0), // adding a rounded corner to your dialog
      ),
      elevation: 0.0, // no shadow
      backgroundColor: Colors.transparent,
      child: _dialogContent(context),
    );
  }

  _dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Icon(Icons.warning,
                  size: 50, color: Colors.red), // success icon
              const SizedBox(height: 24), // for spacing
              const Text('Please try after sometime!',
                  style: TextStyle(fontSize: 24)),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // To close the dialog
                  },
                  child: const Text("Close"),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
