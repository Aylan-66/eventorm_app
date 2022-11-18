// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
  });

  String firstname;
  String lastname;
  String email;
  String password;

  factory User.fromJson(Map<String, dynamic> json) => User(
    firstname: json["firstname"],
    lastname: json["lastname"],
    email: json["email"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "firstname": firstname,
    "lastname": lastname,
    "email": email,
    "password_digest": password,
  };
}
