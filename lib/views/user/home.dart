import 'package:flutter/material.dart';
import 'package:mspr/controllers/comment_controller.dart';
import 'package:mspr/controllers/message_controller.dart';
import 'package:mspr/controllers/thread_controller.dart';
import 'package:mspr/models/message.dart';
import 'package:mspr/services/post_service.dart';
import 'package:mspr/share/app_style.dart';
import 'package:mspr/utils/utils.dart';

class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  int _selectedIndex = 2;
  String? plantFilter;
  String? postFilter;
  final GlobalKey<FormState> _key = GlobalKey();
  List<dynamic> posts = [];
  List<dynamic> filteredPosts = [];
  DateTime createdAt = DateTime.now();
  late bool isThreadCreated = false;
  int threadId = 0;
  Message? message;
  final TextEditingController contentCommentController =
      TextEditingController();
  late TextEditingController pictureCommentController = TextEditingController();
  final TextEditingController messageMessageController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    PostService.getPosts().then((List<dynamic> fetchedPosts) {
      setState(() {
        posts = fetchedPosts;
        filteredPosts = posts;
        print(posts);
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
          child: Form(
            key: _key,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
              child: Column(
                children: [
                  SizedBox(
                    child: (Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                            flex: 1,
                            child: Container(
                              constraints: BoxConstraints(
                                  maxWidth: constraints.maxWidth * 0.4),
                              child: SizedBox(
                                width: double.infinity,
                                child: DropdownButtonFormField<String>(
                                  style: const TextStyle(
                                      fontSize: 12, color: AppStyle.colorGrey),
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.filter_alt,
                                      color: Color.fromRGBO(19, 119, 0, 100),
                                    ),
                                    suffix: null,
                                    suffixIcon: null,
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 8),
                                    isCollapsed: true,
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 0.3),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 0.3),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 0.3),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  iconSize: 0,
                                  hint: const Text("Filtrer par :"),
                                  isExpanded: true,
                                  value: plantFilter,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      plantFilter = newValue;
                                    });
                                    filterPostsCombined();
                                  },
                                  items: <String>[
                                    'Rose',
                                    'Tulipe',
                                    'Lys',
                                    'Orchidée'
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            )),
                        Flexible(
                            flex: 1,
                            child: Container(
                              constraints: BoxConstraints(
                                  maxWidth: constraints.maxWidth * 0.6),
                              child: SizedBox(
                                width: double.infinity,
                                child: DropdownButtonFormField<String>(
                                  style: const TextStyle(
                                      fontSize: 12, color: AppStyle.colorGrey),
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 8),
                                    isCollapsed: true,
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 0.3),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 0.3),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 0.3),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  hint: const Text("Voir :"),
                                  isExpanded: true,
                                  value: postFilter,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      postFilter = newValue;
                                    });
                                    filterPostsCombined();
                                  },
                                  items: <String>[
                                    'Tous les postes',
                                    'Les postes gardés',
                                    'Les postes non gardés'
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            )),
                      ],
                    )),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        );
      }),
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

  void filterPostsCombined() {
    if (plantFilter == null && postFilter == 'Tous les postes') {
      // Aucun filtre sélectionné, afficher tous les posts
      setState(() {
        filteredPosts = posts;
      });
    } else if (plantFilter != null && postFilter == null) {
      setState(() {
        filteredPosts = posts
            .where((post) => post['plant']['name'] == plantFilter)
            .toList();
      });
    } else if (plantFilter != null && postFilter == 'Tous les postes') {
      // Filtrer par plante uniquement
      setState(() {
        filteredPosts = posts
            .where((post) => post['plant']['name'] == plantFilter)
            .toList();
      });
    } else if (plantFilter == null && postFilter != 'Tous les postes') {
      // Filtrer par gardée/non gardée uniquement
      if (postFilter == 'Les postes gardés') {
        setState(() {
          filteredPosts =
              posts.where((post) => post['keeper'] != null).toList();
        });
      } else if (postFilter == 'Les postes non gardés') {
        setState(() {
          filteredPosts =
              posts.where((post) => post['keeper'] == null).toList();
        });
      }
    } else if (plantFilter != null && postFilter != 'Tous les postes') {
      // Filtrer par les deux critères
      setState(() {
        filteredPosts = posts
            .where((post) =>
                post['plant']['name'] == plantFilter &&
                ((postFilter == 'Les postes gardés' &&
                        post['keeper'] != null) ||
                    (postFilter == 'Les postes non gardés' &&
                        post['keeper'] == null)))
            .toList();
      });
    }
  }
}
