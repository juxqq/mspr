import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatefulWidget {
  const AppBarWidget({Key? key}) : super(key: key);

  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  PageController _pageController = PageController();
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return BottomNavyBar(
      iconSize: 25,
      selectedIndex: _selectedIndex,
      onItemSelected: (index) {
        setState(() => _selectedIndex = index);
        _pageController.jumpToPage(index);
      },
      items: [
        BottomNavyBarItem(
          icon: const Icon(Icons.home_outlined),
          title: const Text('Home'),
          activeColor: Colors.green,
        ),
        BottomNavyBarItem(
            icon: const Icon(Icons.assignment_ind_outlined),
            title: const Text('Profile'),
            activeColor: Colors.green),
        BottomNavyBarItem(
            icon: const Icon(Icons.local_florist_outlined),
            title: const Text('Botanistes'),
            activeColor: Colors.green),
        BottomNavyBarItem(
            icon: Icon(Icons.location_on_outlined),
            title: Text('Carte'),
            activeColor: Colors.green),
      ],
    );
  }
}
