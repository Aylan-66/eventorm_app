import 'package:flutter/material.dart';
import 'package:eventorm_app/screens/product_details/product_details_screen.dart';
import 'package:eventorm_app/styles/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eventorm_app/widgets/grocery_item_card_widget.dart';
import 'package:eventorm_app/widgets/search_bar_widget.dart';
import 'package:eventorm_app/services/events.dart';
import 'package:eventorm_app/models/events.dart';

import 'grocery_featured_Item_widget.dart';
import 'home_banner_widget.dart';

class HomeScreen extends StatefulWidget  {

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Events? eventsConcert;
  Events? eventsFestival;
  Events? eventsSoiree;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    //fetch data from API
    getEvents();
  }

  getEvents() async {
    //Events? eventreturn;

    //setState(() async{
      eventsFestival = await RemoteService().getEvents("festival");
      eventsSoiree = await RemoteService().getEvents("soiree");
      eventsConcert = await RemoteService().getEvents("concert");


    //});

    if (eventsSoiree != null && eventsSoiree != null && eventsSoiree != null) {
      setState(() {
        isLoaded = true;
      });
    }
    ///return eventreturn;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Image.asset('assets/images/Eventorm_logo.png', width: 140),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  padded(SearchBarWidget()),
                  SizedBox(
                    height: 25,
                  ),
                  padded(HomeBanner()),
                  SizedBox(
                    height: 25,
                  ),
                  padded(subTitle("Les concerts")),
                  getHorizontalItemSlider(eventsConcert),
                  SizedBox(
                    height: 15,
                  ),
                  padded(subTitle("Les festivals")),
                  getHorizontalItemSlider(eventsFestival),
                  SizedBox(
                    height: 15,
                  ),
                  padded(subTitle("Groceries")),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 105,
                    child: ListView(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.horizontal,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        GroceryFeaturedCard(
                          groceryFeaturedItems[0],
                          color: Color(0xffF8A44C),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        GroceryFeaturedCard(
                          groceryFeaturedItems[1],
                          color: AppColors.primaryColor,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  getHorizontalItemSlider(eventsSoiree),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget padded(Widget widget) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: widget,
    );
  }

  Widget getHorizontalItemSlider(Events? eventsfront) {

    return Visibility(
        visible: isLoaded,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child:Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          height: 250,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 20),
            itemCount: eventsfront?.data.events.length ?? 0,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              print(eventsfront!.data.events[index]);
              return GestureDetector(
                onTap: () {
                  onItemClicked(context, eventsfront!.data.events[index]);
                },
                child: GroceryItemCardWidget(
                  event: eventsfront!.data.events[index],
                  heroSuffix: "home_screena",
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                width: 20,
              );
            },
          ),
        )
    );


  }

  void onItemClicked(BuildContext context, Event event) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ProductDetailsScreen(
                event,
                heroSuffix: "home_screen",
              )),
    );
  }

  Widget subTitle(String text) {
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Spacer(),
        Text(
          "Voir tout",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor),
        ),
      ],
    );
  }

  Widget locationWidget() {
    String locationIconPath = "assets/icons/location_icon.svg";
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          locationIconPath,
        ),
      ],
    );
  }
}
