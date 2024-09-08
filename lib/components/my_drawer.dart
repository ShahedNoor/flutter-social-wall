import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              // Drawer header with logo
              DrawerHeader(
                child: Icon(
                  Icons.favorite,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),

              const SizedBox(
                height: 25.0,
              ),

              // Home tile
              Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 25),
                child: ListTile(
                  leading: Icon(Icons.home),
                  title: Text("H O M E"),
                  onTap: () {
                    // If already in home page then just pop the context
                    Navigator.pop(context);
                  },
                ),
              ),

              // Profile tile
              Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 25),
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text("P R O F I L E"),
                  onTap: () {
                    // If already in home page then just pop the context
                    Navigator.pop(context);
                  },
                ),
              ),

              // Users tile
              Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 25),
                child: ListTile(
                  leading: Icon(Icons.people),
                  title: Text("U S E R S"),
                  onTap: () {
                    // If already in home page then just pop the context
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),

          // Logout tile
          Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25, bottom: 25.0),
            child: ListTile(
              leading: Icon(Icons.logout),
              title: Text("L O G O U T"),
              onTap: () {
                // If already in home page then just pop the context
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
