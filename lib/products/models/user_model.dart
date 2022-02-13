import 'dart:convert';

import '../../core/base/model/base_model.dart';

class UserModel implements BaseModel {
  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    this.subjects,
  });

  UserModel._fromJson(o) {
    email = o['email'].toString();
    genre = json
        .decode(['genre'].toString()); // TODO: burdan dolayi calismayabilir.
    name = o['name'];
    password = o['password'];
    subjects = json.decode(o['subjects'].toString());
    totalViews = double.tryParse(['totalViews'].toString());
    uid = o['uid'];
  }

  UserModel.empty();

  UserModel.login({
    required this.email,
    required this.password,
  });

  UserModel.register({
    required this.name,
    required this.email,
    required this.password,
    required this.totalViews,
    required this.subjects,
  });

  String? email;
  Map<String, double>? genre;
  String? name;
  String? password;
  List<String>? subjects;
  double? totalViews;
  String? uid;

  @override
  fromObject(json) => UserModel._fromJson(json);

  @override
  Map<String, dynamic> toMap() => {
        'email': email,
        'genre': genre,
        'name': name,
        'subjects': subjects,
        'totalViews': totalViews,
        'uid': uid,
      };
}
