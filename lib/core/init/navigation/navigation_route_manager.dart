import 'package:flutter/material.dart';
import 'package:teach_2_me/features/broadcast/view/broadcast_view.dart';

import '../../../features/home/view/home_view.dart';
import '../../constants/navigation/navigation_constant.dart';

class NavigationRouteManager {
  NavigationRouteManager._init();

  static NavigationRouteManager? _instance;

  static NavigationRouteManager? get instance {
    _instance ??= NavigationRouteManager._init();
    return _instance;
  }

  Route<dynamic> generateRoute(RouteSettings args) {
    switch (args.name) {
      case NavigationConstant.home:
        return _navigationToDefault(const HomeView(), args);
      case NavigationConstant.broadcast:
        return _navigationToDefault(const BroadCastView(), args);
      default:
        return _navigationToDefault(const HomeView(), args);
    }
  }

  MaterialPageRoute _navigationToDefault(Widget page, RouteSettings args) =>
      MaterialPageRoute(builder: (context) => page, settings: args);
}
