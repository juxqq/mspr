import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mspr/services/user_service.dart';
import 'package:mspr/models/message.dart';

class MessageService {
  static final apiUrl = dotenv.env['API_URL'];

  static Future<List<dynamic>> getMessages() async {
    final token = await getToken();

    final response = await http.get(Uri.parse('$apiUrl/api/messages'), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final messages = data['hydra:member'];

      return messages;
    } else {
      throw Exception('Failed to get messages');
    }
  }

  static Future<Message?> createMessage(idThread, idSender, content, createdAt) async {
    final token = await getToken();

    Map<String, dynamic> requestPayload = {
      "idThread": "api/threads/$idThread",
      "idSender": "api/users/$idSender",
      "content": content,
      "createdAt": createdAt,
    };

    final response = await http.post(
      Uri.parse('$apiUrl/api/messages'),
      body: jsonEncode(requestPayload),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      Message message = Message.fromJson(responseBody);

      return message;
    } else {
      print(response.body);
      throw Exception('Error while trying to create a message');
    }
  }

  static Future<Message?> getMessage(id) async {
    final token = await getToken();

    try {
      final response = await http.get(Uri.parse('$apiUrl/api/messages/$id'), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        Message message = Message.fromJson(responseBody);

        return message;
      }
    } catch (e) {
      throw Exception('Failed to get message');
    }
    return null;
  }

  static getToken() {
    return UserService.getToken();
  }
}