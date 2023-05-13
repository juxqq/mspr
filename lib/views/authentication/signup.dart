import 'package:flutter/material.dart';
import 'package:mspr/extensions/validator_extensions.dart';
import 'package:mspr/widgets/text_form.dart';

import '../../controllers/user_controller.dart';
import '../../share/app_style.dart';
import '../../utils/utils.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController roleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFD7F4D0),
        body: SingleChildScrollView(
            child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Column(
              children: [
                Image.asset(
                  'assets/img/image-removebg-preview.png',
                  width: 190,
                  height: 150,
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      "Email",
                      style: TextStyle(
                        color: AppStyle.colorGrey,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 3,
                ),
                SizedBox(
                  child: TextFormField(
                    validator: (value) => value!.validateEmail(),
                    controller: emailController,
                    cursorColor: Colors.black,
                    style: const TextStyle(
                        fontSize: 13.5, color: AppStyle.colorGrey),
                    decoration: InputDecoration(
                      hintText: "Example@gmail.com",
                      hintStyle: const TextStyle(
                          fontSize: 13.5, color: AppStyle.colorGrey
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 8),
                      isCollapsed: true,
                      border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 0.3),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 0.3),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 0.3),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      suffixIcon: const Icon(
                        Icons.mail,
                        color: Colors.black,
                        size: 15,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  child: (Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Nom",
                            style: TextStyle(
                              color: AppStyle.colorGrey,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          SizedBox(
                            width: 110,
                            child: (TextFormField(
                              validator: (value) => value!.validateLastName(),
                              controller: lastNameController,
                              cursorColor: Colors.black,
                              style: const TextStyle(
                                  fontSize: 13.5, color: AppStyle.colorGrey),
                              decoration: InputDecoration(
                                hintText: "Willson",
                                hintStyle: const TextStyle(
                                    fontSize: 13.5, color: AppStyle.colorGrey
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 8),
                                isCollapsed: true,
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 0.3),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 0.3),
                                  // Définir la couleur de la ligne autour de la bordure
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 0.3),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                suffixIcon: const Icon(
                                  Icons.person,
                                  color: Colors.black,
                                  size: 15,
                                ),
                              ),
                            )),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Prénom",
                            style: TextStyle(
                              color: AppStyle.colorGrey,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          SizedBox(
                            width: 110,
                            child: (TextFormField(
                              validator: (value) => value!.validateFirstName(),
                              controller: firstNameController,
                              cursorColor: Colors.black,
                              style: const TextStyle(
                                  fontSize: 13.5, color: AppStyle.colorGrey),
                              decoration: InputDecoration(
                                hintText: "Sabrina",
                                hintStyle: const TextStyle(
                                    fontSize: 13.5, color: AppStyle.colorGrey
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 8),
                                isCollapsed: true,
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 0.3),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 0.3),
                                  // Définir la couleur de la ligne autour de la bordure
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 0.3),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                suffixIcon: const Icon(
                                  Icons.person,
                                  color: Colors.black,
                                  size: 15,
                                ),
                              ),
                            )),
                          ),
                        ],
                      ),
                    ],
                  )),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  child: (Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Adresse",
                            style: TextStyle(
                              color: AppStyle.colorGrey,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          SizedBox(
                            width: 110,
                            child: (TextFormField(
                              validator: (value) => value!.validateAddress(),
                              controller: addressController,
                              cursorColor: Colors.black,
                              style: const TextStyle(
                                  fontSize: 13.5, color: AppStyle.colorGrey),
                              decoration: InputDecoration(
                                hintText: "Route de Ganges",
                                hintStyle: const TextStyle(
                                    fontSize: 13.5, color: AppStyle.colorGrey
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 8),
                                isCollapsed: true,
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 0.3),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 0.3),
                                  // Définir la couleur de la ligne autour de la bordure
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 0.3),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                suffixIcon: const Icon(
                                  Icons.location_on,
                                  color: Colors.black,
                                  size: 15,
                                ),
                              ),
                            )),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Code postal",
                            style: TextStyle(
                              color: AppStyle.colorGrey,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          SizedBox(
                            width: 110,
                            child: (TextFormField(
                              validator: (value) => value!.validateZipCode(),
                              controller: zipCodeController,
                              cursorColor: Colors.black,
                              style: const TextStyle(
                                  fontSize: 13.5, color: AppStyle.colorGrey),
                              decoration: InputDecoration(
                                hintText: "34000",
                                hintStyle: const TextStyle(
                                    fontSize: 13.5, color: AppStyle.colorGrey
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 8),
                                isCollapsed: true,
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 0.3),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 0.3),
                                  // Définir la couleur de la ligne autour de la bordure
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 0.3),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                suffixIcon: const Icon(
                                  Icons.location_on,
                                  color: Colors.black,
                                  size: 15,
                                ),
                              ),
                            )),
                          ),
                        ],
                      ),
                    ],
                  )),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  child: (Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Ville",
                            style: TextStyle(
                              color: AppStyle.colorGrey,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          SizedBox(
                            width: 110,
                            child: (TextFormField(
                              validator: (value) => value!.validateCity(),
                              controller: cityController,
                              cursorColor: Colors.black,
                              style: const TextStyle(
                                  fontSize: 13.5, color: AppStyle.colorGrey),
                              decoration: InputDecoration(
                                hintText: "Montpellier",
                                hintStyle: const TextStyle(
                                    fontSize: 13.5, color: AppStyle.colorGrey
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 8),
                                isCollapsed: true,
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 0.3),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 0.3),
                                  // Définir la couleur de la ligne autour de la bordure
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 0.3),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                suffixIcon: const Icon(
                                  Icons.location_city,
                                  color: Colors.black,
                                  size: 15,
                                ),
                              ),
                            )),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Mot de passe",
                            style: TextStyle(
                              color: AppStyle.colorGrey,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          SizedBox(
                            width: 110,
                            child: (TextFormField(
                              validator: (value) => value!.validatePassword(),
                              controller: passwordController,
                              cursorColor: Colors.black,
                              obscureText: true,
                              style: const TextStyle(
                                  fontSize: 13.5, color: AppStyle.colorGrey),
                              decoration: InputDecoration(
                                hintText: "*********",
                                hintStyle: const TextStyle(
                                    fontSize: 13.5, color: AppStyle.colorGrey
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 8),
                                isCollapsed: true,
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 0.3),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 0.3),
                                  // Définir la couleur de la ligne autour de la bordure
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 0.3),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                suffixIcon: const Icon(
                                  Icons.lock,
                                  color: Colors.black,
                                  size: 15,
                                ),
                              ),
                            )),
                          ),
                        ],
                      ),
                    ],
                  )),
                ),
                const SizedBox(
                  height: 60,
                ),
                SizedBox(
                  width: 220,
                  child: Column(
                    children: [
                      MaterialButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            UserController.onRegister(
                                emailController.text,
                                passwordController.text,
                                lastNameController.text,
                                firstNameController.text,
                                addressController.text,
                                cityController.text,
                                zipCodeController.text,
                                '',
                                false).then((value) {
                                  if (value == true) {
                                    Navigator.pushNamed(context, "/main");
                                    showSnackBar(context, 'Inscription en cours...', Colors.grey);
                                  } else {
                                    showSnackBar(context, 'Erreur lors de la création du compte', Colors.red);
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
                          "S'inscrire !",
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )));
  }
}
