import 'package:eventorm_app/services/events.dart';
import 'package:flutter/material.dart';
import 'package:eventorm_app/common_widgets/app_button.dart';
import 'package:eventorm_app/helpers/column_with_seprator.dart';
import 'package:eventorm_app/models/grocery_item.dart';
import 'package:eventorm_app/widgets/chart_item_widget.dart';
import 'package:eventorm_app/models/events.dart';
import 'package:eventorm_app/models/cart.dart';
import 'package:eventorm_app/services/cart.dart';
import 'package:eventorm_app/services/events.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/item_counter_widget.dart';
import 'checkout_bottom_sheet.dart';
/*
class OptionItem extends StatefulWidget {
  final String? text;

  const OptionItem({Key? key, this.text}) : super(key: key);

  @override
  _OptionItemState createState() => _OptionItemState();
}

class _OptionItemState extends State<OptionItem> {*/

class cartCardWidget extends StatefulWidget  {
  final int cartId;
  final int eventId;

  const cartCardWidget({Key? key, required this.cartId, required this.eventId}) : super(key: key);

  @override
  cartCardWidgetState createState() => cartCardWidgetState();
}

class cartCardWidgetState extends State<cartCardWidget> {

  EventSingle? event;
  List<Cart>? cart;
  var isLoaded = false;
  var cartPrice = [];
  double totalevent = 0;

  @override
  void initState() {
    super.initState();
    //fetch data from API
    getEvent();
  }

  getEvent() async{
    event = await RemoteService().getEventById(widget.eventId);
    cart = await DatabaseHelper.instance.getByEventId(widget.eventId);

    if (event != null) {
      setState(() {
        isLoaded = true;
      });
    }
    return setPrice();
  }

  deleteEvent() async{
    int delete = await DatabaseHelper.instance.remove(widget.eventId);
  }

  getcing() {
    return 5;
  }

  setPrice() async{
    for(var x = 0; x < cart!.length; x++) {
      var indexzer = event!.data.event.event_tickets.indexWhere(
              (element) => element.name == cart![x].ticketName
      );
      var totalline = event!.data.event.event_tickets[indexzer].price! * cart![x].ticketQty;
      setState(() {
        totalevent += totalline;
      });
    }
    final prefs = await SharedPreferences.getInstance();
    int priceupdate = prefs.getInt('price') ?? 0;
    await prefs.setInt('price', priceupdate + totalevent.toInt());
    print(prefs.getInt('price'));
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: isLoaded,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: Container(
          height: 110,
          padding: EdgeInsets.symmetric(
            horizontal: 25,
          ),
          width: double.maxFinite,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  imageWidget(),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          event!.data.event.name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "pera",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            /*color: AppColors.darkGrey*/
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Spacer(),
                        Container(
                          height: 50,
                          width: 100,
                          padding: const EdgeInsets.only(
                              left: 5.0
                          ),
                          child: ListView.builder(
                              itemCount: cart!.length,
                              itemBuilder: (contextw, indexw) {
                                return Row(
                                  children: [
                                    Text(cart![indexw].ticketName),
                                    Text(" x "),
                                    Text(cart![indexw].ticketQty.toString())
                                  ],
                                );
                              }
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              Column(
                children: [

                  IconButton(
                    icon: Icon(
                      Icons.close,
                      /*color: AppColors.darkGrey,*/
                      size: 25,
                    ),
                      onPressed: () {
                        deleteEvent();
                      },
                  ),
                  Spacer(
                    flex: 5,
                  ),
                  Container(
                    width: 70,
                    child: Text(
                      totalevent.toString() + " €",
                    ),
                  ),
                  Spacer(),
                ],
              )
            ],
          ),
        ),
    );

  }
}

Widget imageWidget() {
  return Container(
    width: 100,
    child: Image.asset("assets/images/event_images/n_damso.png"),
  );
}