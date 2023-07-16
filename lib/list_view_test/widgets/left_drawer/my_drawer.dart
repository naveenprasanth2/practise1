import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
           SizedBox(
            height: 100,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red.shade400,
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello,',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),

                  Text(
                    'Naveen',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              // Handle drawer item tap for home
              Navigator.pop(context); // Close the drawer
              // Add your logic for navigating to the home page
            },
            trailing: const Icon(Icons.arrow_forward_ios),
          ),

          const Divider(thickness: 1),

          ListTile(
            leading: const Icon(Icons.luggage),
            title: const Text('My Bookings'),
            onTap: () {
              // Handle drawer item tap for home
              Navigator.pop(context); // Close the drawer
              // Add your logic for navigating to the home page
            },
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
          const Divider(thickness: 1),
        ],
      ),
    );
  }
}
