import 'package:easy_scrum/service/api.dart';

class MeetingService {
  static const String _controller = '/easyscrum/meetings';

  static String getController() {
    return _controller;
  }

  static Uri getMeetingsByPerson(int personId, int limit, int page) {
    return Uri.http(ApiService.getEndpoint(), '$_controller/person', {
      'personId': '$personId',
      'limit': '$limit',
      'page': '$page',
    });
  }

  static Uri getMeetingsByProjetc(int personId, int projectId, int limit, int page) {
    return Uri.http(
        ApiService.getEndpoint(), '$_controller/filters/filter_by_project', {
      'personId': '$personId',
      'projectId': '$projectId',
      'limit': '$limit',
      'page': '$page',
    });
  }

  static Uri getMeetingsToday(int personId) {
    return Uri.http(ApiService.getEndpoint(), '$_controller/today', {
      'personId': '$personId',
    });
  }

  static Uri deleteMeeting(int meetingId) {
    return Uri.http(ApiService.getEndpoint(), '$_controller/$meetingId');
  }
}
