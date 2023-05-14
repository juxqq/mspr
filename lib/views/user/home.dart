import 'package:flutter/material.dart';
import 'package:mspr/controllers/comment_controller.dart';
import 'package:mspr/controllers/message_controller.dart';
import 'package:mspr/controllers/thread_controller.dart';
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
  List<String> messages = [];
  DateTime createdAt = DateTime.now();
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
                  FutureBuilder<List<dynamic>>(
                    future: PostService.getPosts(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Failed to fetch posts: ${snapshot.error}');
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: filteredPosts.length,
                          itemBuilder: (context, index) {
                            final post = filteredPosts[index];
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
                                        context, '/user_post_details');
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      ListTile(
                                        title: Text(post['title']),
                                        subtitle: Text(post['description']),
                                        trailing: Image.network(
                                          post['pictureUrl'],
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                        isThreeLine: true,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5, right: 15, bottom: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            post['keeper'] == null
                                                ? MaterialButton(
                                              onPressed: () {
                                                showModalBottomSheet<void>(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return Container(
                                                      height: 350,
                                                      padding: const EdgeInsets.all(20),
                                                      color: Colors.white,
                                                      child: Column(
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          const Text(
                                                            'Votre message',
                                                            style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight: FontWeight.bold,
                                                            ),
                                                          ),
                                                          const SizedBox(height: 10),
                                                          TextFormField(
                                                            maxLines: 9,
                                                            controller: messageMessageController,
                                                            decoration: const InputDecoration(
                                                              labelText: 'Contenu',
                                                              border: OutlineInputBorder(),
                                                              filled:
                                                              true,
                                                              fillColor:
                                                              AppStyle
                                                                  .backgroundColorGreen,
                                                            ),
                                                          ),
                                                          const SizedBox(height: 15),
                                                          MaterialButton(
                                                            onPressed:
                                                                () {
                                                              if (_key
                                                                  .currentState!
                                                                  .validate()) {
                                                                if (messageMessageController
                                                                    .text
                                                                    .isEmpty) {
                                                                  showSnackBar(
                                                                    context,
                                                                    "Vous ne pouvez pas écrire un message vide !",
                                                                    Colors.red,
                                                                  );
                                                                  Navigator.pop(
                                                                      context);
                                                                } else {
                                                                  DateTime
                                                                  createdAt =
                                                                  DateTime.now();
                                                                  String
                                                                  formattedDate =
                                                                  createdAt.toIso8601String();
                                                                  messages[0] = messageMessageController.text;
                                                                  ThreadController
                                                                      .onCreateThread(
                                                                    post['id'],
                                                                    post['user']['id'],
                                                                    formattedDate,
                                                                   messages,
                                                                  ).then(
                                                                          (success) {
                                                                        if (success) {
                                                                          showSnackBar(
                                                                            context,
                                                                            'Commentaire créé avec succès !',
                                                                            Colors.green,
                                                                          );
                                                                          Navigator.pop(context);
                                                                          messageMessageController.text = '';
                                                                        } else {
                                                                          showSnackBar(
                                                                            context,
                                                                            'Erreur lors de la création du commentaire',
                                                                            Colors.red,
                                                                          );
                                                                        }
                                                                      }).catchError(
                                                                          (error) {
                                                                        showSnackBar(
                                                                          context,
                                                                          'Erreur lors de la création du commentaire : $error',
                                                                          Colors.red,
                                                                        );
                                                                      });
                                                                }
                                                              }
                                                            },
                                                            height: 40,
                                                            color: AppStyle.colorGreen,
                                                            padding: const EdgeInsets.symmetric(horizontal: 20),
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(12.0),
                                                            ),
                                                            child: const Text(
                                                              "Postuler",
                                                              style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 16.0,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                                    height: 30,
                                                    color: AppStyle.colorGreen,
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 20),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.0),
                                                    ),
                                                    child: const Text(
                                                      "Postuler",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 13.0,
                                                      ),
                                                    ),
                                                  )
                                                : IconButton(
                                                    icon: const Icon(
                                                        Icons.comment),
                                                    onPressed: () {
                                                      showModalBottomSheet<
                                                          void>(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return Container(
                                                            height: 300,
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(20),
                                                            color: Colors.white,
                                                            child: Center(
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  TextFormField(
                                                                    maxLines: 9,
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            13,
                                                                        color: AppStyle
                                                                            .colorGrey),
                                                                    controller:
                                                                        contentCommentController,
                                                                    decoration:
                                                                        const InputDecoration(
                                                                      hintText:
                                                                          'Entrez votre commentaire...',
                                                                      border: InputBorder
                                                                          .none,
                                                                      contentPadding: EdgeInsets.symmetric(
                                                                          vertical:
                                                                              15,
                                                                          horizontal:
                                                                              8),
                                                                      isCollapsed:
                                                                          true,
                                                                      filled:
                                                                          true,
                                                                      fillColor:
                                                                          AppStyle
                                                                              .backgroundColorGreen,
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                      height:
                                                                          15),
                                                                  MaterialButton(
                                                                    onPressed:
                                                                        () {
                                                                      if (_key
                                                                          .currentState!
                                                                          .validate()) {
                                                                        if (contentCommentController
                                                                            .text
                                                                            .isEmpty) {
                                                                          showSnackBar(
                                                                            context,
                                                                            "Vous ne pouvez pas mettre un commentaire vide !",
                                                                            Colors.red,
                                                                          );
                                                                          Navigator.pop(
                                                                              context);
                                                                        } else {
                                                                          DateTime
                                                                              createdAt =
                                                                              DateTime.now();
                                                                          String
                                                                              formattedDate =
                                                                              createdAt.toIso8601String();

                                                                          CommentController
                                                                              .onCreateComment(
                                                                            post['user']['id'],
                                                                            post['id'],
                                                                            contentCommentController.value.text,
                                                                            pictureCommentController.value.text,
                                                                            formattedDate,
                                                                          ).then(
                                                                              (success) {
                                                                            if (success) {
                                                                              showSnackBar(
                                                                                context,
                                                                                'Commentaire créé avec succès !',
                                                                                Colors.green,
                                                                              );
                                                                              Navigator.pop(context);
                                                                              contentCommentController.text = '';
                                                                            } else {
                                                                              showSnackBar(
                                                                                context,
                                                                                'Erreur lors de la création du commentaire',
                                                                                Colors.red,
                                                                              );
                                                                            }
                                                                          }).catchError(
                                                                              (error) {
                                                                            showSnackBar(
                                                                              context,
                                                                              'Erreur lors de la création du commentaire : $error',
                                                                              Colors.red,
                                                                            );
                                                                          });
                                                                        }
                                                                      }
                                                                    },
                                                                    height: 40,
                                                                    color: AppStyle
                                                                        .colorGreen,
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            20),
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              12.0),
                                                                    ),
                                                                    child:
                                                                        const Text(
                                                                      "Commenter",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            16.0,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                  ),
                                            const SizedBox(width: 8),
                                            Text(post['keeper'] != null
                                                ? "Gardée par : User ${post['keeper']['id']}"
                                                : "Gardée par : Personne"),
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
