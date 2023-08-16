import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

class GeneralUtils {
  static void copyAddressToClipboard(BuildContext context, String address) {
    FlutterClipboard.copy(address).then((value) {
      const snackBar = SnackBar(content: Text('Copied to clipboard'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  static void copyBookingIdToClipboard(BuildContext context, String id) {
    FlutterClipboard.copy(id).then((value) {
      const snackBar = SnackBar(
        content: Text('Booking id copied'),
        backgroundColor: Colors.green,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  static void showSuccessSnackBar(BuildContext context, String message) {
    SnackBar snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
