import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../custom_icons/home_filled_icons.dart';
import '../utils/ui_image.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        padding: EdgeInsets.all(12.0),
        icon: SvgPicture.asset(
          UiImage.camera,
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
          padding: EdgeInsets.all(12.0),
          icon: SvgPicture.asset(
            UiImage.igtv,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
        Transform.rotate(
          angle: 0.4,
          child: IconButton(
            padding: EdgeInsets.all(12.0),
            icon: SvgPicture.asset(
              UiImage.send,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ),
        SizedBox(width: 8.0),
      ],
    );
  }

  Widget buildBody() {
    return Column();
  }

  Widget buildBottomNavigationBar() {
    final List<BottomNavigationBarItem> items = [
      BottomNavigationBarItem(
        icon: Icon(HomeFilled.home_filled),
        title: Text(''),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.search),
        title: Text(''),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.add_box),
        title: Text(''),
      ),
      BottomNavigationBarItem(
        icon: Icon(FontAwesomeIcons.heart),
        title: Text(''),
      ),
      BottomNavigationBarItem(
        icon: Icon(FontAwesomeIcons.peopleCarry),
        title: Text(''),
      ),
    ];

    return BottomNavigationBar(
      items: items,
      backgroundColor: Colors.blue,
      elevation: 20.0,
      selectedIconTheme: IconThemeData(color: Colors.black),
      unselectedIconTheme: IconThemeData(color: Colors.black54),
    );
  }
}
