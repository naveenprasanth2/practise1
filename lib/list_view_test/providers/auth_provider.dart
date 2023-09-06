import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practise1/list_view_test/models/user_profile/user_profile_model.dart';
import 'package:practise1/list_view_test/providers/profile_provider.dart';
import 'package:practise1/list_view_test/screens/authentication/otp_screen.dart';
import 'package:practise1/list_view_test/utils/common_helper/general_utils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool? _isSignedIn;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  UserProfileModel? userProfileModel;
  String? _phoneNumber;
  bool _isLoading = false;
  String? _uid;

  bool get isSignedIn => _isSignedIn!;

  bool get isLoading => _isLoading;

  String get phoneNumber => _phoneNumber!;

  String get uid => _uid!;

  AuthProvider() {
    init();
  }

  Future<void> init() async {
    await checkSignIn();
  }

  setPhoneNumber(String phoneNumber) {
    _phoneNumber = phoneNumber;
  }

  void setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> checkSignIn() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    _isSignedIn = sharedPreferences.getBool("isSignedIn") ?? false;
    notifyListeners();
  }

  void setSignIn(bool value) {
    _isSignedIn = value;
  }

  Future<void> logout(BuildContext context) async {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    _isSignedIn = false;
    _firebaseAuth.signOut();
    profileProvider.clearProfileProviderData();
    authProvider.resetUserProfileModel();
    await sharedPreferences.clear();
    notifyListeners();
  }

  void signInWithPhone(BuildContext context, String phoneNumber) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          await _firebaseAuth.signInWithCredential(phoneAuthCredential);
        },
        verificationFailed: (error) {
          GeneralUtils.showFailureSnackBar(context, error.message.toString());
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
      GeneralUtils.showFailureSnackBarUsingScaffold(
          scaffoldMessenger, e.message.toString());
    }
  }

  Future<void> resendOtp(BuildContext context) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Handle automatic code verification completion
          await _firebaseAuth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          // Handle error
          GeneralUtils.showFailureSnackBar(
              context, "Failed to send OTP: ${e.message}");
        },
        codeSent: (String verificationId, int? resendToken) {
          // Handle code sent for manual verification
          GeneralUtils.showSuccessSnackBar(context, "OTP sent successfully!");
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Handle timeout
        },
        timeout: const Duration(seconds: 60),
      );
    } catch (e) {
      GeneralUtils.showFailureSnackBarUsingScaffold(
          scaffoldMessenger, "An error occurred: $e");
    }
  }

  void verifyOtp(
      {required BuildContext context,
      required String verificationId,
      required String userOtp,
      required Function onSuccess}) async {
    setIsLoading(true);
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOtp);
      User? user = (await _firebaseAuth.signInWithCredential(credential)).user;
      if (user != null) {
        //carry out logic
        _uid = user.uid;
        onSuccess();
      } else {}
    } on FirebaseAuthException catch (e) {
      GeneralUtils.showFailureSnackBarUsingScaffold(
          scaffoldMessenger, e.message.toString());
    }
    setIsLoading(false);
  }

  Future<bool> checkExistingUser() async {
    DocumentSnapshot documentSnapshot =
        await _firebaseFirestore.collection("users").doc(_phoneNumber).get();
    if (documentSnapshot.exists) {
      userProfileModel = UserProfileModel.fromJson(
          documentSnapshot.data() as Map<String, dynamic>);
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  void resetUserProfileModel() {
    userProfileModel = UserProfileModel(
        name: "Guest",
        mobileNo: "",
        emailId: "",
        dateOfBirth: "Date of Birth",
        gender: "Undisclosed",
        maritalStatus: "Undisclosed",
        uid: "");
  }
}
