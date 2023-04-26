import 'package:flutter/material.dart';
import 'package:mspr/services/user_service.dart';
import 'package:mspr/views/authentication//login.dart';
import 'package:mspr/views/authentication/signup.dart';

void main() {
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
