import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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
        
    } on FirebaseAuthException catch (e) {
      GeneralUtils.showFailureSnackBar(context, e.message.toString());
    }
  }
}
