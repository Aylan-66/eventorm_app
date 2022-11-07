import 'package:eventorm_app/models/events.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  Future<Events?> getEvents(type) async {
    var client = http.Client();
    print("asazs");
    var uri = Uri.parse(
      'https://api.eventorm.fr/v1/events?event_type=' + type,
    );
    var response = await client.get(uri);
    print("yr");
    if(response.statusCode == 200) {
      var json = response.body;
      return eventsFromJson(json);
    }
  }
}
