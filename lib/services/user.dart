import 'package:eventorm_app/models/events.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  Future<Events?> postUser(type) async {

    var url = Uri.parse(
      'http://127.0.0.1:3000/v1/user/auth/register',
    );
/*
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
    }*/
  }
}
