import 'package:mspr/models/user_plant.dart';
import 'package:mspr/services/user_plant_service.dart';

class UserPlantController {
  static Future<List<dynamic>> onGetUserPlants() async {
    return UserPlantService.getUserPlants();
  }

  static Future<UserPlant?> onGetUserPlant(id) async {
    return UserPlantService.getUserPlant(id);
  }
}