import 'package:easy_scrum/models/person.dart';

class Guest {
  late int _id;
  late Person _person;
  late String _category;

  Guest(
    int? id,
    Person? person,
    String? category,
  ) {
    setId(id!);
    setPerson(person!);
    setCategory(category!);
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

  String getCategory() {
    return _category;
  }

  void setCategory(String category) {
    _category = category;
  }

  static Guest fromJson(dynamic json) {
    return Guest(
      json['id'],
      Person.fromJson(json['person']),
      json['category'],
    );
  }
}
