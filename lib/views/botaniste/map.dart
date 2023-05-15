import 'package:flutter/material.dart';
import 'package:mspr/share/app_style.dart';

class BotanistMap extends StatefulWidget {
  const BotanistMap({Key? key}) : super(key: key);

  @override
  _BotanistMapState createState() => _BotanistMapState();
}

class _BotanistMapState extends State<BotanistMap> {
  int _selectedIndex = 3;
  String? plantFilter;

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
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.location_on_outlined,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                                'Ma carte',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: 150,
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
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        height: 300,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Image.asset(
                          'assets/img/map.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 20),
                      MaterialButton(
                        onPressed: () {
                          // Gérer l'action d'envoi du message ici
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
                          BorderRadius
                              .circular(
                              12.0),
                        ),
                        child: const Text(
                          "Envoyer un message",
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
