import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mspr/models/thread.dart';
import 'package:mspr/services/user_service.dart';

class ThreadService {
  static final apiUrl = dotenv.env['API_URL'];

  static Future<List<dynamic>> getThreads() async {
    final token = await getToken();
    final response = await http.get(Uri.parse('$apiUrl/api/threads'), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final threads = data['hydra:member'];

      return threads;
    } else {
      throw Exception('Failed to get threads');
    }
  }

  static Future<int> createThread(idPost, idCreator, createdAt, messages) async {
    final token = await getToken();

    Map<String, dynamic> requestPayload = {
      "idPost": "api/posts/$idPost",
      "idCreator": "api/users/$idCreator",
      "createdAt": createdAt,
      "messages": messages,
    };

    final response = await http.post(
      Uri.parse('$apiUrl/api/threads'),
      body: jsonEncode(requestPayload),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 201) {
      final responseBody = jsonDecode(response.body);
      final idThread = responseBody['id'];

      return idThread;
    } else {
      throw Exception('Error while trying to create a thread');
    }
  }

  static Future<Thread?> getThread(id) async {
    final token = await getToken();

    try {
      final response = await http.get(Uri.parse('$apiUrl/api/threads/$id'), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        Thread thread = Thread.fromJson(responseBody);

        return thread;
      }
    } catch (e) {
      throw Exception('Failed to get thread');
    }
    return null;
  }

  static getToken() {
    return UserService.getToken();
  }
}