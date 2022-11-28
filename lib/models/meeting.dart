import 'package:easy_scrum/models/guest.dart';
import 'package:easy_scrum/models/person.dart';
import 'package:easy_scrum/models/project.dart';
import 'package:easy_scrum/utils/date.dart';

class Meeting {
  late int _id;
  late String _link;
  late String _description;
  late DateTime _datetime;
  late Project _project;
  late String _category;
  late List<Person> _people;
  late Set<Guest> _guests;

  Meeting(
    int? id,
    String? link,
    String? description,
    DateTime? datetime,
    Project? project,
    String? category,
    List<Person>? people,
    Set<Guest>? guests
  ) {
    setId(id!);
    setLink(link!);
    setDescription(description!);
    setDatetime(datetime!);
    setProject(project!);
    setCategory(category!);
    setPeople(people!);
    setGuests(guests!);
  }

  int getId() {
    return _id;
  }

  void setId(int id) {
    _id = id;
  }

  String getLink() {
    return _link;
  }

  void setLink(String link) {
    _link = link;
  }

  String getDescription() {
    return _description;
  }

  void setDescription(String description) {
    _description = description;
  }

  DateTime getDatetime() {
    return _datetime;
  }

  void setDatetime(DateTime datetime) {
    _datetime = datetime;
  }

  Project getProject() {
    return _project;
  }

  void setProject(Project project) {
    _project = project;
  }

  String getCategory() {
    return _category;
  }

  void setCategory(String category) {
    _category = category;
  }

  List<Person> getPeople() {
    return _people;
  }

  void setPeople(List<Person> people) {
    _people = people;
  }

  Set<Guest> getGuests() {
    return _guests;
  }

  void setGuests(Set<Guest> guests) {
    _guests = guests;
  }

  String getTitle() {
    return '${Datetime.formatDatetime(getDatetime())} [${getCategory()}]';
  }

  static Meeting fromJson(dynamic json) {
    return Meeting(
      json['id'],
      json['link'],
      json['description'],
      DateTime.parse(json['datetime']),
      Project.fromJson(json['project']),
      json['category'],
      List<Person>.from(json['guests'].map((model) => Person.fromJson(model['person']))),
      Set<Guest>.from(json['guests'].map((model) => Guest.fromJson(model))),
    );
  }
}
