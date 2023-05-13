import 'package:mspr/services/post_service.dart';
import 'package:mspr/models/post.dart';

class PostController {
  static Future<List<dynamic>> onGetPosts() async {
    return PostService.getPosts();
  }

  static Future<Post?> onGetPost(id) async {
    return PostService.getPost(id);
  }
}