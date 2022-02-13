import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/navigation/navigation_constant.dart';
import '../../../core/extension/context_extension.dart';
import '../../../core/init/navigation/navigation_manager.dart';
import '../../../products/firebase/firestore/firestore_service.dart';
import '../../../products/widgets/container/neumorphic_container.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _appBarSelectedIndex = -1;
  final _borderRadius = BorderRadius.circular(32);
  int _bottomBarSelectedIndex = 0;
  final _bottomNavigationBarItems = const [
    BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.live_tv), label: 'Live'),
    BottomNavigationBarItem(
        icon: Icon(Icons.account_box_outlined), label: 'Profile'),
  ];

  final List<String> _lessons = const [
    'El becerileri',
    'Finans ve Muhasebe',
    'İşletme',
    'Müzik',
    'Pazarlama',
    'Tasarım',
    'Yazılım Geliştirme',
  ];

  Padding _buildBody(BuildContext context) {
    _bottomBarSelectedIndex = 0;
    return Padding(
      padding: context.paddingLowSymetric,
      child: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: _getSnapshots(),
                builder: ((context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  }
                  return _buildBroadcastListView(snapshot, context);
                })),
          )
        ],
      ),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: _bottomNavigationBarItems,
      currentIndex: _bottomBarSelectedIndex,
      onTap: _bottomNavigationBarOnTap,
    );
  }

  ListView _buildBroadcastListView(
      AsyncSnapshot<QuerySnapshot<Object?>> snapshot, BuildContext context) {
    return ListView(
      children: snapshot.data!.docs.map((e) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              NavigationManager.instance?.navigationToPage(
                NavigationConstant.broadcast,
                args: false,
              );
            },
            child: _buildBroadcastCard(context, e),
          ),
        );
      }).toList(),
    );
  }

  NeumorphicContainer _buildBroadcastCard(
      BuildContext context, QueryDocumentSnapshot<Object?> e) {
    return NeumorphicContainer(
      color: context.currentTheme.colorScheme.secondary,
      shadowColor: Colors.grey[400]!,
      borderRadius: _borderRadius,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              'Lesson name: ' + e['name'],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('Subject: ' + e['subject'],
                style: const TextStyle(fontWeight: FontWeight.w500)),
            Text('Total views:' + e['views'].toString(),
                style: const TextStyle(fontWeight: FontWeight.w300)),
          ],
        ),
      ),
    );
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? _getSnapshots() {
    return _appBarSelectedIndex != -1
        ? FirestoreService.instance?.fireStore
            .collection('lesson')
            .where('subject', isEqualTo: _lessons[_appBarSelectedIndex])
            .snapshots()
        : FirestoreService.instance?.fireStore.collection('lesson').snapshots();
  }

  PreferredSize _buildAppBar(BuildContext context) {
    return PreferredSize(
      child: SafeArea(
        child: Container(
          color: context.currentTheme.primaryColor,
          width: context.width,
          child: _buildTabBar(),
        ),
      ),
      preferredSize: Size(100, context.customHeight(0.06)),
    );
  }

  ListView _buildTabBar() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: _lessons.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              setState(() {
                _appBarSelectedIndex = index;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  color: _appBarSelectedIndex == index
                      ? context.currentTheme.colorScheme.onSecondary
                      : context.currentTheme.colorScheme.onPrimary,
                  borderRadius: _borderRadius),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    _lessons[index],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _bottomNavigationBarOnTap(int index) {
    setState(() {
      _bottomBarSelectedIndex = index;
    });
    switch (_bottomBarSelectedIndex) {
      case 0:
        setState(() {
          _appBarSelectedIndex = -1;
        });
        break;
      case 1:
        NavigationManager.instance
            ?.navigationToPage(NavigationConstant.createBroadcast, args: true);
        break;
      case 2:
        NavigationManager.instance
            ?.navigationToPage(NavigationConstant.profile);
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
}
