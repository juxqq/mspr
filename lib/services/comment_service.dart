import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mspr/services/user_service.dart';

class CommentService {
  static final apiUrl = dotenv.env['API_URL'];

  static Future<List<dynamic>> getComments() async {
    final token = getToken();

    final response = await http.get(Uri.parse('$apiUrl/api/comments'), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final comments = data['hydra:member'];

      return comments;
    } else {
      throw Exception('Failed to get comments');
    }
  }

  static Future<bool> createComment(idUser, idPost, content, pictureUrl, createdAt) async {
    final token = await getToken();

    Map<String, dynamic> requestPayload = {
      "idUser": idUser,
      "idPost": idPost,
      "content": content,
      "pictureUrl": pictureUrl,
      "createdAt": createdAt,
    };

    final response = await http.post(
      Uri.parse('$apiUrl/api/comments'),
      body: jsonEncode(requestPayload),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Error while trying to create a comment');
    }
  }

  static getToken() {
    return UserService.getToken();
  }
}