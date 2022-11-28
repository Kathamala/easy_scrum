import 'package:easy_scrum/models/developer.dart';

class Participant {
  late int _id;
  late Developer _developer;
  late String _status;

  Participant(
    int? id,
    Developer? developer,
    String? status,
  ) {
    setId(id!);
    setDeveloper(developer!);
    setStatus(status!);
  }

  int getId() {
    return _id;
  }

  void setId(int id) {
    _id = id;
  }

  Developer getDeveloper() {
    return _developer;
  }

  void setDeveloper(Developer developer) {
    _developer = developer;
  }

  String getStatus() {
    return _status;
  }

  void setStatus(String status) {
    _status = status;
  }

  static Participant fromJson(dynamic json) {
    return Participant(
      json['id'],
      Developer.fromJson(json['developer']),
      json['status'],
    );
  }
}
