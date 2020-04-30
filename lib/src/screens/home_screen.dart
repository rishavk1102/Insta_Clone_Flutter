import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../custom_icons/custom_icons.dart';
import '../utils/ui_image.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildBody(),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          CustomIcons.photo_camera,
          size: 32.0,
          color: Colors.black,
        ),
        onPressed: () {},
      ),
      titleSpacing: 8.0,
      title: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Text(
          'Instagram',
          style: TextStyle(
            fontFamily: 'BillaBong',
            fontSize: 32.0,
          ),
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            CustomIcons.igtv,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
        Transform.rotate(
          angle: 0.4,
          child: IconButton(
            icon: Icon(
              CustomIcons.paper_plane,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ),
        SizedBox(width: 12.0),
      ],
    );
  }

  Widget buildBody() {
    return Column();
  }

  Widget buildBottomNavigationBar() {
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
      elevation: 20.0,
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      currentIndex: currentIndex,
      iconSize: 24.0,
      showSelectedLabels: false,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black,
      selectedFontSize: 0.0,
      type: BottomNavigationBarType.fixed,
    );
  }
}
