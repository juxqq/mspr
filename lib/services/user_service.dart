import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_session/flutter_session.dart';
import 'package:mspr/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  static final apiUrl = dotenv.env['API_URL'];
  static final session = FlutterSession();


  static Future<dynamic> getUser(param, value) async {
    var json = <String, dynamic>{'response': false};

    try {
      final response =
          await http.get(Uri.parse('$apiUrl/login.php?$param=$value'));

      if (response.statusCode == 200) {
        json = jsonDecode(utf8.decode(response.bodyBytes))[0];

        if (json.length > 1) {
          json['id'] = int.parse(json['id']);
          json['response'] = true;
          return json;
        }
      }
    } catch (identifier) {
      return json;
    }
  }

  static Future<bool> updateUser(
      firstName, lastName, email, address, city, zipCode, password) async {

    try {

      final token = getToken();

      final response = await http.put(Uri.parse('$apiUrl/put.php'), body: {
        'email': email,
        'password': password,
        'lastName': lastName,
        'firstName': firstName,
        'address': address,
        'city': city,
        'zipCode': zipCode,
        'isBotanist': false,
      }, headers: {'Content-Type'  : 'application/json', 'Authorization' : 'Bearer $token'});

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      return false;
    }

    return true;
  }

  static Future<bool> login(email, password) async {
    Map<String, dynamic> requestPayload = {
      "username": email,
      "password": password
    };

    try {
      final response = await http.post(Uri.parse('$apiUrl/login'),
          body: jsonEncode(requestPayload), headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        final token = responseBody['token'];
        setToken(token);

        return true;
      }
    } catch (e) {
      throw Exception('Error while trying to login: $e');
    }

    return false;
  }

  Future<List<dynamic>> getUsers() async {
    final response = await http.get(Uri.parse('$apiUrl/api/users'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final users = data['hydra:member'];

      return users;
    } else {
      throw Exception('Failed to load users');
    }
  }


  static Future<dynamic> createUser(
      email, lastName, firstName, birthDate, zipCode, city, password) async {
    try {
      await getUser("email", email).then((value) {
        if (value['response'] == true) {
          return false;
        }
      });
    } catch (e) {
      return false;
    }

    try {
      final response = await http.post(Uri.parse('$apiUrl/post.php'), body: {
        "email": "$email",
        "lastName": "$lastName",
        "firstName": "$firstName",
        "birthDate": "$birthDate",
        "zipCode": "$zipCode",
        "city": "$city",
        "password": "$password"
      });

      await http.post(Uri.parse(
          '$apiUrl/checkMail.php?email=$email')); // requete d'envoie mail confirmation

      if (response.statusCode != 200) {
        return false;
      }
    } catch (e) {
      return false;
    }

    return true;
  }

  static Future<dynamic> resetPassword(login) async {
    var json = <String, dynamic>{'response': false};
    var data = await getUser("email", login);

    if (data['response'] == false) {
      return json;
    }

    User user = User.fromJson(data[0]);

    try {
      final response =
          await http.get(Uri.parse('$apiUrl/mail.php?mail=$login'));

      if (response.statusCode == 200) {
        var json = jsonDecode(utf8.decode(response.bodyBytes));

        if (json['code'].toString().length == 4) {
          return {
            'id': user.id,
            'lastName': user.lastname,
            'firstName': user.firstname,
            'email': user.email,
            'password': user.password,
            'code': json['code'],
            'response': true
          };
        }
      }
    } catch (exception) {
      return json;
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

  /*static setToken(String token, String refreshToken, User? user) async {
    _AuthData data = _AuthData(token, refreshToken);
    await session.set('tokens', data);
    await session.set('user', user);
  }

  static Future<Map<String, dynamic>> getToken() async =>
      await session.get('tokens');

  static Future<dynamic> getUserId() async => await session.get('user');

  static removeToken() async => await session.prefs.clear();
}

class _AuthData {
  String token, refreshToken;

  _AuthData(this.token, this.refreshToken);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['token'] = token;
    data['refreshToken'] = refreshToken;
    return data;
  }*/
}
