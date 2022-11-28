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
      'personId':  '$personId',
    });
  }
}