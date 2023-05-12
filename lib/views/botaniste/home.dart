import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mspr/models/plant.dart';
import 'package:mspr/models/user_plant.dart';
import 'package:mspr/share/app_style.dart';
import 'package:mspr/models/post.dart';
import 'package:mspr/utils/utils.dart';
import 'package:image_picker/image_picker.dart';

class BotanistHome extends StatefulWidget {
  const BotanistHome({Key? key}) : super(key: key);

  @override
  _BotanistHomeState createState() => _BotanistHomeState();
}

class _BotanistHomeState extends State<BotanistHome> {
  int _selectedIndex = 2;
  String? plantFilter;
  String? postFilter;
  final GlobalKey<FormState> _key = GlobalKey();
  List<Post> posts = [];
  List<Post> filteredPosts = [];
  DateTime createdAt = DateTime(2002, 5, 17, 10, 30, 0);
  DateTime updatedAt = DateTime(2002, 5, 17, 10, 45, 0);
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
        posts = [
          Post(
              1,
              1,
              'test1',
              'J essaye de mettre une description plus grande que l actuelle pour tester le responsive et l overflow',
              'assets/img/image-removebg-preview.png',
              1,
              "10",
              "10",
              createdAt,
              updatedAt),
          Post(2, 2, 'test2', 'test2', 'assets/img/image-removebg-preview.png',
              2, "10", "10", createdAt, updatedAt),
          Post(3, 3, 'test3', 'test3', 'assets/img/image-removebg-preview.png',
              3, "10", "10", createdAt, updatedAt),
        ];
        filteredPosts = posts;
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
                                    filterPosts();
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
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredPosts.length,
                    itemBuilder: (context, index) {
                      final post = posts[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Card(
                          clipBehavior: Clip.hardEdge,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Theme.of(context).colorScheme.outline,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                          ),
                          child: InkWell(
                            splashColor: Colors.blue.withAlpha(30),
                            onTap: () {
                              Navigator.pushNamed(context, '/botanist_post_details');
                            },
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
                                  padding:
                                  const EdgeInsets.only(left: 5, right: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
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

  void filterPosts() {
    if (plantFilter == null || plantFilter == 'Tous les postes') {
      setState(() {
        filteredPosts = posts; // Afficher tous les posts si aucun filtre n'est sélectionné
      });
    } else {
      setState(() {
        filteredPosts = posts
            .where((post) {
          // Obtenir l'objet UserPlant correspondant au post
          final userPlant = getUserPlant(post.idUserPlant);

          // Obtenir l'objet Plant correspondant à l'objet UserPlant
          final plant = getPlant(userPlant.idPlant);

          // Filtrer les posts en fonction du nom de la plante
          return plant.name == plantFilter;
        })
            .toList();
      });
    }
  }

  // Faire la logique des postes gardés et non gardés : IdKeeper != 0 vice versa

  UserPlant getUserPlant(int userPlantId) {
    // Remplacez cette logique par votre méthode pour récupérer l'objet UserPlant correspondant à l'ID donné
    // Vous pouvez utiliser une boucle ou une méthode de recherche appropriée ici
    return UserPlant(1, 1, 1);
  }

  Plant getPlant(int plantId) {
    // Remplacez cette logique par votre méthode pour récupérer l'objet Plant correspondant à l'ID donné
    // Vous pouvez utiliser une boucle ou une méthode de recherche appropriée ici
    return Plant(1, 'Rose');
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
}
