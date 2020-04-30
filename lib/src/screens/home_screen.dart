import 'package:flutter/material.dart';

import '../custom_icons/custom_icons.dart';
import '../widgets/bottom_navigation_bar.dart';
import '../widgets/home_body.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: HomeBody(),
      bottomNavigationBar: BottomNavigationbar(),
    );
  }

  Widget buildAppBar() {
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
}
