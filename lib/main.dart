import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mspr/services/user_service.dart';
import 'package:mspr/views/authentication//login.dart';
import 'package:mspr/views/authentication/signup.dart';
import 'package:mspr/views/authentication/user_list_screen.dart';
import 'package:mspr/views/botaniste/home.dart';
import 'package:mspr/views/botaniste/map.dart';
import 'package:mspr/views/botaniste/messages.dart';
import 'package:mspr/views/botaniste/post_details.dart';
import 'package:mspr/views/botaniste/profile.dart';
import 'package:mspr/views/botaniste/thread.dart';
import 'package:mspr/views/botaniste/update_profile.dart';
import 'package:mspr/views/user/messages.dart';
import 'package:mspr/views/user/profile.dart';
import 'package:mspr/views/user/thread.dart';
import 'package:mspr/views/user/update_profile.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Messenger Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/main': (context) => const LoginPage(),
        '/signup': (context) => const SignUp(),
        '/test': (context) => const UserListScreen(),
        '/botanist_home': (context) => const BotanistHome(),
        '/botanist_post_details': (context) => const BotanistPostDetails(),
        '/botanist_profile': (context) => const BotanistProfile(),
        '/botanist_messages': (context) => const BotanistMessages(),
        '/botanist_thread': (context) => const BotanistThread(),
        '/botanist_map': (context) => const BotanistMap(),
        '/botanist_update_profile': (context) => const BotanistUpdateProfile(),
        '/user_profile': (context) => const ProfilePage(),
        '/user_update_profile': (context) => const UpdateProfile(),
        '/user_messages': (context) => const UserMessages(),
        '/user_thread': (context) => const UserThread(),
      },
      home: FutureBuilder(
        future: UserService.getToken(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasData) {
            return const LoginPage();
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}
