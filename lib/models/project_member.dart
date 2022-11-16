//import 'package:easy_scrum/models/person.dart';

class ProjectMember {
  late int _id;
  late String _name;
  late String _imageUrl;
  late int _projectId;
  late String _role;

  ProjectMember(
      int id, String name, String imageUrl, int projectId, String role) {
    setId(id);
    setName(name);
    setImageUrl(imageUrl);
    setProjectId(projectId);
    setRole(role);
  }

  int getId() {
    return _id;
  }

  void setId(int id) {
    _id = id;
  }

  String getName() {
    return _name;
  }

  void setName(String name) {
    _name = name;
  }

  String getImageUrl() {
    return _imageUrl;
  }

  void setImageUrl(String imageUrl) {
    _imageUrl = imageUrl;
  }

  int getProjectId() {
    return _projectId;
  }

  void setProjectId(int projectId) {
    _projectId = projectId;
  }

  String getRole() {
    return _role;
  }

  void setRole(String role) {
    _role = role;
  }
}
