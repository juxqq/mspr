class User {
  final int id;
  final String lastname;
  final String firstname;
  final String adress;
  final String city;
  final String zipCode;
  final String plant;
  final String role;
  final String email;
  final String password;
  final DateTime birthDate;
  final DateTime dateRegistration;
  final String profilePicture;

  /*get pdp{
    return NetworkImage('$uriApi/images/$pdpName');
  }*/

  User(
      this.id,
      this.lastname,
      this.firstname,
      this.adress,
      this.city,
      this.zipCode,
      this.plant,
      this.role,
      this.email,
      this.password,
      this.birthDate,
      this.dateRegistration,
      this.profilePicture);

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        lastname = json['lastname'],
        firstname = json['firstname'],
        adress = json['adress'],
        city = json['city'],
        zipCode = json['zipCode'],
        plant = json['plant'],
        role = json['role'],
        email = json['email'],
        password = json['password'],
        birthDate = json['birthDate'],
        dateRegistration = json['dateRegistration'],
        profilePicture = json['profilePicture'];

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