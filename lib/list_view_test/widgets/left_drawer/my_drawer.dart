import 'package:flutter/material.dart';
import 'package:practise1/list_view_test/providers/profile_provider.dart';
import 'package:practise1/list_view_test/screens/authentication/register_screen.dart';
import 'package:practise1/list_view_test/screens/flash_screen/flash_screen.dart';
import 'package:practise1/list_view_test/screens/language/select_language_screen.dart';
import 'package:practise1/list_view_test/screens/profile/profile_screen.dart';
import 'package:practise1/list_view_test/utils/dart_helper/sizebox_helper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../providers/auth_provider.dart';
import '../../screens/my_bookings/my_bookings_screen.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  Future<String?> getUserName() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getString("name");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Drawer(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ListView(
            children: [
              FutureBuilder<String?>(
                future: getUserName(),
                builder:
                    (BuildContext context, AsyncSnapshot<String?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return SizedBox(
                      height: 100,
                      child: Container(
                        color: Colors.white,
                        child: DrawerHeader(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: InkWell(
                            onTap: () {
                              //check whether user signedin, if signed in navigate to profile screen
                              //else to Register screen
                              Provider.of<ProfileProvider>(context,
                                              listen: false)
                                          .name !=
                                      ""
                                  ? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        //editing profile page
                                        builder: (builder) =>
                                            const ProfilePage(),
                                      ),
                                    )
                                  : Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        //editing profile page
                                        builder: (builder) =>
                                            const RegisterScreen(),
                                      ),
                                    );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const CircleAvatar(
                                      child: Icon(
                                        Icons.person_2_outlined,
                                      ),
                                    ),
                                    SizedBoxHelper.sizedBox_20,
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBoxHelper.sizedBox10,
                                        Text(
                                          //this is done in order to handle non login situations
                                          (Provider.of<ProfileProvider>(context,
                                                              listen: false)
                                                          .name !=
                                                      null &&
                                                  Provider.of<ProfileProvider>(
                                                              context,
                                                              listen: false)
                                                          .name !=
                                                      "")
                                              ? Provider.of<ProfileProvider>(
                                                      context,
                                                      listen: false)
                                                  .name!
                                              : "Guest",
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 13,
                                          ),
                                          maxLines: 1, // Set maximum lines to 1
                                          overflow: TextOverflow
                                              .ellipsis, // Add ellipsis (...) for overflow
                                        ),
                                        Text(
                                          //this is done in order to handle non login situations
                                          (Provider.of<ProfileProvider>(context,
                                                          listen: false)
                                                      .name !=
                                                  "")
                                              ? Provider.of<ProfileProvider>(
                                                      context,
                                                      listen: false)
                                                  .mobileNo
                                              : "login",
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 13,
                                          ),
                                          maxLines: 1, // Set maximum lines to 1
                                          overflow: TextOverflow
                                              .ellipsis, // Add ellipsis (...) for overflow
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const Icon(Icons.arrow_right),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Container(
                      color: Colors.white,
                      height: 100,
                      child: const DrawerHeader(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    return Container(
                      color: Colors.white,
                      height: 100,
                      child: DrawerHeader(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Text('Error: ${snapshot.error}'),
                      ),
                    );
                  }
                },
              ),
              if (Provider.of<AuthProvider>(context, listen: true).isSignedIn)
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        //editing profile page
                        builder: (builder) => const MyBookingsScreen(),
                      ),
                    );
                  },
                  child: Container(
                    height: 60,
                    color: Colors.white,
                    child: Row(children: [
                      const Icon(
                        Icons.luggage,
                        size: 30,
                      ),
                      SizedBoxHelper.sizedBox_20,
                      const Text('My Bookings', style: TextStyle(fontSize: 17)),
                    ]),
                  ),
                ),
              if (!Provider.of<AuthProvider>(context, listen: true).isSignedIn)
                InkWell(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (builder) => const RegisterScreen(),
                        ),
                        (route) => false);
                  },
                  child: Container(
                    height: 60,
                    color: Colors.white,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.login,
                          size: 30,
                        ),
                        SizedBoxHelper.sizedBox_20,
                        const Text(
                          'login',
                          style: TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                ),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 60,
                  color: Colors.white,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.help_outline_rounded,
                        size: 30,
                      ),
                      SizedBoxHelper.sizedBox_20,
                      const Text(
                        'Need help?',
                        style: TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (builder) => SelectLanguageScreen(),
                    ),
                  );
                },
                child: Container(
                  height: 60,
                  color: Colors.white,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.language_outlined,
                        size: 30,
                      ),
                      SizedBoxHelper.sizedBox_20,
                      const Text(
                        'Change language',
                        style: TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (builder) => SelectLanguageScreen(),
                    ),
                  );
                },
                child: Container(
                  height: 60,
                  color: Colors.white,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.lock_outline,
                        size: 30,
                      ),
                      SizedBoxHelper.sizedBox_20,
                      const Text(
                        'Privacy policy',
                        style: TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
