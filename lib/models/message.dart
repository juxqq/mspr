class Message {
  final int id;
  final int idThread;
  final int idSender;
  final String content;
  final DateTime createdAt;

  Message(this.id, this.idThread, this.idSender, this.content, this.createdAt);

  Message.fromJson(Map<String, dynamic> json):
      id = json['id'],
      idThread = json['idThread'],
      idSender = json['idSender'],
      content = json['content'],
      createdAt = json['createdAt'];
}