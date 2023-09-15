import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:practise1/hotel_booking/providers/auth_provider.dart';
import 'package:practise1/hotel_booking/providers/profile_provider.dart';
import 'package:practise1/hotel_booking/screens/home/home_page.dart';
import 'package:practise1/hotel_booking/screens/profile/profile_screen.dart';
import 'package:practise1/hotel_booking/utils/common_helper/general_utils.dart';
import 'package:practise1/hotel_booking/widgets/authentication/authentication_button.dart';
import 'package:provider/provider.dart';

import '../../models/user_profile/user_profile_model.dart';
import '../../utils/dart_helper/sizebox_helper.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;

  const OtpScreen({
    super.key,
    required this.verificationId,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String? otpCode;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final bool isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;
    return Scaffold(
      body: SafeArea(
        child: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                ),
              )
            : SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 25, horizontal: 35),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.arrow_back_ios),
                          ),
                        ),
                        Container(
                          width: 200,
                          height: 200,
                          padding: const EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red.shade500,
                          ),
                          child: Image.asset("assets/verification.png"),
                        ),
                        SizedBoxHelper.sizedBox20,
                        const Text(
                          "Verification",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        SizedBoxHelper.sizedBox10,
                        const Text(
                          "Please enter your code",
                          textAlign: TextAlign.center,
                        ),
                        SizedBoxHelper.sizedBox20,
                        Pinput(
                          length: 6,
                          showCursor: true,
                          defaultPinTheme: PinTheme(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.red),
                              ),
                              textStyle: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                          onSubmitted: (value) {
                            setState(() {
                              otpCode = value;
                            });
                          },
                          onChanged: (value) {
                            setState(() {
                              otpCode = value;
                            });
                          },
                        ),
                        SizedBoxHelper.sizedBox20,
                        SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: AuthenticationButton(
                            onPressed: () {
                              if (otpCode != null) {
                                verifyOtp(context, otpCode!);
                              } else {
                                GeneralUtils.showFailureSnackBar(
                                    context, "Please enter 6-digit Code");
                              }
                            },
                            text: "Verify",
                          ),
                        ),
                        SizedBoxHelper.sizedBox20,
                        const Text(
                          "Didn't receive any code?",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.black38),
                        ),
                        SizedBoxHelper.sizedBox10,
                        InkWell(
                          onTap: () async {
                            Provider.of<AuthProvider>(context, listen: false)
                                .resendOtp(context);
                          },
                          child: const Text(
                            "Resend New Code",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  void verifyOtp(BuildContext context, String userOtp) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    final ProfileProvider profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    authProvider.verifyOtp(
        context: context,
        verificationId: widget.verificationId,
        userOtp: userOtp,
        onSuccess: () {
          //checking whether user exists in db or not
          authProvider.checkExistingUser().then((value) async {
            if (value == true) {
              profileProvider.setSignIn(true);
              try {
                await _firebaseFirestore
                    .collection("users")
                    .doc(Provider.of<AuthProvider>(context, listen: false)
                        .phoneNumber)
                    .get()
                    .then((document) {
                  if (document.exists) {
                    //setting this bcoz, its from two different providers
                    authProvider.setSignIn(true);
                    profileProvider.setSignIn(true);
                    Map<String, dynamic>? data =
                        document.data(); // Handle nullable data
                    if (data != null) {
                      profileProvider.setProfileDataFromModel(
                          UserProfileModel.fromJson(data));
                      profileProvider.setIsLoading(false);
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => const HomeScreen()),
                          (route) => false);
                    }
                  }
                });
              } on FirebaseException catch (error) {
                GeneralUtils.showFailureSnackBarUsingScaffold(
                    scaffoldMessenger, error.message.toString());
              }
            } else {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (builder) => const ProfilePage()),
                  (route) => false);
              profileProvider.setUid(authProvider.uid);
              profileProvider.setMobileNo(authProvider.phoneNumber);
            }
          });
        });
  }
}
