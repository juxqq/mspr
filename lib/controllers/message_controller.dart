import 'package:mspr/models/message.dart';
import 'package:mspr/services/message_service.dart';

class MessageController {
  static Future<List<dynamic>> onGetMessages() async {
    return MessageService.getMessages();
  }

  static Future<bool> onCreateMessage(idThread, idSender, content, createdAt) async {
    return MessageService.createMessage(idThread, idSender, content, createdAt);
  }

  static Future<Message?> onGetMessage(id) async {
    return MessageService.getMessage(id);
  }
}