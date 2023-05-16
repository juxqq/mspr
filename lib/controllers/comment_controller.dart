import 'package:mspr/services/comment_service.dart';

class CommentController {
  static Future<List<dynamic>> onGetComments() async {
    return CommentService.getComments();
  }

  static Future<bool> onCreateComment(idUser, idPost, content, pictureUrl, createdAt) async {
    return CommentService.createComment(idUser, idPost, content, pictureUrl, createdAt);
  }
}