import 'package:flutter/material.dart';
import 'package:mspr/controllers/message_controller.dart';
import 'package:mspr/controllers/user_controller.dart';
import 'package:mspr/models/thread.dart';
import 'package:mspr/models/user.dart';
import 'package:mspr/share/app_style.dart';

class UserMessagesDetails extends StatefulWidget {
  const UserMessagesDetails({Key? key}) : super(key: key);

  @override
  _UserMessagesDetailsState createState() => _UserMessagesDetailsState();
}

class _UserMessagesDetailsState extends State<UserMessagesDetails> {
  List<dynamic> messages = [];
  int _selectedIndex = 1;
  late User? user;
  Thread thread = Thread(36, 26, 48, DateTime.now());

  @override
  void initState() {
    super.initState();
    MessageController.onGetMessages().then((List<dynamic> fetchedMessages) {
      setState(() {
        messages = fetchedMessages;
        print(messages);
      });
    }).catchError((error) {
      print('Failed to fetch posts: $error');
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
      backgroundColor: AppStyle.backgroundColorGreen,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
              child: Column(
                children: [
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      borderRadius:
                      const BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: Image.asset(
                            'assets/img/image-removebg-preview.png',
                            fit: BoxFit.cover,
                            width: 100,
                            height: 100,
                          ),
                          title: Text("Utilisateur ${thread.idCreator}"),
                          subtitle: const Text("Last message:"),
                          isThreeLine: true,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 5, right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              Text(
                                  "test"
                              ),
                              Icon(Icons.close_rounded),
                              SizedBox(width: 8),
                              Icon(Icons.check_box_outlined),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FutureBuilder<List<dynamic>>(
                    future: MessageController.onGetMessages(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Failed to fetch posts: ${snapshot.error}');
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            final message = messages[index];
                            user = getUser(48);
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color:
                                    Theme.of(context).colorScheme.outline,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12)),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ListTile(
                                      title: Text("${user?.firstName} ${user?.lastName}"),
                                      subtitle: Text("${message['content']}"),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ],
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

  getUser(int idUser) {
    UserController.onGetUser(idUser);
  }
}
