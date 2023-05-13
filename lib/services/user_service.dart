import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_session/flutter_session.dart';
import 'package:mspr/models/user.dart';

class UserService {
  static const String uri =
      'https://www.dorian-roulet.com/stage_2022_01x02_epsi';
  static final session = FlutterSession();

  static Future<dynamic> getUser(param, value) async {
    var json = <String, dynamic>{'response': false};

    try {
      final response =
      await http.get(Uri.parse('$uri/login.php?$param=$value'));

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

  static Future<dynamic>updateUser(
      firstName, lastName, email, address, city, zipCode) async {
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
      final response =
      await http.put(Uri.parse('$uri/put.php'), body: {
        "firstName": "$firstName",
        "lastName": "$lastName",
        "email": "$email",
        "address": "$address",
        "city": "$city",
        "zipCode": "$zipCode",
      });

      if (response.statusCode != 200) {
        return false;
      }
    } catch (identifier) {
      return false;
    }

    return true;
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
      final response = await http.post(Uri.parse('$uri/post.php'), body: {
        "email": "$email",
        "lastName": "$lastName",
        "firstName": "$firstName",
        "birthDate": "$birthDate",
        "zipCode": "$zipCode",
        "city": "$city",
        "password": "$password"
      });

      await http.post(Uri.parse(
          '$uri/checkMail.php?email=$email')); // requete d'envoie mail confirmation

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
      final response = await http.get(Uri.parse('$uri/mail.php?mail=$login'));

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

  static setToken(String token, String refreshToken, User? user) async {
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
  }
}
