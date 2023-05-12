import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mspr/controllers/user_controller.dart';
import 'package:mspr/models/comment.dart';
import 'package:mspr/share/app_style.dart';
import 'package:mspr/models/post.dart';
import 'package:mspr/utils/utils.dart';

import '../../models/user.dart';

class BotanistPostDetails extends StatefulWidget {
  const BotanistPostDetails({Key? key}) : super(key: key);

  @override
  _BotanistPostDetailsState createState() => _BotanistPostDetailsState();
}

class _BotanistPostDetailsState extends State<BotanistPostDetails> {
  int _selectedIndex = 0;
  DateTime createdAt = DateTime(2002, 5, 17, 10, 30, 0);
  List<User> users = [];
  // User user = UserController().getUser();
  Post post = Post(
      1,
      0,
      'test1',
      'J essaye de mettre une description plus grande que l actuelle pour tester le responsive et l overflow',
      'assets/img/image-removebg-preview.png',
      1,
      "10",
      "10",
      DateTime(2002, 5, 17, 10, 30, 0),
      DateTime(2002, 5, 17, 10, 30, 0));
  // Post post = PostController().getPost();
  List<Comment> comments = [];
  final GlobalKey<FormState> _key = GlobalKey();
  final TextEditingController contentCommentController =
  TextEditingController();
  late TextEditingController pictureCommentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Ici, vous pouvez récupérer votre liste de postes à partir d'une source de données (par exemple, une API) et la mettre à jour dans la variable "posts".
    // Remplacez le code suivant par votre logique de récupération des données.
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        comments = [
          Comment(1, 1, 1, 'Be careful! You gave her too much water !!', '', createdAt),
          Comment(2, 2, 2, 'Today when I woke up your rose was dead ?! What should I do ?', 'assets/img/image-removebg-preview.png', createdAt),
          Comment(3, 3, 3, 'Be careful! You gave her too much water !!', '', createdAt),
        ];
        users = [
          User(1, "Thierry", "Henry", "test@gmail.com", "test", "test", "34290", "test", "", true),
          User(2, "Thierry", "Henry", "test@gmail.com", "test", "test", "34290", "test", 'assets/img/image-removebg-preview.png', false),
          User(3, "Thierry", "Henry", "test@gmail.com", "test", "test", "34290", "test", "", true),
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
                            title: Text(post.title),
                            subtitle: Text(post.description),
                            trailing: Image.asset(
                              post.pictureUrl,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                            isThreeLine: true,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5, right: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                IconButton(
                                  icon: const Icon(Icons.comment),
                                  onPressed: () {
                                    showModalBottomSheet<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Container(
                                          height: 300,
                                          padding: const EdgeInsets.all(20),
                                          color: Colors.white,
                                          child: Center(
                                            child: Column(
                                              mainAxisSize:
                                              MainAxisSize.min,
                                              children: [
                                                TextFormField(
                                                  maxLines: 9,
                                                  style: const TextStyle(
                                                      fontSize: 13, color: AppStyle.colorGrey),
                                                  controller:
                                                  contentCommentController,
                                                  decoration:
                                                  InputDecoration(
                                                    hintText:
                                                    'Entrez votre commentaire...',

                                                    border:
                                                    InputBorder.none,
                                                    contentPadding: const EdgeInsets.symmetric(
                                                        vertical: 15, horizontal: 8),
                                                    isCollapsed: true,
                                                    filled: true,
                                                    fillColor: AppStyle
                                                        .backgroundColorGreen,
                                                    prefixIcon: IconButton(
                                                      icon: const Icon(
                                                          Icons.image),
                                                      mouseCursor:
                                                      SystemMouseCursors
                                                          .click,
                                                      onPressed: () {
                                                        _getImage();
                                                      },
                                                    ),
                                                    suffixIcon:
                                                    pictureCommentController.text.isNotEmpty
                                                        ? SizedBox(
                                                      width: 24,
                                                      height: 24,
                                                      child: Image
                                                          .network(
                                                        pictureCommentController.text,
                                                        fit: BoxFit
                                                            .cover,
                                                      ),
                                                    )
                                                        : null,
                                                  ),
                                                ),
                                                const SizedBox(height: 15),
                                                MaterialButton(
                                                  onPressed: () {
                                                    if (_key.currentState!
                                                        .validate()) {
                                                      if (contentCommentController
                                                          .text.isEmpty) {
                                                        showSnackBar(
                                                            context,
                                                            "Vous ne pouvez pas mettre un commentaire vide !",
                                                            Colors.red);
                                                        Navigator.pop(
                                                            context);
                                                      } else {
                                                        showSnackBar(
                                                            context,
                                                            'Publication du commentaire...',
                                                            Colors.grey);
                                                        // Ajouter ici l'enregistrement du commentaire

                                                        Navigator.pop(
                                                            context);
                                                        contentCommentController
                                                            .text = "";
                                                      }
                                                    }
                                                  },
                                                  height: 40,
                                                  color:
                                                  AppStyle.colorGreen,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 20),
                                                  shape:
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(12.0),
                                                  ),
                                                  child: const Text(
                                                    "Commenter",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16.0),
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
                                Text(post.idKeeper != 0
                                    ? "User ${post.idKeeper}"
                                    : "Personne"),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        final comment = comments[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Theme.of(context).colorScheme.outline,
                              ),
                              borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                            ),
                            child: ListTile(
                              title: Builder(
                                builder: (BuildContext context) {
                                  User? commenterUser = getUserById(comment.idUser);
                                  String commenterName = commenterUser != null ? commenterUser.firstname : "Unknown User";
                                  return commenterUser != null && commenterUser.isBotanist ? const Text("Botaniste") : Text("${commenterUser?.lastname} " "$commenterName");
                                },
                              ),
                              subtitle: Text(comment.content),
                              trailing: comment.pictureUrl.isNotEmpty ? Image.asset(
                                comment.pictureUrl,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ) : null,
                              isThreeLine: true,
                            ),
                          ),
                        );
                      },
                    )
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

  _getImage() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      final File imageFile = File(pickedFile.path);

      setState(() {
        pictureCommentController.text = imageFile.path;
      });
    }
  }

  User? getUserById(int id) {
    try {
      return users.firstWhere((user) => user.id == id);
    } catch (e) {
      return null;
    }
  }
}
