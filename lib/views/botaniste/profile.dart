import 'package:flutter/material.dart';
import 'package:mspr/share/app_style.dart';

class BotanistProfile extends StatefulWidget {
  const BotanistProfile({Key? key}) : super(key: key);

  @override
  _BotanistProfileState createState() => _BotanistProfileState();
}

class _BotanistProfileState extends State<BotanistProfile> {

  int _selectedIndex = 0;

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
                        Icon(Icons.account_circle_outlined, size: 42),
                        SizedBox(width: 16),
                        Text(
                          'Mon profil',
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
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFE1FDE1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Container(
                            width: 380,
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Informations personnelles',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {Navigator.of(context).pushNamed("/botanist_update_profile");
                                    // Handle edit button click
                                  },
                                  child: const Icon(Icons.edit_square, size: 32),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 16), // Added vertical spacing
                        FutureBuilder<String>(
                          future: fetchDataFromAPI('firstName'), // Fetch first name from API
                          builder: (context, snapshot) {
                            return _buildRow('Prenom :', snapshot);
                          },
                        ),
                        SizedBox(height: 8), // Added vertical spacing
                        FutureBuilder<String>(
                          future: fetchDataFromAPI('lastName'), // Fetch last name from API
                          builder: (context, snapshot) {
                            return _buildRow('Nom :', snapshot);
                          },
                        ),
                        SizedBox(height: 8), // Added vertical spacing
                        FutureBuilder<String>(
                          future: fetchDataFromAPI('address'), // Fetch address from API
                          builder: (context, snapshot) {
                            return _buildRow('Adresse :', snapshot);
                          },
                        ),
                        SizedBox(height: 8), // Added vertical spacing
                        FutureBuilder<String>(
                          future: fetchDataFromAPI('email'), // Fetch email from API
                          builder: (context, snapshot) {
                            return _buildRow('Email :', snapshot);
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 30), // add some spacing
                Container(
                  width: 400,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFE1FDE1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Container(
                            width: 380,
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Plantes gardées',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {Navigator.of(context).pushNamed("/botanist_home");
                                    // Handle edit button click
                                  },
                                  child: const Icon(Icons.add_circle_outline_rounded, size: 32),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        FutureBuilder<List<String>>(
                          future: fetchKeptPlantData(), // Replace with API fetch function
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: snapshot.data!
                                    .map((plantName) => _buildPlantBox(plantName))
                                    .toList(),
                              );
                            } else if (snapshot.hasError) {
                              return Text('Failed to fetch plant data.');
                            } else {
                              return CircularProgressIndicator();
                            }
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

  Widget _buildRow(String label, AsyncSnapshot<String> snapshot) {
    if (snapshot.hasData) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            snapshot.data!,
            style: TextStyle(fontSize: 16),
          ),
        ],
      );
    } else if (snapshot.hasError) {
      return Text('Failed to fetch $label.');
    } else {
      return CircularProgressIndicator();
    }
  }

  Future<String> fetchDataFromAPI(String field) async {
    // Replace this with actual API call to fetch data based on the field name
    await Future.delayed(Duration(seconds: 2)); // Simulating a delay

    // Replace the switch case with your API implementation for different fields
    switch (field) {
      case 'firstName':
        return 'John'; // Replace with fetched data
      case 'lastName':
        return 'Doe'; // Replace with fetched data
      case 'address':
        return '123 Main Street, 54321 Anytown'; // Replace with fetched data
      case 'email':
        return 'mymail@yopmail.com'; // Replace with fetched data
      default:
        return '';
    }
  }

  Widget _buildPlantBox(String plantName) {
    return Container(
      width: 100,
      height: 40,
      decoration: BoxDecoration(
        color: const Color(0xFFE1FDE1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          plantName,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      ),
    );
  }


  Future<List<String>> fetchPlantData() async {
    // Replace this with actual API call to fetch plant data
    await Future.delayed(Duration(seconds: 2)); // Simulating a delay
    return ['Plante A', 'Plante B', 'Plante D', 'Plante E', 'Plante Y'];
  }
  Future<List<String>> fetchKeptPlantData() async {
    // Replace this with actual API call to fetch kept plant data
    await Future.delayed(Duration(seconds: 2)); // Simulating a delay
    return ['Plante C de User 1', 'Plante C de User 2', 'Plante C de User 3'];
  }
}
