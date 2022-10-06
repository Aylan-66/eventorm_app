import 'package:eventorm_app/models/events.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  Future<Events> getEvents(lat, lon) async {
    var client = http.Client();

    var uri = Uri.parse(
      'https://api.eventorm.fr/v1/events',
    );
    var response = await client.get(uri);

    if(response.statusCode == 200) {
      var json = response.body;
      return eventsFromJson(json);
    }
  }
}
