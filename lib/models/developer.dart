import 'package:easy_scrum/models/person.dart';

class Developer {
  late int _id;
  late Person _person;

  Developer(int? id, Person? person) {
    setId(id!);
    setPerson(person!);
  }

  int getId() {
    return _id;
  }

  void setId(int id) {
    _id = id;
  }

  Person getPerson() {
    return _person;
  }

  void setPerson(Person person) {
    _person = person;
  }

  static Developer fromJson(dynamic json) {
    return Developer(
      json['id'],
      Person.fromJson(json['person']),
    );
  }
}
