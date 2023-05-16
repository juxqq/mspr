import 'package:flutter/material.dart';
import 'package:mspr/controllers/message_controller.dart';
import 'package:mspr/controllers/thread_controller.dart';
import 'package:mspr/share/app_style.dart';

class BotanistMessages extends StatefulWidget {
  const BotanistMessages({Key? key}) : super(key: key);

  @override
  _BotanistMessagesState createState() => _BotanistMessagesState();
}

class _BotanistMessagesState extends State<BotanistMessages> {
  List<dynamic> threads = [];
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    ThreadController.onGetThreads().then((List<dynamic> fetchedThreads) {
      setState(() {
        threads = fetchedThreads;
        print(threads);
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
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.message_outlined,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Mes messages',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    FutureBuilder<List<dynamic>>(
                      future: ThreadController.onGetThreads(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Failed to fetch posts: ${snapshot.error}');
                        } else {
                          print('Threads length: ${threads.length}');
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: threads.length,
                            itemBuilder: (context, index) {
                              final thread = threads[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Card(
                                  clipBehavior: Clip.hardEdge,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      color:
                                      Theme.of(context).colorScheme.outline,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(12)),
                                  ),
                                  child: InkWell(
                                    splashColor: Colors.blue.withAlpha(30),
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, '/botanist_messages_details');
                                    },
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        ListTile(
                                          leading: Image.network(
                                            thread['creator']['profilePicture'],
                                            fit: BoxFit.cover,
                                            width: 100,
                                            height: 100,
                                          ),
                                          title: Text("${thread['creator']['firstName']} ${thread['creator']['lastName']}"),
                                          subtitle: const Text("Last message:"),
                                          isThreeLine: true,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10, bottom: 10),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                  thread['messages'][0]['content']
                                              ),
                                              const Icon(Icons.close_rounded),
                                              const SizedBox(width: 8),
                                              const Icon(Icons.check_box_outlined),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
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
          }
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
