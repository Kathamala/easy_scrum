import 'package:easy_scrum/service/api.dart';

class ParticipantService {
  static const String _controller = '/easyscrum/participants';

  static String getController() {
    return _controller;
  }

  static Uri postParticipant() {
    return Uri.http(ApiService.getEndpoint(), _controller);
  }

  static Uri deleteParticipant(int participant) {
    return Uri.http(ApiService.getEndpoint(), '$_controller/participant');
  }
}