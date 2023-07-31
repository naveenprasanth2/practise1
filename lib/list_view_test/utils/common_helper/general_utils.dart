import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

class GeneralUtils {
  static void copyAddressToClipboard(BuildContext context, String address) {
    FlutterClipboard.copy(address).then((value) {
      const snackBar = SnackBar(content: Text('Copied to clipboard'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }
}
