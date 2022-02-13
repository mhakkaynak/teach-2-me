import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:teach_2_me/core/extension/context_extension.dart';
import 'package:teach_2_me/products/firebase/firestore/firestore_service.dart';
import 'package:teach_2_me/products/models/chat_model.dart';
import 'package:teach_2_me/products/widgets/text_field/custom_text_field.dart';

import '../../../../products/widgets/container/neumorphic_container.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;

// TODO: message atarken ekrana sigmiyor onu ayarla! 

class BroadCastView extends StatefulWidget {
  const BroadCastView({Key? key}) : super(key: key);

  @override
  State<BroadCastView> createState() => _BroadCastViewState();
}

class _BroadCastViewState extends State<BroadCastView> {
  final _appId = '211dcbbde4534352848945f77d9f2566';
  final _token =
      '006634065e8f8b442e3a079f099be0074e3IAAFl6zvqi0kL59oSqToWdVsqiTFsUicEXqzDkGr2tVkl1fucZIAAAAAEACdNB6V/UMIYgEAAQD9Qwhi';
  late RtcEngine _engine;
  int? _remoteUid;
  bool _isBroadcaster = false;
  int _views = 0;
  final TextEditingController _textControler = TextEditingController();
  @override
  void initState() {
    super.initState();
    _initAgora();
  }

  @override
  void dispose() {
    super.dispose();
    _engine.destroy();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _isBroadcaster = ModalRoute.of(context)!.settings.arguments as bool;
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Stream'),
        centerTitle: true,
      ),
      body: Padding(
        padding: context.paddingLowSymetric,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: 400,
              height: 300,
              decoration: BoxDecoration(
                  color: context.currentTheme.primaryColor,
                  borderRadius: BorderRadius.circular(32)),
              child: Center(
                child: _isBroadcaster
                    ? SizedBox(
                        width: 300,
                        height: 200,
                        child: RtcLocalView.SurfaceView(),
                      )
                    : _buildRemoteView(),
              ),
            ),
            NeumorphicContainer(
              color: context.currentTheme.colorScheme.secondary,
              shadowColor: Colors.black26.withOpacity(0.3),
              height: context.normalHeight,
              borderRadius: BorderRadius.circular(12),
              child: StreamBuilder<QuerySnapshot>(
                stream: FirestoreService.instance?.fireStore
                    .collection('message' + 'lessonId') // TODO: degisecek
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  }
                  return ListView(
                    children: snapshot.data!.docs.map((e) {
                      return Padding(
                        padding: const EdgeInsets.all(12),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
                            color: context.currentTheme.colorScheme.onSecondary,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                Align(
                                  child: Text(e['sender'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: context.currentTheme
                                              .colorScheme.primary)),
                                  alignment: Alignment.centerLeft,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    e['message'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Align(
                                  child: Text(
                                    e['time'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w300),
                                  ),
                                  alignment: Alignment.bottomRight,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
            CustomTextField(
              controller: _textControler,
              context: context,
              keyboardType: null,
              hintText: 'Message',
              suffix: IconButton(
                icon: Icon(
                  Icons.send,
                  color: context.currentTheme.colorScheme.background,
                ),
                onPressed: _onPressedMessage,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _initAgora() async {
    [Permission.camera, Permission.microphone].request();
    await initAgoraRtcEngine();
    if (_isBroadcaster) {
      await _engine.createDataStream(false, false);
    }
    _engine.setEventHandler(RtcEngineEventHandler(
      userJoined: (uid, elapsed) {
        setState(() {
          _remoteUid = uid;
          _views++;
        });
      },
      userOffline: (uid, elapsed) {
        setState(() {
          _remoteUid = null;
          _views--;
        });
      },
    ));
    try {
      await _engine.joinChannel(_token, 'first', null, 0);
    } catch (e) {
      // TODO: https://github.com/AgoraIO-Community/Agora-Flutter-Quickstart/issues/184
      print(e);
    }
  }

  Future<void> initAgoraRtcEngine() async {
    _engine = await RtcEngine.create(_appId);
    await _engine.enableVideo();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    if (_isBroadcaster) {
      await _engine.setClientRole(ClientRole.Broadcaster);
    } else {
      await _engine.setClientRole(ClientRole.Audience);
    }
  }

  Widget _buildRemoteView() {
    return _remoteUid != null
        ? RtcRemoteView.SurfaceView(
            uid: _remoteUid!,
          )
        : const Center(
            child: Text('wait'),
          );
  }

  void _onPressedMessage() {
    if (_textControler.text.isNotEmpty) {
      DateTime _now = DateTime.now();
      FirestoreService.instance?.sendMessage(MessageModel(
          lessonId: 'lessonId',
          sender: 'sender',
          message: _textControler.text,
          time: '${_now.hour}:${_now.minute}'));
      _textControler.clear();
    }
  }
}
