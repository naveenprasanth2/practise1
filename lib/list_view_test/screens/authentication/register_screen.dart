import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practise1/list_view_test/providers/auth_provider.dart';
import 'package:practise1/list_view_test/screens/home/home_page.dart';
import 'package:practise1/list_view_test/utils/dart_helper/sizebox_helper.dart';
import 'package:practise1/list_view_test/widgets/authentication/authentication_button.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController phoneController = TextEditingController();
  Country _selectedCountry = Country(
      phoneCode: "91",
      countryCode: "IN",
      e164Sc: 0,
      geographic: true,
      level: 0,
      name: "India",
      example: "India",
      displayName: "India",
      displayNameNoCountryCode: "IN",
      e164Key: "");

  @override
  Widget build(BuildContext context) {
    phoneController.selection = TextSelection.fromPosition(
      TextPosition(offset: phoneController.text.length),
    );
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 35),
              child: Column(
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red.shade500,
                    ),
                    child: Image.asset("assets/authentication.png"),
                  ),
                  SizedBoxHelper.sizedBox20,
                  const Text(
                    "Authentication",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBoxHelper.sizedBox10,
                  const Text(
                    "Please enter your phone number",
                    textAlign: TextAlign.center,
                  ),
                  SizedBoxHelper.sizedBox20,
                  TextFormField(
                    controller: phoneController,
                    maxLength: 10,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                    onChanged: (value) {
                      setState(() {
                        phoneController.text = value;
                      });
                    },
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.red,
                    decoration: InputDecoration(
                      hintText: "Enter Phone Number",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.grey.shade600),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black12),
                      ),
                      prefixIcon: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 20.0),
                        child: InkWell(
                          onTap: () {
                            showCountryPicker(
                              context: context,
                              countryListTheme: const CountryListThemeData(
                                  bottomSheetHeight: 500),
                              onSelect: (value) {
                                setState(() {
                                  _selectedCountry = value;
                                });
                              },
                            );
                          },
                          child: Text(
                            "${_selectedCountry.flagEmoji} +${_selectedCountry.phoneCode}",
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                      ),
                      suffixIcon: phoneController.text.length == 10
                          ? Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                height: 5,
                                width: 5,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.green,
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox(
                              height: 10,
                              width: 10,
                            ),
                    ),
                  ),
                  SizedBoxHelper.sizedBox20,
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: AuthenticationButton(
                        onPressed: () {
                          sendPhoneNumber();
                        },
                        text: "Send OTP"),
                  ),
                  SizedBoxHelper.sizedBox20,
                  InkWell(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (builder) => const HomeScreen(),
                          ),
                          (route) => false);
                    },
                    child: const Text(
                      "Lets do it later",
                      style: TextStyle(
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void sendPhoneNumber() {
    final AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    String phoneNumber =
        "+${_selectedCountry.phoneCode}${phoneController.text.trim()}";
    authProvider.setPhoneNumber(phoneNumber);
    authProvider.signInWithPhone(context, phoneNumber);
  }
}
