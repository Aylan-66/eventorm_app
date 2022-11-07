import 'package:flutter/material.dart';
import 'package:eventorm_app/common_widgets/app_text.dart';
import 'package:eventorm_app/models/grocery_item.dart';
import 'package:eventorm_app/styles/colors.dart';
import 'package:eventorm_app/models/events.dart';

class GroceryItemCardWidget extends StatelessWidget {
  GroceryItemCardWidget({Key? key, this.event, this.heroSuffix})
      : super(key: key);
  final Event? event;
  final String? heroSuffix;

  final double width = 174;
  final double height = 250;
  final Color borderColor = Color(0xffE2E2E2);
  final double borderRadius = 18;
  double? firsprice = 0;

  @override
  Widget build(BuildContext context) {

    if (event != null && event!.event_tickets.length > 0) {
      firsprice = event!.event_tickets.first.price ?? 0;
      for (var i = 0; i < event!.event_tickets.length; i++) {
        if (event!.event_tickets[i].price! < firsprice!) {
          firsprice = event!.event_tickets[i].price;
        }
      }
    }

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor,
        ),
        borderRadius: BorderRadius.circular(
          borderRadius,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: imageWidget(),

              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              event!.name.toString(),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              event!.description.toString(),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF7C7C7C),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                 /* "\$${item?.price?.toStringAsFixed(2)}",*/
                  firsprice.toString() + "€",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                addWidget()
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget imageWidget() {
    return Container(
      child: Image.asset("assets/images/event_images/n_damso.png"),
    );
  }

  Widget addWidget() {
    return Container(
      height: 45,
      width: 45,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          color: AppColors.primaryColor),
      child: Center(
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 25,
        ),
      ),
    );
  }
}
