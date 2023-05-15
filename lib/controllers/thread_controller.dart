import 'package:mspr/models/thread.dart';
import 'package:mspr/services/thread_service.dart';

class ThreadController {
  static Future<List<dynamic>> onGetThreads() async {
    return ThreadService.getThreads();
  }

  static Future<int> onCreateThread(idPost, idCreator, createdAt, messages) async {
    return ThreadService.createThread(idPost, idCreator, createdAt, messages);
  }

  static Future<Thread?> onGetThread(id) async {
    return ThreadService.getThread(id);
  }
}