import 'package:flutter/material.dart';

import '../screens/insta_home.dart';

class AppRoutes {
  Route route(RouteSettings settings) {
    if (settings.name == '/') {
      return openHomeScreen(settings);
    } else {
      throw Exception('Invalid route : ${settings.name}');
    }
  }

  MaterialPageRoute openHomeScreen(RouteSettings settings) {
    return MaterialPageRoute(builder: (BuildContext context) {
      return InstaHome();
    });
  }
}

final AppRoutes appRoutes = AppRoutes();