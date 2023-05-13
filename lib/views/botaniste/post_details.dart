import 'package:flutter/material.dart';
import 'package:mspr/share/app_style.dart';

class BotanistPostDetails extends StatefulWidget {
  const BotanistPostDetails({Key? key}) : super(key: key);

  @override
  _BotanistPostDetailsState createState() => _BotanistPostDetailsState();
}

class _BotanistPostDetailsState extends State<BotanistPostDetails> {
  int _selectedIndex = 0;
  final GlobalKey<FormState> _key = GlobalKey();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/botanist_profile');
        break;
      case 1:
        Navigator.pushNamed(context, '/botanist_messages');
        break;
      case 2:
        Navigator.pushNamed(context, '/botanist_home');
        break;
      case 3:
        Navigator.pushNamed(context, '/botanist_map');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.backgroundColorGreen,
      appBar: AppBar(
        backgroundColor: AppStyle.backgroundColorGreen,
        shadowColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_circle_left_outlined),
          iconSize: 34,
          color: Colors.grey,
          onPressed: () {
            Navigator.pushNamed(context, "/botanist_home");
          },
        ),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: Form(
              key: _key,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                child: Column(
                  children: [

                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        iconSize: 30,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box_outlined),
            label: "",
            backgroundColor: AppStyle.bottomNavBarColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message_outlined),
            label: "",
            backgroundColor: AppStyle.bottomNavBarColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "",
            backgroundColor: AppStyle.bottomNavBarColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            label: "",
            backgroundColor: AppStyle.bottomNavBarColor,
          ),
        ],
      ),
    );
  }
}
