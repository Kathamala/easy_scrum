import 'package:easy_scrum/service/api.dart';

class ProjectService {
  static const String _controller = '/easyscrum/projects';

  static String getController() {
    return _controller;
  }

  static Uri getProject(int projectId) {
    return Uri.http(ApiService.getEndpoint(), '$_controller/$projectId');
  }

  static Uri getProjectsByPerson(int personId, int limit, int page) {
    return Uri.http(ApiService.getEndpoint(), '$_controller/person', {
      'personId': '$personId',
    });
  }

  /*static Uri createProject(
    String name,
    String description,
    DateTime startDate,
    DateTime deadline,
  ) {
    return Uri.http(ApiService.getEndpoint(), '$_controller/create', {
      'name': name,
      'description': description,
      'startDate': startDate,
      'deadline': deadline,
    });
  }

  static Uri editProject(
    int projectId,
    String name,
    String description,
    DateTime startDate,
    DateTime deadline,
  ) {
    return Uri.http(ApiService.getEndpoint(), '$_controller/$projectId', {
      'projectId': projectId,
      'name': name,
      'description': description,
      'startDate': startDate,
      'deadline': deadline,
    });
  }*/

  static Uri postProject() {
    return Uri.http(ApiService.getEndpoint(), _controller);
  }

  static Uri putProject(int projectId) {
    return Uri.http(ApiService.getEndpoint(), '$_controller/$projectId');
  }

  static Uri deleteProject(int projectId) {
    return Uri.http(ApiService.getEndpoint(), '$_controller/$projectId');
  }
}
