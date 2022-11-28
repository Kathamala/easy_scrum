import 'package:easy_scrum/models/participant.dart';

class DevTeam {
  late int _id;
  late String _surname;
  late Set<Participant> _participants;

  DevTeam(
    int? id,
    String? surname,
    Set<Participant>? participants,
  ) {
    setId(id!);
    setSurname(surname!);
    setParticipants(participants!);
  }

  int getId() {
    return _id;
  }

  void setId(int id) {
    _id = id;
  }

  String getSurname() {
    return _surname;
  }

  void setSurname(String surname) {
    _surname = surname;
  }

  Set<Participant> getParticipants() {
    return _participants;
  }

  void setParticipants(Set<Participant> participants) {
    _participants = participants;
  }

  static DevTeam fromJson(dynamic json) {
    return DevTeam(
      json['id'],
      json['surname'],
      Set<Participant>.from(json['participants'].map((model) => Participant.fromJson(model))),
    );
  }
}
