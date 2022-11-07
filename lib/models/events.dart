import 'dart:convert';

Events eventsFromJson(String str) => Events.fromJson(json.decode(str));

String eventsToJson(Events data) => json.encode(data.toJson());

class Events {
  Events({
    required this.status,
    required this.data,
  });

  String status;
  Data data;

  factory Events.fromJson(Map<String, dynamic> json) => Events(
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
    required this.events,
  });

  List<Event> events;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    events: List<Event>.from(json["events"].map((x) => Event.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "events": List<dynamic>.from(events.map((x) => x.toJson())),
  };
}

class Event {
  Event({
    required this.id,
    required this.name,
    this.description,
    required this.address,
    required this.city,
    required this.zipcode,
    required this.start_date,
    required this.end_date,
    required this.country,
    this.timezone,
    this.artists,
    this.tags,
    this.website,
    required this.event_type,
    required this.event_tickets,
  });

  int id;
  String name;
  String? description;
  String address;
  String city;
  String zipcode;
  DateTime start_date;
  DateTime end_date;
  String country;
  String? timezone;
  String? artists;
  String? tags;
  String? website;
  String event_type;
  List<EventTicket> event_tickets;

  factory Event.fromJson(Map<String, dynamic> json) => Event(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    address: json["address"],
    city: json["city"],
    zipcode: json["zipcode"],
    start_date: DateTime.parse(json["start_date"]),
    end_date: DateTime.parse(json["end_date"]),
    country: json["country"],
    timezone: json["timezone"],
    artists: json["artists"],
    tags: json["tags"],
    website: json["website"],
    event_type: json["event_type"],
    event_tickets: List<EventTicket>.from(json["event_tickets"].map((x) => EventTicket.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "address": address,
    "city": city,
    "zipcode": zipcode,
    "start_date": start_date.toIso8601String(),
    "end_date": end_date.toIso8601String(),
    "country": country,
    "timezone": timezone,
    "artists": artists,
    "tags": tags,
    "website": website,
    "event_type": event_type,
    "event_tickets": List<dynamic>.from(event_tickets.map((x) => x.toJson())),
  };
}

class EventTicket {
  EventTicket({
    this.name,
    this.price,
  });

  String? name;
  double? price;

  factory EventTicket.fromJson(Map<String, dynamic> json) => EventTicket(
    name: json["name"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "price": price,
  };
}
