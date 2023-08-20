import 'package:flutter/material.dart';
import 'package:practise1/list_view_test/providers/profile_provider.dart';
import 'package:practise1/list_view_test/utils/dart_helper/sizebox_helper.dart';
import 'package:practise1/list_view_test/widgets/profile/email_text_field.dart';
import 'package:practise1/list_view_test/widgets/profile/profile_text_field.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _gender = 'Undisclosed';
  String _maritalStatus = 'Undisclosed';
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _emailAddressController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static const List<String> _genderOptions = ['Male', 'Female', 'Undisclosed'];
  static const List<String> _maritalStatusOptions = [
    'Married',
    'Unmarried',
    'Undisclosed',
  ];

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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32),
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
                      labelText:
                          Provider.of<ProfileProvider>(context, listen: true)
                                  .dateOfBirth ??
                              'Date of Birth',
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black12),
                      ),
                    ),
                    enabled: false,
                    validator: (value) {
                      if (value != "Date of Birth") {
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
                        children: _maritalStatusOptions.map((maritalStatus) {
                          return Expanded(
                            child: InkWell(
                              onTap: () {
                                profileProvider.setMaritalStatus(maritalStatus);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: profileProvider.maritalStatus == maritalStatus
                                      ? Border.all(color: Colors.black)
                                      : const Border.symmetric(
                                      vertical: BorderSide.none,
                                      horizontal: BorderSide.none),
                                  color: profileProvider.maritalStatus == maritalStatus
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

                SizedBoxHelper.sizedBox20,
                ElevatedButton(
                  onPressed: () {
                    // Save or submit the data
                    _submitForm();
                  },
                  child: Text('Save'),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, you can perform your form submission logic
      print('Form is valid');
    } else {
      print('Form is not valid');
    }
  }
}
