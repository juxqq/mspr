class Role {
  final int id;
  final String role;
  final bool rights;

  Role(this.id, this.role, this.rights);

  Role.fromJson(Map<String, dynamic> json):
        id = json['id'],
        role = json['role'],
        rights = json['rights'];
}