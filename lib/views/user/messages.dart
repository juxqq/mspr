import 'package:flutter/material.dart';
import 'package:mspr/models/user.dart';
import 'package:mspr/share/app_style.dart';
import 'package:mspr/models/message.dart';
import 'package:mspr/widgets/message_item.dart';

class UserMessages extends StatefulWidget {

  const UserMessages({Key? key}) : super(key: key);

  @override
  _UserMessagesState createState() => _UserMessagesState();
}

class _UserMessagesState extends State<UserMessages> {
  int _selectedIndex = 1;
  List<Message> messages = [];
  List<User> users = [];
  DateTime createdAt = DateTime(2021, 5, 11, 10, 30, 0);

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        messages = [
          Message(
              1,
              1,
              1,
              'Long message lets test the overflow and responsiveness. Long message lets test the overflow and responsiveness Long message lets test the overflow and responsiveness',
              createdAt,
          ),
          Message(
            2,
            2,
            2,
            'Hello i would love to keep your plant',
            createdAt,
          ),
          Message(
            2,
            2,
            2,
            'Still looking for someone ? Keep me updated',
            createdAt,
          ),
           Message(
            2,
            2,
            2,
            'Still looking for someone ? Keep me updated',
            createdAt,
          ),
           Message(
            2,
            2,
            2,
            'Still looking for someone ? Keep me updated',
            createdAt,
          ),

        ];
        users = [
          User(1, "Thierry", "Henry", "test@gmail.com", "test", "test", 34290, "test", "assets/img/profilepic.png", true),
          User(2, "Thierry", "Henry", "test@gmail.com", "test", "test", 34290, "test", "assets/img/profilepic.png", true),
          User(3, "Thierry", "Henry", "test@gmail.com", "test", "test", 34290, "test", "assets/img/profilepic.png", true),
          User(3, "Thierry", "Henry", "test@gmail.com", "test", "test", 34290, "test", "assets/img/profilepic.png", true),
          User(3, "Thierry", "Henry", "test@gmail.com", "test", "test", 34290, "test", "assets/img/profilepic.png", true),
        ];
      });
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/user_profile');
        break;
      case 1:
        Navigator.pushNamed(context, '/user_messages');
        break;
      case 2:
        Navigator.pushNamed(context, '/user_home');
        break;
      case 3:
        Navigator.pushNamed(context, '/user_map');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD7F4D0),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 80),
          child: Center(
            child: Column(
              children: [
                Container(
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.message_outlined, size: 42),
                        SizedBox(width: 16),
                        Text(
                          'Mes messages',
                          style: TextStyle(fontSize: 28),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 60), // add some spacing
                Container(
                  width: 400,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch, // Update the crossAxisAlignment
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemCount: messages.length,
                          itemBuilder: (BuildContext context, int index) {
                            final message = messages[index];
                            final user = getUserById(message.idSender);
                            return MessageItem(message: message, user: user);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
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

  User? getUserById(int id) {
    try {
      return users.firstWhere((user) => user.id == id);
    } catch (e) {
      return null;
    }
  }
}