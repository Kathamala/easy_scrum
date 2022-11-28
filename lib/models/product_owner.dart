import 'package:easy_scrum/models/company.dart';
import 'package:easy_scrum/models/person.dart';

class ProductOwner {
  late int _id;
  late Person _person;
  late Company _company;

  ProductOwner(
    int? id,
    Person? person,
    Company? company,
  ) {
    setId(id!);
    setPerson(person!);
    setCompany(company!);
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

  Company getCompany() {
    return _company;
  }

  void setCompany(Company company) {
    _company = company;
  }

  static ProductOwner fromJson(dynamic json) {
    return ProductOwner(
      json['id'],
      Person.fromJson(json['person']),
      Company.fromJson(json['company']),
    );
  }
}
