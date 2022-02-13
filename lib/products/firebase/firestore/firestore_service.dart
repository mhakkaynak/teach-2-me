import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teach_2_me/products/firebase/firebase_auth/firebase_auth_service.dart';
import 'package:teach_2_me/products/models/chat_model.dart';
import 'package:teach_2_me/products/models/lesson_model.dart';

import '../../models/user_model.dart';
import 'base_firestore_service.dart';

class FirestoreService implements IFirestoreService {
  FirestoreService._init() {
    _firestore = FirebaseFirestore.instance;
    _userCollectionReference = _firestore.collection('users');
    _lessonCollectionReference = _firestore.collection('lesson');
  }

  static FirestoreService? _instance;

  late final FirebaseFirestore _firestore;
  late final CollectionReference _lessonCollectionReference;
  late final CollectionReference _userCollectionReference;
  FirebaseFirestore get fireStore => _firestore;
  @override
  Future<void> addLesson(LessonModel lesson) async {
    try {
      await _lessonCollectionReference
          .add(LessonModel.addLesson(
              name: lesson.name,
              subject: lesson.subject,
              views: 0.0,
              teacherId: FirebaseAuthService.instance?.uid).toMap())
          .then((value) {
        _lessonCollectionReference.doc(value.id).update({'id': value.id});
      });
    } catch (e) {
      print(e);
      // TODO: error
    }
  }

  @override
  Future<void> deleteLesson(LessonModel lesson) async {
    try {
      await _lessonCollectionReference.doc(lesson.id).delete();
    } catch (e) {
      // TODO: error
    }
  }

  @override
  Future<void> deleteUser(String uid) async {
    try {
      await _userCollectionReference.doc(uid).delete();
    } catch (e) {
      // TODO: toast message cikabilir.
    }
  }

  @override
  Future<UserModel> getUser(String uid) async {
    UserModel user = UserModel.empty();
    try {
      var object = await _userCollectionReference.doc(uid).get();
      user = user.fromObject(object);
    } catch (e) {
      // TODO: hata
    }
    return user;
  }

  @override
  Future<void> insertUser(UserModel user) async {
    try {
      await _userCollectionReference.doc(user.uid).set(user.toMap());
    } catch (e) {
      // TODO: toast message cikabilir.
    }
  }

  @override
  Future<void> sendMessage(MessageModel message) async {
    try {
      await _firestore
          .collection('message' + message.lessonId.toString())
          .add(message.toMap());
    } catch (e) {
      // TODO: error
    }
  }

  static FirestoreService? get instance {
    _instance ??= FirestoreService._init();
    return _instance;
  }
}
