class Plant {
  final int id;
  final String name;
  final String state;
  final String localisation;

  Plant(this.id, this.name, this.state, this.localisation);

  Plant.fromJson(Map<String, dynamic> json):
        id = json['id'],
        name = json['name'],
        state = json['state'],
        localisation = json['localisation'];
}