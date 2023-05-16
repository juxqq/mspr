import 'package:mspr/models/comment.dart';
import 'package:mspr/models/thread.dart';

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
  List<Comment>? comments;
  List<Thread>? threads;

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
        updatedAt = json['updatedAt'],
        comments = json['comments'],
        threads = json['threads'];
}
