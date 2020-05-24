import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../widgets/user_image_with_plus_icon.dart';
import '../utils/ui_image.dart';
import '../firebase-services.dart';
import '../models/user.dart';
import '../widgets/waiting_widget.dart';
import '../models/post_data.dart';

class InstaProfile extends StatefulWidget {
  @override
  _InstaProfileState createState() => _InstaProfileState();
}

class _InstaProfileState extends State<InstaProfile>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollController;

  User currentUser;
  List<PostData> postList = [];
  FirebaseServices _firebaseServices = FirebaseServices();

  bool _currentuserController = false;
  bool _postListController = false;

  void _getPostList() {
    _postListController = true;
    _firebaseServices.getPostList(currentUser.id).then((value) {
      postList = value;
      print(postList);
      setState(() {});
    });
  }

  void _getCurrentUser() {
    _currentuserController = true;
    _firebaseServices.getCurrentUserData().then((User user) {
      this.currentUser = user;
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_currentuserController) _getCurrentUser();

    return (currentUser == null)
        ? WaitingWidget()
        : Scaffold(
            appBar: appBar(),
            body: RefreshIndicator(
              onRefresh: () async {},
              child: NestedScrollView(
                controller: _scrollController,
                headerSliverBuilder:
                    (BuildContext context, bool boxIsScrolled) => <Widget>[
                  SliverToBoxAdapter(child: userInfo()),
                  SliverPersistentHeader(
                    delegate: CustomSliverDelegate(_tabController),
                    pinned: true,
                    floating: true,
                  )
                ],
                body: TabBarView(
                  controller: _tabController,
                  children: <Widget>[
                    postGridView(),
                    taggedGridView(),
                  ],
                ),
              ),
            ),
          );
  }

  Widget appBar() => AppBar(
        elevation: 0.0,
        title: Row(
          children: <Widget>[
            Text(
              currentUser.userName,
              style: TextStyle(),
            ),
            SizedBox(width: 4.0),
            Icon(
              Icons.keyboard_arrow_down,
              size: 18.0,
            ),
          ],
        ),
        actions: <Widget>[
          Icon(Icons.menu),
          SizedBox(width: 16.0),
        ],
      );

  Widget userInfo() {
    Widget stats(String statName, int statCount) {
      return Column(
        children: <Widget>[
          Text(
            statCount.toString(),
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(statName),
        ],
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        border: Border(
          bottom: BorderSide(
            color: Colors.black26,
            width: 0.5,
          ),
        ),
      ),
      child: Container(
        margin: EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          top: 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                UserImageWithPlusIcon(url: currentUser.imageUrl),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      stats('Post', currentUser.posts),
                      stats('Followers', currentUser.followers),
                      stats('Following', currentUser.following),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              currentUser.firstName + ' ' + currentUser.lastName,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              currentUser.website,
              style: TextStyle(color: Colors.blue[900]),
            ),
            SizedBox(height: 4.0),
            Text(
              currentUser.bio,
              style: TextStyle(),
            ),
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 24.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black26,
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Edit Profile',
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }

  Widget postGridView() {
    if (!_postListController) _getPostList();

    return (postList == null)
        ? Container()
        : GridView.builder(
            itemCount: currentUser.posts,
            padding: EdgeInsets.only(top: 4.0),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 3.0,
              mainAxisSpacing: 3.0,
            ),
            // itemBuilder: (BuildContext context, int index) => Container(
            //   decoration: BoxDecoration(
            //     image: DecorationImage(
            //       fit: BoxFit.cover,
            //       image: AssetImage(UiImage.man2),
            //     ),
            //   ),
            // ),
            itemBuilder: (BuildContext context, int index) {
              return CachedNetworkImage(
                imageUrl: postList[index].gallery[0],
                fit: BoxFit.cover,
                placeholder: (context, url) => Stack(
                  children: <Widget>[
                    Image.asset(
                      'assets/images/placeholder.png',
                      fit: BoxFit.cover,
                    ),
                    Center(child: CircularProgressIndicator()),
                  ],
                ),
                imageBuilder:
                    (BuildContext context, ImageProvider imageProvider) =>
                        Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          );
  }

  Widget taggedGridView() => GridView.builder(
        itemCount: 4,
        padding: EdgeInsets.only(top: 4.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 3.0,
          crossAxisSpacing: 3.0,
        ),
        itemBuilder: (BuildContext context, int index) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(UiImage.man4),
            ),
          ),
        ),
      );
}

class CustomSliverDelegate extends SliverPersistentHeaderDelegate {
  TabController _tabController;
  CustomSliverDelegate(this._tabController);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: 50.0,
      decoration: BoxDecoration(
        color: Colors.grey[50],
      ),
      child: TabBar(
        controller: _tabController,
        indicatorColor: Colors.black,
        tabs: <Widget>[
          Icon(Icons.grid_on),
          Icon(Icons.contacts),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 50.0;

  @override
  double get minExtent => 50.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
