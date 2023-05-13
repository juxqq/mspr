import 'package:google_maps_flutter/google_maps_flutter.dart';

class Post {
  final int id;
  final int idKeeper;
  final String title;
  final String description;
  final String pictureUrl;
  final int idUserPlant;
  final String latitude;
  final String longitude;
  final DateTime createdAt;
  final DateTime updatedAt;

  Post(
      this.id,
      this.idKeeper,
      this.title,
      this.description,
      this.pictureUrl,
      this.idUserPlant,
      this.latitude,
      this.longitude,
      this.createdAt,
      this.updatedAt);

  Post.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        idKeeper = json['idKeeper'],
        title = json['title'],
        description = json['description'],
        pictureUrl = json['pictureUrl'],
        idUserPlant = json['idUserPlant'],
        latitude = json['latitude'],
        longitude = json['longitude'],
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'];
}
