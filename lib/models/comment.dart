class Comment {
  final int id;
  final int idUser;
  final int idPost;
  final String content;
  final String pictureUrl;
  final DateTime createdAt;

  Comment(this.id, this.idUser, this.idPost, this.content, this.pictureUrl, this.createdAt);

  Comment.fromJson(Map<String, dynamic> json):
      id = json['id'],
      idUser = json['idUser'],
      idPost = json['idPost'],
      content = json['content'],
      pictureUrl = json['pictureUrl'],
      createdAt = json['createdAt'];
}