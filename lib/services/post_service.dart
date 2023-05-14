import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mspr/services/user_service.dart';
import 'package:mspr/models/post.dart';

class PostService {
  static final apiUrl = dotenv.env['API_URL'];

  static Future<List<dynamic>> getPosts() async {
    final token = await getToken();
    final response = await http.get(Uri.parse('$apiUrl/api/posts'), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final posts = data['hydra:member'];

      return posts;
    } else {
      throw Exception('Failed to get posts');
    }
  }

  static Future<bool> createPost(idKeeper, title, description, pictureUrl, idUserPlant, latitude, longitude, createdAt, updatedAt, comments, threads) async {
    final token = await getToken();

    Map<String, dynamic> requestPayload = {
      "idKeeper": idKeeper,
      "title": title,
      "description": description,
      "pictureUrl": pictureUrl,
      "idUserPlant": idUserPlant,
      "latitude": latitude,
      "longitude": longitude,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
      "comments": comments,
      "threads": threads
    };

    final response = await http.post(
      Uri.parse('$apiUrl/api/posts'),
      body: jsonEncode(requestPayload),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Error while trying to create a post');
    }
  }

  static Future<Post?> getPost(id) async {
    final token = await getToken();

    try {
      final response = await http.get(
        Uri.parse('$apiUrl/api/posts/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode == 200){
        final responseBody = jsonDecode(response.body);
        Post post = Post.fromJson(responseBody);

        return post;
      }
    } catch (e) {
      throw Exception("Failed to get post: $e");
    }
    return null;
  }

  static getToken() {
    return UserService.getToken();
  }
}