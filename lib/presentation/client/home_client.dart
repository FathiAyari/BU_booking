import 'package:flutter/material.dart';
import 'package:umbrella/presentation/client/beach.dart';
import 'package:umbrella/presentation/client/my_bookings.dart';
import 'package:umbrella/presentation/client/profile.dart';
import 'package:umbrella/presentation/ressources/colors.dart';

class HomeClient extends StatefulWidget {
  const HomeClient({Key? key}) : super(key: key);

  @override
  State<HomeClient> createState() => _HomeClientState();
}

class _HomeClientState extends State<HomeClient> {
  List<Widget> pages = [Beach(), MyBookings(), MyProfile()];
  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
        icon: Icon(
          Icons.beach_access_outlined,
        ),
        label: "Files"),
    BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: "Mes reservations"),
    BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: "Profile"),
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.primary,
        selectedLabelStyle: TextStyle(color: AppColors.primary),
        unselectedLabelStyle: TextStyle(color: Colors.cyan),
        unselectedItemColor: Colors.cyan,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        items: items,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
