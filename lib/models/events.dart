import 'dart:convert';

Events eventsFromJson(String str) => Events.fromJson(json.decode(str));

String eventsToJson(Events data) => json.encode(data.toJson());

class Events {
  Events({
    this.status,
    this.data,
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
    this.events,
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
    this.id,
    this.name,
    this.description,
    this.address,
    this.city,
    this.zipcode,
    this.startDate,
    this.endDate,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.refundPolicy,
    this.country,
    this.major,
    this.deadline,
    this.timezone,
    this.artists,
    this.privacy,
    this.tags,
    this.organizerId,
    this.website,
    this.plan,
    this.eventParameters,
    this.eventType,
  });

  int id;
  String name;
  String description;
  String address;
  String city;
  String zipcode;
  DateTime startDate;
  DateTime endDate;
  Status status;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic refundPolicy;
  Country country;
  bool major;
  DateTime deadline;
  Timezone timezone;
  String artists;
  bool privacy;
  String tags;
  int organizerId;
  String website;
  Plan plan;
  dynamic eventParameters;
  EventType eventType;

  factory Event.fromJson(Map<String, dynamic> json) => Event(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    address: json["address"],
    city: json["city"],
    zipcode: json["zipcode"],
    startDate: DateTime.parse(json["start_date"]),
    endDate: DateTime.parse(json["end_date"]),
    status: statusValues.map[json["status"]],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    refundPolicy: json["refund_policy"],
    country: countryValues.map[json["country"]],
    major: json["major"],
    deadline: DateTime.parse(json["deadline"]),
    timezone: timezoneValues.map[json["timezone"]],
    artists: json["artists"],
    privacy: json["privacy"],
    tags: json["tags"],
    organizerId: json["organizer_id"],
    website: json["website"],
    plan: planValues.map[json["plan"]],
    eventParameters: json["event_parameters"],
    eventType: eventTypeValues.map[json["event_type"]],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "address": address,
    "city": city,
    "zipcode": zipcode,
    "start_date": startDate.toIso8601String(),
    "end_date": endDate.toIso8601String(),
    "status": statusValues.reverse[status],
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "refund_policy": refundPolicy,
    "country": countryValues.reverse[country],
    "major": major,
    "deadline": deadline.toIso8601String(),
    "timezone": timezoneValues.reverse[timezone],
    "artists": artists,
    "privacy": privacy,
    "tags": tags,
    "organizer_id": organizerId,
    "website": website,
    "plan": planValues.reverse[plan],
    "event_parameters": eventParameters,
    "event_type": eventTypeValues.reverse[eventType],
  };
}

enum Country { FR }

final countryValues = EnumValues({
  "FR": Country.FR
});

enum EventType { CONCERT, FESTIVAL, SOIREE }

final eventTypeValues = EnumValues({
  "concert": EventType.CONCERT,
  "festival": EventType.FESTIVAL,
  "soiree": EventType.SOIREE
});

enum Plan { PREMIUM }

final planValues = EnumValues({
  "PREMIUM": Plan.PREMIUM
});

enum Status { DRAFT }

final statusValues = EnumValues({
  "DRAFT": Status.DRAFT
});

enum Timezone { UTC_2_PARIS }

final timezoneValues = EnumValues({
  "UTC+2 Paris": Timezone.UTC_2_PARIS
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
