class Thread {
  final int id;
  final int idPost;
  final int idCreator;
  final DateTime createdAt;

  Thread(this.id, this.idPost, this.idCreator, this.createdAt);

  Thread.fromJson(Map<String, dynamic> json):
      id = json['id'],
      idPost = json['idPost'],
      idCreator = json['idCreator'],
      createdAt = json['createdAt'];
}