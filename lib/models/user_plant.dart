class UserPlant {
  final int id;
  final int idPlant;
  final int idUser;

  UserPlant(this.id, this.idPlant, this.idUser);

  UserPlant.fromJson(Map<String, dynamic> json):
        id = json['id'],
        idPlant = json['idPlant'],
        idUser = json['idUser'];
}