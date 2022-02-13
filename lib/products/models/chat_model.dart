import 'package:teach_2_me/core/base/model/base_model.dart';

class MessageModel implements BaseModel {
  MessageModel({
    required this.lessonId,
    required this.sender,
    required this.message,
    required this.time,
  });

  MessageModel._fromJson(o) {
    lessonId = o['lessonId'].toString();
    sender = o['sender'].toString();
    message = o['message'].toString();
    time = o['time'].toString();
  }

  String? lessonId;
  String? message;
  String? sender;
  String? time;

  @override
  fromObject(json) => MessageModel._fromJson(json);

  @override
  Map<String, dynamic> toMap() => {
        'lessonId': lessonId,
        'sender': sender,
        'message': message,
        'time': time,
      };
}
