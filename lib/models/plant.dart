class Plant {
  final int id;
  final String name;

  Plant(this.id, this.name);

  Plant.fromJson(Map<String, dynamic> json):
        id = json['id'],
        name = json['name'];
}