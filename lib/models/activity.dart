import 'package:easy_scrum/models/developer.dart';
import 'package:easy_scrum/models/project.dart';
import 'package:easy_scrum/models/user_story.dart';

class Activity {
  late int _id;
  late Project _project;
  late UserStory _userStory;
  late Developer _responsible;
  late String _description;

  Activity(
    int? id,
    Project? project,
    UserStory? userStory,
    Developer? responsible,
    String? description,
  ) {
    setId(id!);
    setProject(project!);
    setUserStory(userStory!);
    setResponsible(responsible!);
    setDescription(description!);
  }

  int getId() {
    return _id;
  }

  void setId(int id) {
    _id = id;
  }

  Project getProject() {
    return _project;
  }

  void setProject(Project project) {
    _project = project;
  }

  UserStory getUserStory() {
    return _userStory;
  }

  void setUserStory(UserStory userStory) {
    _userStory = userStory;
  }

  Developer getResponsible() {
    return _responsible;
  }

  void setResponsible(Developer responsible) {
    _responsible = responsible;
  }

  String getDescription() {
    return _description;
  }

  void setDescription(String description) {
    _description = description;
  }

  static Activity fromJson(dynamic json) {
    return Activity(
      json['id'],
      Project.fromJson(json['project']),
      UserStory.fromJson(json['UserStory']),
      Developer.fromJson(json['responsible']),
      '',
    );
  }
}
