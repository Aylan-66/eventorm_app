import 'package:eventorm_app/models/events.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  Future<Events?> getEvents(type) async {
    var client = http.Client();
    var uri = Uri.parse(
      'http://10.0.2.2:3000/v1/events?event_type=' + type,
    );
    var response = await client.get(uri);
    if(response.statusCode == 200) {
      var json = response.body;
      return eventsFromJson(json);
    }
  }

  Future<EventSingle?> getEventById(id) async {
    var client = http.Client();
    var uri = Uri.parse(
      'http://10.0.2.2:3000/v1/event/' + id.toString(),
    );
    var response = await client.get(uri);
    if(response.statusCode == 200) {
      var json = response.body;
      return eventFromJson(json);
    }
  }
}
