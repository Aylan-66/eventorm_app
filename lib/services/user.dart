import 'package:eventorm_app/models/events.dart';
import 'package:http/http.dart' as http;
import 'package:eventorm_app/models/response_login.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:eventorm_app/models/user_response.dart';

class RemoteServiceU {
  Future<Events?> postUser(String body) async {

    var url = Uri.parse(
      'http://10.0.2.2:3000/v1/user/auth/register',
    );
    print("body is" + body);
    var responsezer = await http.post(
      url,
      body: body,
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
        "Access-Control-Allow-Origin": "*"
      },
    );
    print(responsezer.body);
    print(responsezer.statusCode);
    if (responsezer.statusCode == 200) {
      //Or put here your next screen using Navigator.push() method
      print('success');
    } else {
      print('error');
    }
  }

  Future<Events?> loginUser(String body) async {

    var url = Uri.parse(
      'http://10.0.2.2:3000/v1/user/auth/login',
    );
    print("body is" + body);
    var responsezer = await http.post(
      url,
      body: body,
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
        "Access-Control-Allow-Origin": "*"
      },
    );

    print(responsezer.statusCode);
    if (responsezer.statusCode == 200) {
      //Or put here your next screen using Navigator.push() method
      print('success');
      var token = responseFromJson(responsezer.body);
      print(token.data.token);

      final storage = new FlutterSecureStorage();
      await storage.write(key: 'jwt', value: token.data.token);
      print(storage.read(key: "jwt"));
    } else {
      print('error');
    }
  }

  isLogged() async {

    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: "jwt");

    var url = Uri.parse(
      'http://10.0.2.2:3000/v1/user/current',
    );

    var response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
        "Access-Control-Allow-Origin": "*",
        'Authorization': 'Bearer $token',
      },
    );

    if(response.statusCode == 200) {
      var json = response.body;
      return [userFromJson(json), response.statusCode];
    } else if(response.statusCode == 401) {
      var json = response.body;
      return [statusFromJson(json), response.statusCode];
    } else {
      var json = response.body;
      return [statusFromJson(json), response.statusCode];
    }
  }

  logOut() async {
    final storage = new FlutterSecureStorage();
    var token = await storage.delete(key: "jwt");
  }
}
