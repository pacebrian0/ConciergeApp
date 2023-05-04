class User {
  int id;
  String name = "";
  String surname = "";
  String email = "";

  User({required this.id, required this.name, required this.surname, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      surname: json['surname']
    );
  }
}

