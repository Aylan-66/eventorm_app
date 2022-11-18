import 'dart:convert';
/*
List<Cart> cartFromJson(String str) => List<Cart>.from(json.decode(str).map((x) => Cart.fromJson(x)));

String cartToJson(List<Cart> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
*/

class Cart {
  Cart({
    required this.eventId,
    required this.ticketName,
    required this.ticketQty,
  });

  int eventId;
  String ticketName;
  int ticketQty;

  factory Cart.fromMap(Map<String, dynamic> json) => new Cart(
    eventId: json["event_id"],
    ticketName: json["ticket_name"],
    ticketQty: json["ticket_qty"],
  );

  Map<String, dynamic> toMap()  {
    return {
      "event_id": eventId,
      "ticket_name": ticketName,
      "ticket_qty": ticketQty,
    };

  }
}

/*
class Cart {
  final int event_id;
  final List<EventTicketCart> eventTicketCart;

  const Cart({
    required this.event_id,
    required this.eventTicketCart,
  });
}

class EventTicketCart {
  final String ticket_name;
  final int qty;

  const EventTicketCart({
    required this.ticket_name,
    required this.qty,
  });
}*/



/**


    class Cart {
    Cart({
    required this.eventId,
    required this.eventTicketsCart,
    });

    int eventId;
    List<EventTicketsCart> eventTicketsCart;

    factory Cart.fromMap(Map<String, dynamic> json) => new Cart(
    eventId: json["event_id"],
    eventTicketsCart: List<EventTicketsCart>.from(json["event_tickets_cart"].map((x) => EventTicketsCart.fromMap(x))),
    );

    Map<String, dynamic> toMap()  {
    return {
    "event_id": eventId,
    "event_tickets_cart": List<dynamic>.from(eventTicketsCart.map((x) => x.toMap())),
    };

    }
    }

    class EventTicketsCart {
    EventTicketsCart({
    required this.name,
    required this.qty,
    });

    String name;
    int qty;

    factory EventTicketsCart.fromMap(Map<String, dynamic> json) => new EventTicketsCart(
    name: json["name"],
    qty: json["qty"],
    );

    Map<String, dynamic> toMap() {
    return {
    "name": name,
    "qty": qty,
    };
    }
    }

**/