import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practise1/list_view_test/screens/authentication/otp_screen.dart';
import 'package:practise1/list_view_test/utils/common_helper/general_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool _isSignedIn = false;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool get isSignedIn => _isSignedIn;

  AuthProvider() {
    checkSignIn();
  }

  void checkSignIn() async {
    final SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    _isSignedIn = _sharedPreferences.getBool("isSignedIn") ?? false;
    notifyListeners();
  }

  void signInWithPhone(BuildContext context, String phoneNumber) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          await _firebaseAuth.signInWithCredential(phoneAuthCredential);
        },
        verificationFailed: (error) {
          GeneralUtils.showFailureSnackBar(context, error.message.toString());
          print(error.message.toString());
        },
        codeSent: (String verificationId, int? forceResendingToken) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (builder) => OtpScreen(verificationId: verificationId),
            ),
          );
        },
        codeAutoRetrievalTimeout: (verificationId) {},
      );
    } on FirebaseAuthException catch (e) {
      GeneralUtils.showFailureSnackBar(context, e.message.toString());
      print(e.message.toString());
    }
  }
}
