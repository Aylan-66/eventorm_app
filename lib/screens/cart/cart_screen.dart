import 'dart:async';

import 'package:eventorm_app/services/events.dart';
import 'package:flutter/material.dart';
import 'package:eventorm_app/common_widgets/app_button.dart';
import 'package:eventorm_app/helpers/column_with_seprator.dart';
import 'package:eventorm_app/models/grocery_item.dart';
import 'package:eventorm_app/widgets/chart_item_widget.dart';
import 'package:eventorm_app/models/events.dart';
import 'package:eventorm_app/services/cart.dart';
import 'package:eventorm_app/services/events.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/item_counter_widget.dart';
import 'checkout_bottom_sheet.dart';
import 'package:eventorm_app/screens/cart/CartCardWidget.dart';

class CartScreen extends StatefulWidget  {

  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  var cartDisct = [];
  var fullCart = [];
  late int cartLen;
  var totalpann = 0;
  var isLoaded = false;
  var price = 0;
  var priceaffiche = 0;

  @override
  void initState() {
    super.initState();
    //fetch data from API
    getCart();
  }

  Future<Event> getEvent(id) async {

    EventSingle? eventSingle;
    eventSingle = await RemoteService().getEventById(id);
    Event event = eventSingle!.data.event;
    return event;
  }

  getCart() async {
    print("cart distinct :");
    var asynccart = await DatabaseHelper.instance.getDistincEvent();
    var asyncFullCart = await DatabaseHelper.instance.getGroceries();
    setState(() {
     // fullCart = asyncFullCart;
      cartDisct = asynccart;

    });
    print(cartDisct);
    if (cartDisct != null) {
      setState(() {
        isLoaded = true;
      });
    }

  }

  getDistinct(index) async {
    var eventCart = await getEvent(
        cartDisct[index]["event_id"]
    );
    return eventCart;
  }

  getfinalprice() async{
    final prefs = await SharedPreferences.getInstance();
    print("sfvvdfsv");
    price = prefs.getInt('price') ?? 0;
    print("price is " + price.toString());
    await prefs.remove('price');
    if(price != 0) {
      priceaffiche = price;
    }
    return price;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 25,
              ),
              Text(
                "My Cart",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                  children: [
                    ListView.separated(
                      itemCount: cartDisct.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Visibility(
                            visible: isLoaded,
                            replacement: const Center(
                            child: CircularProgressIndicator(),
                        ),
                        child: cartCardWidget(
                            cartId: 1, eventId: cartDisct[index]["event_id"]
                        ));
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 20,
                        );
                      },
                    ),
                  ]
              ),
              Divider(
                thickness: 1,
              ),
              getCheckoutButton(context)
            ],
          ),
        ),
      ),
    );
  }

  Future<Widget> cartlist(eventCart) async{


    return Container(
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
                      eventCart.name,
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
                          itemCount: 2,
                          itemBuilder: (contextw, indexw) {
                            return FutureBuilder(
                              future: priceCartList(eventCart.id, indexw),
                              builder: (BuildContext contextw, AsyncSnapshot<Widget> textw) {
                                return textw.data!;
                              },
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
              Icon(
                Icons.close,
                /*color: AppColors.darkGrey,*/
                size: 25,
              ),
              Spacer(
                flex: 5,
              ),
              Container(
                width: 70,
                child: Text(
                  "\$5",
                ),
              ),
              Spacer(),
            ],
          )
        ],
      ),
    );
  }

  Future<Widget> priceCartList(id, index) async{
    var cartPrice = await DatabaseHelper.instance.getByEventId(id);
    print(cartPrice);
    return Container(
      height: 20,
      width: 50,
      child: Text(
          cartPrice[index].ticketName
      ),
    );
  }

  Widget imageWidget() {
    return Container(
      width: 100,
      child: Image.asset("assets/images/event_images/n_damso.png"),
    );
  }

  double getPrice() {
    return 5;
  }

  Widget getCheckoutButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      child: AppButton(
        label: "Go To Check Out",
        fontWeight: FontWeight.w600,
        padding: EdgeInsets.symmetric(vertical: 30),
        trailingWidget: getButtonPriceWidget(),
        onPressed: () {
          showBottomSheet(context);
        },
      ),
    );
  }

  Widget getButtonPriceWidget() {
    final Future<String> _calculation = Future<String>.delayed(
      const Duration(milliseconds: 1500),
          () => getfinalprice(),
    );
    return Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Color(0xff489E67),
        borderRadius: BorderRadius.circular(4),
      ),
      child:
      FutureBuilder(
        future: _calculation,
        builder: (BuildContext contextw, AsyncSnapshot<dynamic> textw) {
          return Text(
            priceaffiche.toString(),
            style: TextStyle(fontWeight: FontWeight.w600),
          );
        },
      ),
    );
  }

  void showBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return CheckoutBottomSheet();
        });
  }
}
