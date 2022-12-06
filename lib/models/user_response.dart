// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Users userFromJson(String str) => Users.fromJson(json.decode(str));

String userToJson(Users data) => json.encode(data.toJson());

Status statusFromJson(String str) => Status.fromJson(json.decode(str));

String statusToJson(Status data) => json.encode(data.toJson());

class Status {
  Status({
    required this.status,
  });

  String status;

  factory Status.fromJson(Map<String?, dynamic?> json) => Status(
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
  };
}

class Users {
  Users({
    required this.status,
    this.data,
  });

  String status;
  Datac? data;

  factory Users.fromJson(Map<String?, dynamic?> json) => Users(
    status: json["status"],
    data: Datac.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data?.toJson(),
  };
}

class Datac {
  Datac({
    this.data,
  });

  Data? data;

  factory Datac.fromJson(Map<String, dynamic> json) => Datac(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson()
  };
}

class Data {
  Data({
    this.user,
  });

  User? user;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "user": user?.toJson()
  };
}

class User {
  User({
    this.firstname,
    this.lastname,
    this.email,
    this.password,
  });

  String? firstname;
  String? lastname;
  String? email;
  String? password;

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
    "password": password,
  };
}
