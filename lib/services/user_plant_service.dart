import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mspr/models/user_plant.dart';
import 'package:mspr/services/user_service.dart';

class UserPlantService {
  static final apiUrl = dotenv.env['API_URL'];

  static Future<List<dynamic>> getUserPlants() async {
    final token = getToken();

    final response = await http.get(
        Uri.parse('$apiUrl/api/user_plants'), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final userPlants = data['hydra:member'];

      return userPlants;
    } else {
      throw Exception('Failed to get user plants');
    }
  }

  static Future<UserPlant?> getUserPlant(id) async {
    final token = getToken();

    try {
      final response = await http.get(Uri.parse('$apiUrl/api/user_plants/$id'), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        UserPlant userPlant = UserPlant.fromJson(responseBody);

        return userPlant;
      }
    } catch (e) {
      throw Exception('Failed to get user plant');
    }
    return null;
  }

  static getToken() {
    return UserService.getToken();
  }
}