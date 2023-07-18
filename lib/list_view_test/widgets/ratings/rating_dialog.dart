import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

void showCustomRatingDialog(BuildContext context) {
  double userRating = 0;
  TextEditingController _descriptionController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return Align(
        alignment: Alignment.center,
        child: FractionallySizedBox(
          widthFactor: 1, // 70% of the screen width
          child: Dialog(
            backgroundColor: Colors.transparent, // Set the background color of the dialog to transparent
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(
              color: Colors.white, // Set the background color of the dialog's parent container to white
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Rate this Hotel",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(height: 8),
                  RatingBar.builder(
                    initialRating: userRating,
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) {
                      return const Icon(
                        Icons.star,
                        color: Colors.amber,
                      );
                    },
                    onRatingUpdate: (rating) {
                      userRating = rating;
                    },
                  ),
                  const SizedBox(height: 16,),
                  TextFormField(
                    controller: _descriptionController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      hintText: 'Enter your comments or feedback',
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Handle the user rating here
                      String description = _descriptionController.text.trim();
                      if (userRating >= 1.0) {
                        // Positive rating
                        print('User rated with $userRating stars.');
                        print('Description: $description');
                      } else {
                        // Negative rating or dialog dismissed
                        print('User did not rate the hotel.');
                      }
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.red, // Red-themed button
                      disabledBackgroundColor: Colors.white,
                    ),
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
