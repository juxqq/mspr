import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mspr/services/user_service.dart';
import 'package:mspr/models/plant.dart';

class PlantService {
  static final apiUrl = dotenv.env['API_URL'];

  static Future<List<dynamic>> getPlants() async {
    final token = getToken();

    final response = await http.get(Uri.parse('$apiUrl/api/plants'), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final plants = data['hydra:member'];

      return plants;
    } else {
      throw Exception('Failed to get plants');
    }
  }

  static Future<Plant?> getPlant(name) async {
    final token = getToken();
    final id = getPlantIdByName(name);

    try {
      final response = await http.get(Uri.parse('$apiUrl/api/plants/$id'), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        Plant plant = Plant.fromJson(responseBody);

        return plant;
      }
    } catch (e) {
      throw Exception('Failed to get plant');
    }
    return null;
  }

  static Future<int?> getPlantIdByName(name) async {
    try {
      List<dynamic> plants = await getPlants();
      var plant = plants.firstWhere((plant) => plant['name'] == name, orElse: () => null);
      return plant != null ? plant['id'] : null;
    } catch (e) {
      throw Exception('Error while trying to get plant ID by name: $e');
    }
  }

  static getToken() {
    return UserService.getToken();
  }
}