import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:teach_2_me/core/init/theme/app_theme_light.dart';

import 'core/init/navigation/navigation_manager.dart';
import 'core/init/navigation/navigation_route_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppThemeLight.instance?.lightTheme,
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigationManager.instance?.navigationKey,
      onGenerateRoute: (args) =>
          NavigationRouteManager.instance?.generateRoute(args),
      initialRoute: '/',
    );
  }
}
