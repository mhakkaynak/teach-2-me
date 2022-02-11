abstract class INavigationManager {
  void navigationPop();

  Future<void> navigationToPage(String path, {Object? args});

  Future<void> navigationToPageAndClear(String path, {Object? args});
}
