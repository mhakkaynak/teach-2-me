import 'package:teach_2_me/products/models/lesson_model.dart';

import '../../models/user_model.dart';

abstract class IFirestoreService {
  Future<void> deleteUser(String uid);

  Future<UserModel> getUser(String uid);

  Future<void> insertUser(UserModel user);

  Future<void> addLesson(LessonModel lesson);

  Future<void> deleteLesson(LessonModel lesson);
}
