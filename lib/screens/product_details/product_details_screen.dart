import 'dart:ui';
import 'dart:convert';
import 'package:eventorm_app/models/events.dart';
import 'package:eventorm_app/services/events.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eventorm_app/common_widgets/app_button.dart';
import 'package:eventorm_app/common_widgets/app_text.dart';
import 'package:eventorm_app/models/cart.dart';
import 'package:eventorm_app/services/cart.dart';
import 'package:eventorm_app/widgets/item_counter_widget.dart';

import 'favourite_toggle_icon_widget.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Event event;
  final String ?heroSuffix;

  const ProductDetailsScreen(this.event, {this.heroSuffix});

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int amount = 0;
  var productplace = {{}};
  var pro = {};
  Cart? cart;

  @override
  void initState() {
    super.initState();
    //fetch data from API
    setCart();
  }

  setCart() async {
    setState(() {
      for(var i = 0; i < widget.event.event_tickets.length; i++) {
        pro[i] =
        {
          "event_id": widget.event.id,
          "ticket_name": widget.event.event_tickets[i].name.toString(),
          "ticket_qty": 0,
        };
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(


    child: Column(
                mainAxisSize: MainAxisSize.min,
            children: [
              getImageHeaderWidget(),
               SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          widget.event.name.toString(),
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          widget.event.description.toString(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff7C7C7C),
                          ),
                        ),
                        trailing: FavoriteToggleIcon(),
                      ),

                      Container(

                        child: Column(
                        children: [
                          ListView.separated(
                            physics: new NeverScrollableScrollPhysics(),
                            itemCount: widget.event.event_tickets.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Text(widget.event.event_tickets[index].name.toString(),
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),),
                                  Row(
                                    children: [
                                      ItemCounterWidget(
                                        onAmountChanged: (newAmount) {
                                          setState(() {
                                            amount = newAmount;
                                            pro[index]["ticket_qty"] = newAmount;
                                          });
                                        },
                                      ),
                                      Spacer(),
                                      Text(
                                        "\$${widget.event.event_tickets[index].price}",
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) {
                              return SizedBox(
                                height: 20,
                              );
                            },
                          ),
                        ],
                      ),
                      ),

                     /*
                      Divider(thickness: 1),
                      getProductDataRowWidget("Product Details"),
                      Divider(thickness: 1),
                      getProductDataRowWidget("Nutritions",
                          customWidget: nutritionWidget()),
                      Divider(thickness: 1),
                      getProductDataRowWidget(
                        "Review",
                        customWidget: ratingWidget(),
                      ),*/

                      AppButton(
                        label: "Ajouter au panier",
                        onPressed: () async {

                         // cart = Cart.fromMap(
                         //     json.decode('{"event_id" : ' + widget.event.id.toString() + '}'));
                          //print(cart!.toMap());

                          await DatabaseHelper.instance.MultipleAdd(pro);
                          var niktamere = await DatabaseHelper.instance.getGroceries();
                          print("pine");
                        },
                      ),

                    ],
                  ),
                ),
              )

            ],
      ) ),



                );
  }

  Widget getImageHeaderWidget() {
    return Container(
      height: 250,
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
        gradient: new LinearGradient(
            colors: [
              const Color(0xFF3366FF).withOpacity(0.1),
              const Color(0xFF3366FF).withOpacity(0.09),
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(0.0, 1.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Image(
          image: AssetImage("assets/images/event_images/n_damso.png"),

      ),
    );
  }

  Widget getProductDataRowWidget(String label, {Widget? customWidget}) {
    return Container(
      margin: EdgeInsets.only(
        top: 20,
        bottom: 20,
      ),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
                fontWeight: FontWeight.w600, fontSize: 16
            ),
          ),
          Spacer(),
          if (customWidget != null) ...[
            customWidget,
            SizedBox(
              width: 20,
            )
          ],
          Icon(
            Icons.arrow_forward_ios,
            size: 20,
          )
        ],
      ),
    );
  }

  Widget nutritionWidget() {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Color(0xffEBEBEB),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        "100gm",
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 12,
          color: Color(0xff7C7C7C),
        ),
      ),
    );
  }

  Widget ratingWidget() {
    Widget starIcon() {
      return Icon(
        Icons.star,
        color: Color(0xffF3603F),
        size: 20,
      );
    }

    return Row(
      children: [
        starIcon(),
        starIcon(),
        starIcon(),
        starIcon(),
        starIcon(),
      ],
    );
  }

  double getTotalPrice() {
    /*return amount * widget.groceryItem.price!.toDouble();*/
    return 5;
  }
}
