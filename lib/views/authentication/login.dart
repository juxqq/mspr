import 'package:flutter/material.dart';
import 'package:mspr/controllers/user_controller.dart';
import 'package:mspr/extensions/validator_extensions.dart';
import 'package:mspr/utils/utils.dart';
import 'package:mspr/share/app_style.dart';
import 'package:mspr/services/user_service.dart';
import 'package:mspr/models/user.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController mailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFD7F4D0),
        body: SingleChildScrollView(
            child: Form(
          key: _key,
          child: Padding(
            padding: const EdgeInsets.only(left: 40, right: 40),
            child: Column(
              children: [
                Image.asset(
                  'assets/img/image-removebg-preview.png',
                  width: 220,
                  height: 150,
                ),
                const SizedBox(
                  height: 80,
                ),
                const Text(
                  "Identifiant :",
                  style: TextStyle(
                    color: AppStyle.colorGrey,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 13,
                ),
                SizedBox(
                  width: 220,
                  child: TextFormField(
                    validator: (value) => value!.validateEmail(),
                    controller: mailController,
                    cursorColor: Colors.black,
                    style: const TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 10),
                      isCollapsed: true,
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        // Définir la couleur de la ligne autour de la bordure
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 13,
                ),
                const Text(
                  "Mot de passe :",
                  style: TextStyle(
                    color: AppStyle.colorGrey,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 13,
                ),
                SizedBox(
                  width: 220,
                  child: TextFormField(
                    controller: passwordController,
                    cursorColor: Colors.black,
                    obscureText: true,
                    validator: (value) => value!.validatePassword(),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 7, horizontal: 10),
                      isCollapsed: true,
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        // Définir la couleur de la ligne autour de la bordure
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 220,
                  child: (
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed("/reset");
                            },
                            child: const Text(
                              'Mot de passe oublié ?',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      )
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                MaterialButton(
                  onPressed: () {
                    if (_key.currentState!.validate()) {
                      UserController.onLogin(mailController.value.text,
                              passwordController.value.text)
                          .then((user) {
                        if (user != null) {
                          if (user.isBotanist) {
                            Navigator.pushNamed(context, "/botanist_home");
                          } else {
                            Navigator.pushNamed(context, "/test");
                          }
                        } else {
                          showSnackBar(
                              context,
                              'Identifiants incorrects',
                              Colors.red);
                        }
                      });
                    }
                  },
                  height: 45,
                  color: AppStyle.colorGreen,
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: const Text(
                    "Se connecter",
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Vous n'avez pas de compte ?",
                      style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed("/signup");
                  },
                  child: const Text(
                    "S'enregistrer",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ),
        )));
  }
}
