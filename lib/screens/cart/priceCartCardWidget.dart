import 'package:eventorm_app/services/events.dart';
import 'package:flutter/material.dart';
import 'package:eventorm_app/common_widgets/app_button.dart';
import 'package:eventorm_app/helpers/column_with_seprator.dart';
import 'package:eventorm_app/models/grocery_item.dart';
import 'package:eventorm_app/widgets/chart_item_widget.dart';
import 'package:eventorm_app/models/events.dart';
import 'package:eventorm_app/services/cart.dart';
import 'package:eventorm_app/services/events.dart';
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
  _cartCardWidgetState createState() => _cartCardWidgetState();
}

class _cartCardWidgetState extends State<cartCardWidget> {

  EventSingle? event;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    //fetch data from API
    getEvent();
  }

  getEvent() async{
    event = await RemoteService().getEventById(widget.eventId);
    var cartDisct = await DatabaseHelper.instance.getDistincEvent();;

    if (event != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 50,
      child: Text(
          "salouz"
      ),
    );
  }
}