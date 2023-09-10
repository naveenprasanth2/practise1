import 'package:flutter/material.dart';
import 'package:practise1/list_view_test/providers/profile_provider.dart';
import 'package:practise1/list_view_test/screens/authentication/register_screen.dart';
import 'package:practise1/list_view_test/screens/flash_screen/flash_screen.dart';
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Hello,',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBoxHelper.sizedBox10,
                              Text(
                                //this is done in order to handle non login situations
                                (Provider.of<ProfileProvider>(context,
                                                    listen: false)
                                                .name !=
                                            null &&
                                        Provider.of<ProfileProvider>(context,
                                                    listen: false)
                                                .name !=
                                            "")
                                    ? Provider.of<ProfileProvider>(context,
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
                            ],
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
                        builder: (builder) => const ProfilePage(),
                      ),
                    );
                  },
                  child: Container(
                    height: 60,
                    color: Colors.white,
                    child: Row(children: [
                      const Icon(
                        Icons.person,
                        size: 30,
                      ),
                      SizedBoxHelper.sizedBox_20,
                      const Text(
                        'My Profile',
                        style: TextStyle(fontSize: 17),
                      ),
                    ]),
                  ),
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
              if (Provider.of<AuthProvider>(context, listen: true).isSignedIn)
                InkWell(
                  onTap: () {
                    Provider.of<AuthProvider>(context, listen: false)
                        .logout(context);
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (builder) => const MySplashScreen(),
                        ),
                        (route) => false);
                  },
                  child: Container(
                    height: 60,
                    color: Colors.white,
                    child: Row(children: [
                      //made changes for this icon to align with other icons
                      const Padding(
                        padding: EdgeInsets.only(left: 5.0),
                        child: Icon(
                          Icons.logout,
                          size: 30,
                        ),
                      ),
                      SizedBoxHelper.sizedBox_15,
                      const Text('Logout', style: TextStyle(fontSize: 17)),
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
                    child: Row(children: [
                      const Icon(
                        Icons.login,
                        size: 30,
                      ),
                      SizedBoxHelper.sizedBox_20,
                      const Text(
                        'login',
                        style: TextStyle(fontSize: 17),
                      ),
                    ]),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
