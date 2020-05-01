import 'package:flutter/material.dart';

import '../custom_icons/custom_icons.dart';
import '../widgets/insta_activities.dart';

import './insta_favourite.dart';
import './insta_gallery.dart';
import './insta_profile.dart';
import './insta_search.dart';

class InstaHome extends StatefulWidget {
  @override
  _InstaHomeState createState() => _InstaHomeState();
}

class _InstaHomeState extends State<InstaHome> {
  int currentIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    InstaActivities(),
    InstaSearch(),
    InstaGallery(),
    InstaFavourite(),
    InstaProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _widgetOptions[currentIndex],
      bottomNavigationBar: bottomNavBar(),
    );
  }

  Widget bottomNavBar() {
    final List<BottomNavigationBarItem> items = [
      BottomNavigationBarItem(
        icon: Icon(currentIndex == 0
            ? CustomIcons.home_filled
            : CustomIcons.home_lineal),
        title: Text(''),
      ),
      BottomNavigationBarItem(
        icon: Icon(currentIndex == 1
            ? CustomIcons.search_fill
            : CustomIcons.search_lineal),
        title: Text(''),
      ),
      BottomNavigationBarItem(
        icon: Icon(CustomIcons.add),
        title: Text(''),
      ),
      BottomNavigationBarItem(
        icon: Icon(currentIndex == 3
            ? CustomIcons.like_fill
            : CustomIcons.like_lineal),
        title: Text(''),
      ),
      BottomNavigationBarItem(
        icon: Icon(currentIndex == 4
            ? CustomIcons.people_fill
            : CustomIcons.profile_lineal),
        title: Text(''),
      ),
    ];

    return BottomNavigationBar(
      items: items,
      onTap: (int index) {
        setState(() {
          currentIndex = index;
          print(currentIndex);
        });
      },
      currentIndex: currentIndex,
      iconSize: 24.0,
      //showSelectedLabels: false,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black,
      selectedFontSize: 0.0,
      type: BottomNavigationBarType.fixed,
      elevation: 18.0,
      backgroundColor: Colors.white,
    );
  }
}
