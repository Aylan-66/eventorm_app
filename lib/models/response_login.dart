// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Response responseFromJson(String str) => Response.fromJson(json.decode(str));

String responseToJson(Response data) => json.encode(data.toJson());

class Response {
    Response({
        required this.status,
        required this.data,
    });

    String status;
    Data data;

    factory Response.fromJson(Map<String, dynamic> json) => Response(
        status: json["status"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
    };
}

class Data {
    Data({
        required this.token,
        this.user,
    });

    String token;
    User? user;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "user": user?.toJson(),
    };
}

class User {
    User({
        this.id,
        this.firstname,
        this.lastname,
        this.email,
        this.birthday,
        this.address,
        this.zipcode,
        this.city,
        this.country,
        this.phone,
    });

    int? id;
    String? firstname;
    String? lastname;
    String? email;
    dynamic? birthday;
    dynamic? address;
    dynamic? zipcode;
    dynamic? city;
    dynamic? country;
    dynamic? phone;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        email: json["email"],
        birthday: json["birthday"],
        address: json["address"],
        zipcode: json["zipcode"],
        city: json["city"],
        country: json["country"],
        phone: json["phone"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "birthday": birthday,
        "address": address,
        "zipcode": zipcode,
        "city": city,
        "country": country,
        "phone": phone,
    };
}
