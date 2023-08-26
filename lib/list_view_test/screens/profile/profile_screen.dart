import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:practise1/list_view_test/models/user_profile/user_profile_model.dart';
import 'package:practise1/list_view_test/providers/profile_provider.dart';
import 'package:practise1/list_view_test/screens/home/home_page.dart';
import 'package:practise1/list_view_test/utils/common_helper/general_utils.dart';
import 'package:practise1/list_view_test/utils/dart_helper/sizebox_helper.dart';
import 'package:practise1/list_view_test/utils/string_utils.dart';
import 'package:practise1/list_view_test/widgets/profile/email_text_field.dart';
import 'package:practise1/list_view_test/widgets/profile/profile_text_field.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailAddressController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static const List<String> _genderOptions = ['Male', 'Female', 'Undisclosed'];
  static const List<String> _maritalStatusOptions = [
    'Married',
    'Unmarried',
    'Undisclosed',
  ];
  late final UserProfileModel _userProfileModel;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(builder: (context, profileProvider, _) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Profile Page',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.red,
        ),
        body: profileProvider.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      ProfileTextField(
                          labelText: "Name",
                          hintText: 'Enter your Name',
                          enabled: true,
                          textEditingController: _nameController),
                      SizedBoxHelper.sizedBox10,
                      EmailTextField(
                          labelText: "Email",
                          hintText: "Enter your email",
                          enabled: true,
                          textEditingController: _emailAddressController),
                      SizedBoxHelper.sizedBox10,
                      InkWell(
                        onTap: () {
                          Provider.of<ProfileProvider>(context, listen: false)
                              .setDateOfBirth(context);
                        },
                        child: TextFormField(
                          controller: _dateOfBirthController,
                          decoration: InputDecoration(
                            labelText: Provider.of<ProfileProvider>(context,
                                        listen: true)
                                    .dateOfBirth ??
                                'Date of Birth',
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Colors.black12),
                            ),
                          ),
                          enabled: false,
                          validator: (value) {
                            if (value == "Date of Birth") {
                              return 'Please enter your date of birth';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBoxHelper.sizedBox10,
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Gender: ',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBoxHelper.sizedBox10,
                          Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // Distribute space evenly
                              children: _genderOptions.map((gender) {
                                return Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      profileProvider.setGender(gender);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: profileProvider.gender == gender
                                            ? Border.all(color: Colors.black)
                                            : const Border.symmetric(
                                                vertical: BorderSide.none,
                                                horizontal: BorderSide.none),
                                        color: profileProvider.gender == gender
                                            ? Colors.white
                                            : Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Center(child: Text(gender)),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      SizedBoxHelper.sizedBox10,
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Marital status: ',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBoxHelper.sizedBox10,
                          Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // Distribute space evenly
                              children:
                                  _maritalStatusOptions.map((maritalStatus) {
                                return Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      profileProvider
                                          .setMaritalStatus(maritalStatus);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: profileProvider.maritalStatus ==
                                                maritalStatus
                                            ? Border.all(color: Colors.black)
                                            : const Border.symmetric(
                                                vertical: BorderSide.none,
                                                horizontal: BorderSide.none),
                                        color: profileProvider.maritalStatus ==
                                                maritalStatus
                                            ? Colors.white
                                            : Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Center(child: Text(maritalStatus)),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      SizedBoxHelper.sizedBox50,
                      InkWell(
                        onTap: () {
                          _submitForm();
                        },
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.red.shade400,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Center(
                            child: Text(
                              "Continue",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      );
    });
  }

  void _submitForm() async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final ProfileProvider profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    await profileProvider.setName(_nameController.text.trim());
    String formattedName =
        StringUtils.convertToSentenceCaseForAll(profileProvider.name);
    await profileProvider.setName(formattedName);
    profileProvider.setEmailId(_emailAddressController.text.trim());
    profileProvider.setIsLoading(true);
    if (_formKey.currentState!.validate()) {
      // If the form is valid, you can perform your form submission logic
      _userProfileModel = UserProfileModel(
          name: profileProvider.name,
          mobileNo: profileProvider.mobileNo,
          emailId: profileProvider.emailId,
          dateOfBirth: profileProvider.dateOfBirth!,
          gender: profileProvider.gender,
          maritalStatus: profileProvider.maritalStatus,
          uid: profileProvider.uid);
      try {
        await _firebaseFirestore
            .collection("users")
            .doc(profileProvider.mobileNo)
            .set(_userProfileModel.toJson())
            .then((value) {
          profileProvider.setSignIn(true);
          profileProvider.setIsLoading(false);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (builder) => const HomeScreen()),
              (route) => false);
        });
      } on FirebaseException catch (error) {
        GeneralUtils.showFailureSnackBarUsingScaffold(
            scaffoldMessenger, error.message.toString());
      }
    } else {
      GeneralUtils.showFailureSnackBarUsingScaffold(
          scaffoldMessenger, "Please enter all the fields");
    }
  }
}
