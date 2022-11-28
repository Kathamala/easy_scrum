import 'package:easy_scrum/models/activity.dart';

class Sprint {
  late int _id;
  late int _duration;
  late DateTime _startDate;
  late DateTime _endDate;
  late Set<Activity> _activities;

  Sprint(
    int? id,
    int? duration,
    DateTime? startDate,
    DateTime? endDate,
    Set<Activity>? activities,
  ) {
    setId(id!);
    setDuration(duration!);
    setStartDate(startDate!);
    setEndDate(endDate!);
    setActivities(activities!);
  }

  int getId() {
    return _id;
  }

  void setId(int id) {
    _id = id;
  }

  int getDuration() {
    return _duration;
  }

  void setDuration(int duration) {
    _duration = duration;
  }

  DateTime getStartDate() {
    return _startDate;
  }

  void setStartDate(DateTime startDate) {
    _startDate = startDate;
  }

  DateTime getEndDate() {
    return _endDate;
  }

  void setEndDate(DateTime endDate) {
    _endDate = endDate;
  }

  Set<Activity> getActivities() {
    return _activities;
  }

  void setActivities(Set<Activity> activities) {
    _activities = activities;
  }

  static Sprint fromJson(dynamic json) {
    return Sprint(
      json['id'],
      json['duration'],
      DateTime.parse(json['startDate']),
      DateTime.parse(json['endDate']),
      Set<Activity>.from(json['activities'].map((model) => Activity.fromJson(model))),
    );
  }
}
