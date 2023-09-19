import 'package:flutter/material.dart';
import 'package:practise1/hotel_booking/providers/profile_provider.dart';
import 'package:practise1/hotel_booking/utils/dart_helper/sizebox_helper.dart';
import 'package:provider/provider.dart';

class GuestNameEditWidget extends StatefulWidget {
  const GuestNameEditWidget({super.key});

  @override
  State<GuestNameEditWidget> createState() => _GuestNameEditWidgetState();
}

class _GuestNameEditWidgetState extends State<GuestNameEditWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController textEditingController = TextEditingController();
  String? guestName;
  void saveGuestName() {
    if (guestName != null) {
      Provider.of<ProfileProvider>(context, listen: false)
          .setReservedFor(guestName!);
    }
    Navigator.pop(context); // Close the popup
  }

  @override
  void initState() {
    textEditingController.text =
        Provider.of<ProfileProvider>(context, listen: false).reservedFor ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Enter guest name:',
                style: TextStyle(fontSize: 15),
              ),
              SizedBoxHelper.sizedBox15,
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: textEditingController,
                  onChanged: (value) {
                    guestName = value;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a valid name';
                    } else if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]')
                        .hasMatch(value)) {
                      return 'Please enter a name without special characters or numbers';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: InkWell(
                  onTap: () {
                    _submitForm();
                  },
                  child: Container(
                    height: 50,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.red.shade400,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(
                      child: Text(
                        'Save',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
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
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      saveGuestName();
    }
  }
}
