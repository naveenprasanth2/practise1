import 'package:flutter/material.dart';
import 'package:practise1/list_view_test/providers/profile_provider.dart';
import 'package:practise1/list_view_test/screens/authentication/register_screen.dart';
import 'package:practise1/list_view_test/screens/flash_screen/flash_screen.dart';
import 'package:practise1/list_view_test/screens/profile/profile_screen.dart';
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
    return Drawer(
      child: ListView(
        children: [
          FutureBuilder<String?>(
            future: getUserName(),
            builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return SizedBox(
                  height: 100,
                  child: DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.red.shade400,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Hello,',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                        Text(
                          //this is done in order to handle non login situations
                          Provider.of<ProfileProvider>(context, listen: false)
                                      .name !=
                                  null
                              ? Provider.of<ProfileProvider>(context,
                                      listen: false)
                                  .name!
                                  .split(" ")
                                  .first
                              : "Guest",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                  height: 100,
                  child: DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.red.shade400,
                    ),
                    child: const CircularProgressIndicator(),
                  ),
                );
              } else {
                return SizedBox(
                  height: 100,
                  child: DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.red.shade400,
                    ),
                    child: Text('Error: ${snapshot.error}'),
                  ),
                );
              }
            },
          ),
          if (Provider.of<AuthProvider>(context, listen: true).isSignedIn)
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('My Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    //editing profile page
                    builder: (builder) => const ProfilePage(),
                  ),
                );
              },
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
          if (Provider.of<AuthProvider>(context, listen: true).isSignedIn)
            const Divider(thickness: 1),
          if (Provider.of<AuthProvider>(context, listen: true).isSignedIn)
            ListTile(
              leading: const Icon(Icons.luggage),
              title: const Text('My Bookings'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (builder) => const MyBookingsScreen(),
                  ),
                );
              },
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
          if (Provider.of<AuthProvider>(context, listen: true).isSignedIn)
            const Divider(thickness: 1),
          if (Provider.of<AuthProvider>(context, listen: true).isSignedIn)
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('logout'),
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
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
          if (Provider.of<AuthProvider>(context, listen: true).isSignedIn)
            const Divider(thickness: 1),
          if (!Provider.of<AuthProvider>(context, listen: true).isSignedIn)
            ListTile(
              leading: const Icon(Icons.login),
              title: const Text('login'),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (builder) => const RegisterScreen(),
                    ),
                    (route) => false);
              },
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
          if (!Provider.of<AuthProvider>(context, listen: true).isSignedIn)
            const Divider(thickness: 1),
        ],
      ),
    );
  }
}
