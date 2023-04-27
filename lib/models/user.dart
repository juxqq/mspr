class User {
  final int id;
  final String lastname;
  final String firstname;
  final String email;
  final String address;
  final String city;
  final String zipCode;
  final String password;
  final String profilePicture;
  final bool isBotanist;

  /*get pdp{
    return NetworkImage('$uriApi/images/$pdpName');
  }*/

  User(
      this.id,
      this.lastname,
      this.firstname,
      this.email,
      this.address,
      this.city,
      this.zipCode,
      this.password,
      this.profilePicture,
      this.isBotanist);

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        lastname = json['lastname'],
        firstname = json['firstname'],
        email = json['email'],
        address = json['address'],
        city = json['city'],
        zipCode = json['zipCode'],
        password = json['password'],
        profilePicture = json['profilePicture'],
        isBotanist = json['isBotanist'];

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