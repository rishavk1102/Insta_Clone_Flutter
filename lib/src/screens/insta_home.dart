import 'package:flutter/material.dart';

import '../custom_icons/custom_icons.dart';
import '../widgets/insta_home_bottom_navigation_bar.dart';
import '../widgets/insta_home_body.dart';

class InstaHome extends StatefulWidget {
  @override
  _InstaHomeState createState() => _InstaHomeState();
}

class _InstaHomeState extends State<InstaHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: leading(),
        title: title(),
        titleSpacing: 8.0,
        actions: actions(),
      ),
      body: InstaHomeBody(),
      bottomNavigationBar: InstaHomeBottomNavigationbar(),
    );
  }

  Widget leading() => IconButton(
        icon: Icon(
          CustomIcons.photo_camera,
          size: 32.0,
          color: Colors.black,
        ),
        onPressed: () {},
      );

  Widget title() => Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Text(
          'Instagram',
          style: TextStyle(
            fontFamily: 'BillaBong',
            fontSize: 32.0,
          ),
        ),
      );

  List<Widget> actions() => <Widget>[
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
      ];
}
