class Post {
  final int id;
  final int userId;
  final String role;
  final String content;
  final String comments;
  final int likes;
  final DateTime datePost;
  final int plantId;

  Post(this.id, this.userId, this.role, this.content, this.comments, this.likes, this.datePost, this.plantId);

  Post.fromJson(Map<String, dynamic> json):
        id = json['id'],
        userId = json['userId'],
        role = json['role'],
        content = json['content'],
        comments = json['comments'],
        likes = json['likes'],
        datePost = json['datePost'],
        plantId = json['plantId'];
}