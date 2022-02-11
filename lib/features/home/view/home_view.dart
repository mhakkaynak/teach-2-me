import 'package:flutter/material.dart';
import 'package:teach_2_me/core/constants/navigation/navigation_constant.dart';
import 'package:teach_2_me/core/init/navigation/navigation_manager.dart';
import 'package:teach_2_me/products/firebase/firestore/firestore_service.dart';
import 'package:teach_2_me/products/models/lesson_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
            onTap: () {
              NavigationManager.instance
                  ?.navigationToPage(NavigationConstant.broadcast);
            },
            child: Text('mha')),
      ),
    );
  }
}
