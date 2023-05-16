import 'package:mspr/services/plant_service.dart';
import 'package:mspr/models/plant.dart';

class PlantController {
  static Future<List<dynamic>> onGetPlants() async {
    return PlantService.getPlants();
  }

  static Future<Plant?> onGetPlant(name) async {
    return PlantService.getPlant(name);
  }
}