import 'package:teach_2_me/core/base/model/base_model.dart';

class LessonModel implements BaseModel {
  LessonModel._fromJson(o) {
    id = o['id'].toString();
    name = o['name'].toString();
    subject = o['subject'].toString();
    views = double.tryParse(o['views'].toString());
    teacherId = o['teacherId'].toString();
  }

  LessonModel({
    this.name,
    this.subject,
  });

  LessonModel.addLesson({
    required this.name,
    required this.subject,
    required this.views,
    required this.teacherId,
  });

  String? id;
  String? name;
  String? subject;
  String? teacherId;
  double? views;

  @override
  fromObject(json) => LessonModel._fromJson(json);

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'subject': subject,
        'views': views,
        'teacherId': teacherId
      };
}
