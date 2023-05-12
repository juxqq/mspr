import 'package:flutter/material.dart';
import 'package:mspr/extensions/validator_extensions.dart';
import 'package:mspr/models/user.dart';
import 'package:mspr/services/user_service.dart';
import 'package:mspr/utils/utils.dart';

class UserController {
  static void register(email, lastName, firstName, birthDate, zipCode, city, password, context) async {
    await UserService.createUser(
        email, lastName, firstName, birthDate, zipCode, city, password.hashPass())
        .then((value) {
      if (value == true) {
        Navigator.pushNamed(context, '/main');
        showSnackBar(
            context,
            'Inscription réussie ! Veuillez confirmer votre adresse mail.',
            Colors.green);
      } else {
        showSnackBar(
            context,
            'Inscription impossible ! Un compte utilise déjà cettez adresse mail.',
            Colors.red);
      }
    });
  }

  static Future<bool> connect(login, String password) async {
    var json = await UserService.getUser("email", login);

    if (json['response'] == false) {
      return false;
    }

    User user = User.fromJson(json);
    var hash = password.hashPass();

    if (user.id == 0 || user.password != hash) {
      return false;
    }

    if (json['confirmed'] == '0') {
      return false;
    }

    UserService.setToken(json['token']);
    return true;
  }
}
