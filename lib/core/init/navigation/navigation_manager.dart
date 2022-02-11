import 'package:flutter/material.dart';

import 'base_navigation_manager.dart';

class NavigationManager implements INavigationManager {
  NavigationManager._init() {
    navigationKey = GlobalKey();
    _removeOldPage = (Route<dynamic> route) => false;
  }

  static NavigationManager? _instance;

  late final GlobalKey<NavigatorState> navigationKey;
  late final bool Function(Route<dynamic>) _removeOldPage;

  @override
  void navigationPop() {
    navigationKey.currentState?.pop();
  }

  @override
  Future<void> navigationToPage(String path, {Object? args}) async {
    await navigationKey.currentState!.pushNamed(path, arguments: args);
  }

  @override
  Future<void> navigationToPageAndClear(String path, {Object? args}) async {
    await navigationKey.currentState
        ?.pushNamedAndRemoveUntil(path, _removeOldPage, arguments: args);
  }

  static NavigationManager? get instance {
    _instance ??= NavigationManager._init();
    return _instance;
  }
}
