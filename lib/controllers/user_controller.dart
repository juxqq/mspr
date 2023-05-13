import 'package:mspr/models/user.dart';
import 'package:mspr/services/user_service.dart';

class UserController {
  static Future<bool> onRegister(email, password, lastName, firstName, address, city, zipCode, profilePicture, isBotanist) async {
    return await UserService.register(email, password, lastName, firstName, address, city, zipCode, profilePicture, isBotanist);
  }

  static Future<User?> onLogin(email, password) async {
    return await UserService.login(email, password);
  }

  static Future<List<dynamic>> onGetUsers() async {
    return await UserService.getUsers();
  }

  static Future<User?> onGetUser(email) async {
    return await UserService.getUser(email);
  }

  static Future<bool> onUpdateUser(email, password, lastName, firstName, address, city, zipCode, profilePicture, isBotanist) async {
    return await UserService.updateUser(email, password, lastName, firstName, address, city, zipCode, profilePicture, isBotanist);
  }
}
