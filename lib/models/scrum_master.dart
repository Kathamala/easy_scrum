import 'package:easy_scrum/models/person.dart';

class ScrumMaster {
  late int _id;
  late Person _person;

  ScrumMaster(
    int? id,
    Person? person,
  ) {
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

  static ScrumMaster fromJson(dynamic json) {
    return ScrumMaster(
      json['id'],
      Person.fromJson(json['person']),
    );
  }
}
