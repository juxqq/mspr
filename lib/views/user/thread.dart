import 'package:flutter/material.dart';
import 'package:mspr/models/post.dart';
import 'package:mspr/models/user.dart';
import 'package:mspr/share/app_style.dart';
import 'package:mspr/models/message.dart';
import 'package:mspr/utils/utils.dart';


class UserThread extends StatefulWidget {
  const UserThread({Key? key}) : super(key: key);

  @override
  _UserThreadState createState() => _UserThreadState();
}

class _UserThreadState extends State<UserThread> {
  int _selectedIndex = 1;
  List<User> users = [];
  DateTime createdAt = DateTime(2021, 5, 11, 10, 30, 0);
  // api call to first message of the thread
  Post post = Post(
      1,
      0,
      'Beautiful red rose',
      'J essaye de mettre une description plus grande que l actuelle pour tester le responsive et l overflow',
      'assets/img/image-removebg-preview.png',
      1,
      "10",
      "10",
      DateTime(2002, 5, 17, 10, 30, 0),
      DateTime(2002, 5, 17, 10, 30, 0));
  User user1 = User(1, "Thierry", "Henry", "test@gmail.com", "test", "test", 34290,
      "test", "", true);
  User user2 = User(2, "Osaka", "Akiyuki", "osaka@gmail.com", "test", "test", 34290,
      "test",  "assets/img/profilepic.png", false);


  List<Message> messages = [];
  final GlobalKey<FormState> _key = GlobalKey();
  final TextEditingController contentMessageController = TextEditingController();

  bool isCheckClicked = false;



  @override
  void initState() {
    super.initState();
    users = [user1, user2];
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        messages = [
          Message(
            6,
            1,
            2,
            'Hello i would love to keep your plant',
            createdAt,
          ),
          Message(
            7,
            1,
            1,
            'Hello my pleasure, this is a rose',
            createdAt,
          ),
          Message(
            19,
            1,
            2,
            'Perfect',
            createdAt,
          ),
          Message(
            19,
            1,
            2,
            'What are your whereabouts ?',
            createdAt,
          ),
          Message(
            20,
            1,
            1,
            'Im near the beach area',
            createdAt,
          ),
          Message(
            19,
            1,
            2,
            'Great that works well on my end',
            createdAt,
          ),

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
      backgroundColor: AppStyle.backgroundColorGreen,
      appBar: AppBar(
        backgroundColor: AppStyle.backgroundColorGreen,
        shadowColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_circle_left_outlined),
          iconSize: 34,
          color: Colors.grey,
          onPressed: () {
            Navigator.pushNamed(context, "/user_messages");
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
                    Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                      ),
                      child: ListTile(
                        title: Text(
                          post.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,

                          ),
                        ),

                        subtitle: Row(
                          children: [
                            Flexible(
                              child: Text(
                                '${user1.firstName} ${user1.lastName} a postulé',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            if (!isCheckClicked) ...[
                              Container(
                                padding: const EdgeInsets.all(4),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.clear,
                                    color: Colors.red,
                                    size: 36,
                                  ),
                                  onPressed: () {

                                    // Delete the thread

                                    setState(() {
                                      isCheckClicked = false;
                                    });
                                  },
                                ),
                              ),
                            ],
                            const SizedBox(width: 8),
                            if (!isCheckClicked) ...[
                              Container(
                                padding: const EdgeInsets.all(4),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.check,
                                    color: Colors.green,
                                    size: 36,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isCheckClicked = true;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ],
                        ),
                        trailing: Image.asset(
                          post.pictureUrl,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        isThreeLine: true,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: messages.length,
                      itemBuilder: (BuildContext context, int index) {
                        final message = messages[index];
                        final user = getUserById(message.idSender);
                        final isSender = message.idSender == user1.id; // Check if the message is sent by the user1 (sender)
                        final messageAlignment = isSender ? MainAxisAlignment.end : MainAxisAlignment.start;
                        final messageColor = isSender ? Colors.lightBlue : Colors.lightGreen;
                        final borderRadius = isSender
                            ? const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        )
                            : const BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        );

                        return GestureDetector(
                          child: Container(
                            decoration: BoxDecoration(
                              color: messageColor,
                              borderRadius: borderRadius,
                            ),
                            padding: const EdgeInsets.all(8),
                            margin: const EdgeInsets.only(bottom: 16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (!isSender) ...[
                                  CircleAvatar(
                                    backgroundImage: AssetImage(user?.profilePicture ?? ''),
                                  ),
                                  const SizedBox(width: 8),
                                ],
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: messageAlignment,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: messageAlignment,
                                        children: [
                                          if (!isSender) ...[
                                            Text(
                                              '${user?.firstName} ${user?.lastName}',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        message.content,
                                        style: TextStyle(
                                          color: isSender ? Colors.white : Colors.black,
                                          fontWeight: isSender ? FontWeight.normal : FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: TextFormField(
                              controller: contentMessageController,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Type a message',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                  borderSide: BorderSide.none,

                                ),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.send),
                          color: Colors.blue,
                          onPressed: () {
                            // Handle send button pressed
                              if (_key.currentState!
                                  .validate()) {
                                if (contentMessageController
                                    .text.isEmpty) {
                                  showSnackBar(
                                      context,
                                      "Vous ne pouvez pas mettre un commentaire vide !",
                                      Colors.red);
                                } else {
                                  // Ajouter ici l'enregistrement du message


                                  contentMessageController.clear();
                                }
                              }
                          },
                        ),
                      ],
                    ),
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

  User? getUserById(int id) {
    try {
      return users.firstWhere((user) => user.id == id);
    } catch (e) {
      return null;
    }
  }
}
