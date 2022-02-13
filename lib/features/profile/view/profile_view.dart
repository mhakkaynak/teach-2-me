import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:teach_2_me/core/extension/context_extension.dart';
import 'package:teach_2_me/products/firebase/firebase_auth/firebase_auth_service.dart';
import 'package:teach_2_me/products/firebase/firestore/firestore_service.dart';
import 'package:teach_2_me/products/widgets/container/neumorphic_container.dart';

import '../../../../core/constants/navigation/navigation_constant.dart';
import '../../../../core/init/navigation/navigation_manager.dart';
import '../../../../products/widgets/text_field/textfield_widget.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool teachSelected = false;
  String lessonText = "";
  List lesson = ["Matematik", "Fizizk", "Yazılım"];
  DateTime today = DateTime.now();
  DateTime lastDate = DateTime.now().add(const Duration(days: 150));
  String secilenTarihStr = DateTime.now().toString().substring(0, 10);

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: context.currentTheme.primaryColor,
            title: const Text("PROFİL"),
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              physics: const BouncingScrollPhysics(),
              children: [
                Center(
                  child: Stack(
                    children: [
                      ClipOval(
                        child: Material(
                          color: Colors.transparent,
                          child: Ink.image(
                            image: const NetworkImage(
                                "https://instagram.fsaw2-3.fna.fbcdn.net/v/t51.2885-19/s320x320/273493547_493569468825654_1287853618984158140_n.jpg?_nc_ht=instagram.fsaw2-3.fna.fbcdn.net&_nc_cat=106&_nc_ohc=Ru7dNbiuhIEAX-Wedt6&edm=ABfd0MgBAAAA&ccb=7-4&oh=00_AT9nZ0lkGl9_ZnBC4Siw40gKsfVcVaNddlvDk5UrqKcumg&oe=620F2C50&_nc_sid=7bff83"),
                            fit: BoxFit.cover,
                            width: 128,
                            height: 128,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                TextFieldWidget(
                  label: 'Name',
                  text: "Emir",
                  maxLines: 1,
                  onChanged: (name) {},
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Email',
                  text: "Emr9229@mail.com",
                  onChanged: (email) {},
                  maxLines: 1,
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'About',
                  text: "BENİM HAKKIMDA",
                  maxLines: 2,
                  onChanged: (about) {},
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      context.currentTheme.primaryColor,
                    ),
                    elevation: MaterialStateProperty.all(6),
                    shape: MaterialStateProperty.all(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(50),
                        ),
                      ),
                    ),
                  ),
                  child: Text(
                    'Save',
                    style: TextStyle(
                      fontFamily: 'PT-Sans',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: context.currentTheme.colorScheme.onSecondary,
                    ),
                  ),
                  onPressed: () {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: context.highHeight,
                          color: Colors.amber,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                StreamBuilder<QuerySnapshot>(
                                  stream: FirestoreService.instance?.fireStore
                                      .collection('users')
                                      .where('uid',
                                          isEqualTo:
                                              FirebaseAuthService.instance?.uid)
                                      .snapshots(),
                                  builder: ((context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return Container();
                                    }
                                    return Expanded(
                                      child: Container(
                                        // TODO: degistir duzelt bul biseyler
                                        child: snapshot.data!.docs.map((e) {
                                          Map<String, dynamic> genre =
                                              e['genre'];
                                          var keys = genre.keys.toList();
                                          var values = genre.values.toList();
                                          return Expanded(
                                            child: ListView.builder(
                                              itemCount: 1,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Row(
                                                  children: [
                                                    NeumorphicContainer(
                                                      color: context
                                                          .currentTheme
                                                          .colorScheme
                                                          .secondary,
                                                      shadowColor:
                                                          Colors.grey[400]!,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                      child: Text(keys[index]),
                                                    )
                                                  ],
                                                );
                                              },
                                            ),
                                          );
                                        }).toList()[0],
                                      ),
                                    );
                                  }),
                                ),
                                FloatingActionButton(
                                  onPressed: () {},
                                  child: Icon(Icons.add),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );

  chooseTeach(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.4,
          color: context.currentTheme.colorScheme.secondary,
          child: ListView.separated(
              separatorBuilder: (context, index) => const Divider(
                    color: Colors.black,
                  ),
              itemCount: lesson.length,
              itemBuilder: (context, index) {
                return Container(
                    margin: EdgeInsets.all(5),
                    child: ListTile(
                        title: Center(
                          child: Text(
                            lesson[index].toString(),
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            teachSelected = true;
                            lessonText = lesson[index];
                            Navigator.pop(context);
                          });
                        }));
              }),
        );
      },
    );
  }
}
