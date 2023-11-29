import 'package:flutter/material.dart';

import "tabs/current_location_tab.dart";
import "tabs/locate_bus_tab.dart";
import "tabs/saved_tab.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text("Transmo"),
          ),
        ),
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
              print(index);
            });
          },
          // indicatorColor: Colors.amber[800],
          selectedIndex: currentPageIndex,
          destinations: const [
            NavigationDestination(
              selectedIcon: Icon(Icons.location_on),
              icon: Icon(Icons.location_on_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.my_location),
              icon: Icon(Icons.gps_not_fixed),
              label: 'Home',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.bookmark),
              icon: Icon(Icons.turned_in_not),
              label: 'Home',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.add_location),
              icon: Icon(Icons.add_location_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.notifications),
              icon: Icon(Icons.notifications_outlined),
              label: 'Home',
            ),
          ],
        ),
        body: [
          const CurrentLocationTab(),
          const LocateBusTab(),
          const SavedBusesTab(),
          Container(
            color: Colors.black,
            alignment: Alignment.center,
            child: const Text('Page 4'),
          ),
          Container(
            color: Colors.orange,
            alignment: Alignment.center,
            child: const Text('Page 5'),
          ),
        ][currentPageIndex]);
  }
}



// Container(
        //   child: Column(),
        //   alignment: Alignment.center,
        // ),



// Container(
            // color: Colors.red,
            // alignment: Alignment.center,
            // child: const Text('Page 1'),
          // ),