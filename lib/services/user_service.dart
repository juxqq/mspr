import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mspr/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  static final apiUrl = dotenv.env['API_URL'];

  static Future<User?> login(email, password) async {
    Map<String, dynamic> requestPayload = {
      "email": email,
      "password": password
    };

    try {
      final response = await http.post(Uri.parse('$apiUrl/login'),
          body: jsonEncode(requestPayload),
          headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        final User user = User.fromJson(responseBody['user']);
        setToken(responseBody['token']);

        return user;
      }
    } catch (e) {
      throw Exception('Error while trying to login: $e');
    }
    return null;
  }

  static Future<bool> register(email, password, lastName, firstName, address,
      city, zipCode, profilePicture, isBotanist) async {
    Map<String, dynamic> requestPayload = {
      "email": email,
      "password": password,
      "lastName": lastName,
      "firstName": firstName,
      "address": address,
      "city": city,
      "zipCode": zipCode,
      "profilePicture": profilePicture,
      "isBotanist": isBotanist
    };
    try {
      final response = await http.post(Uri.parse('$apiUrl/register'),
          body: jsonEncode(requestPayload),
          headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      throw Exception('Error while trying to register: $e');
    }
    return false;
  }

  static Future<List<dynamic>> getUsers() async {
    final token = getToken();
    final response = await http.get(Uri.parse('$apiUrl/api/users'), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final users = data['hydra:member'];

      return users;
    } else {
      throw Exception('Failed to load users');
    }
  }

  static Future<User?> getUser(email) async {
    final token = getToken();
    final id = getUserIdByEmail(email);

    try {
      final response = await http.get(Uri.parse('$apiUrl/api/users/$id'), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        User user = User.fromJson(responseBody);
        print(user);

        return user;
      }
    } catch (e) {
      throw Exception('Failed to get user');
    }
    return null;
  }

  static Future<dynamic> updateUser(email, password, lastName, firstName, address, city, zipCode, profilePicture, isBotanist) async {
    final id = getUserIdByEmail(email);
    final token = getToken();
    Map<String, dynamic> requestPayload = {
      "email": email,
      "roles": [],
      "password": password,
      "lastName": lastName,
      "firstName": firstName,
      "address": address,
      "city": city,
      "zipCode": zipCode,
      "profilePicture": profilePicture,
      "isBotanist": isBotanist,
      "userPlants": [],
      "threads": []
    };

    try {
      final response =
      await http.put(Uri.parse('$apiUrl/api/users/$id'), body: requestPayload, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      throw Exception('Error while trying to update user: $e');
    }
    return false;
  }

  static Future<int?> getUserIdByEmail(String email) async {
    try {
      List<dynamic> users = await getUsers();
      var user = users.firstWhere((user) => user['email'] == email, orElse: () => null);
      return user != null ? user['id'] : null;
    } catch (e) {
      throw Exception('Error while trying to get user ID by email: $e');
    }
  }

  static Future<void> setToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  static Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<void> removeToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }
}