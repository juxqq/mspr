class User {
  final int id;
  final String lastName;
  final String firstName;
  final String email;
  final String address;
  final String city;
  final int zipCode;
  String? password;
  final String profilePicture;
  final bool isBotanist;
  List? roles;
  List? plants;
  List? plantsKept;

  /*get pdp{
    return NetworkImage('$uriApi/images/$pdpName');
  }*/

  User(
      this.id,
      this.lastName,
      this.firstName,
      this.email,
      this.address,
      this.city,
      this.zipCode,
      this.password,
      this.profilePicture,
      this.isBotanist);

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        email = json['email'],
        roles = json['roles'],
        lastName = json['lastName'],
        firstName = json['firstName'],
        address = json['address'],
        city = json['city'],
        zipCode = json['zipCode'],
        profilePicture = json['profilePicture'],
        isBotanist = json['isBotanist'],
        plants = json['plants'],
        plantsKept = json['plantsKept'];

/*  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'firstName': firstName,
        'phoneNumber': phone,
        'mail': mail,
        'password': password,
        'type': type
      };*/
}