import 'package:flutter/material.dart';
import 'package:eventorm_app/screen/home/homeScreen.dart';
import 'package:eventorm_app/screen/page_one/index.dart';
import 'package:eventorm_app/screen/page_two/index.dart';
import 'package:eventorm_app/screen/page_three/index.dart';
import 'package:eventorm_app/constants.dart';

class Nav extends StatefulWidget {
  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    pageOne(),
    pageTwo(),
    pageThree(),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/Eventorm_logo.png', width: 140,),
        actions: [
          IconButton(onPressed: () => {},
              icon: const Icon(
                Icons.shopping_cart,
                size: 25,
                color: EvBaseColor,
              ))
        ],
        backgroundColor: Colors.white,
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: Container(
              height: 5,
              color: EvBaseColor,
            )),
     ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: EvBaseColor, width: 5))
        ),
        child: BottomNavigationBar(
          unselectedItemColor: EvBaseColor,
          selectedItemColor: EvBaseColor,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home, size: 35,),
                label:'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.message, size: 35,),
                label: 'message'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person,size: 35,),
                label:'person'
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTap,
        ),
      ),
    );
  }
}