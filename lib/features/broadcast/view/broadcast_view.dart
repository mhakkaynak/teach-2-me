import 'package:flutter/material.dart';

class BroadCastView extends StatefulWidget {
  const BroadCastView({Key? key}) : super(key: key);

  @override
  State<BroadCastView> createState() => _BroadCastViewState();
}
// TODO: https://www.youtube.com/watch?v=kE0ehPMGgVc
class _BroadCastViewState extends State<BroadCastView> {
  final _appId = '211dcbbde4534352848945f77d9f2566';
  final _token =
      '006634065e8f8b442e3a079f099be0074e3IAAFl6zvqi0kL59oSqToWdVsqiTFsUicEXqzDkGr2tVkl1fucZIAAAAAEACdNB6V/UMIYgEAAQD9Qwhi';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('2'),
      ),
    );
  }
}

