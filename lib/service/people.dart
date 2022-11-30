import 'package:easy_scrum/service/api.dart';

class PeopleService {
  static const String _controller = '/easyscrum/people';

  static String getController() {
    return _controller;
  }

  static Uri login(String name, String password, int limit, int page) {
    return Uri.http(ApiService.getEndpoint(), '$_controller/login', {
      'name': name,
      'password': password,
      'limit': '$limit',
      'page': '$page',
    });
  }

  static Uri register(String name, String password, String email) {
    return Uri.http(ApiService.getEndpoint(), '$_controller/register', {
      'name': name,
      'password': password,
      'email': email,
    });
  }

  static Uri sendCode(String email, String code) {
    return Uri.http(ApiService.getEndpoint(), '$_controller/sendCode',
        {'email': email, 'code': code});
  }

  static Uri passwordChange(String email, String newPassword) {
    return Uri.http(ApiService.getEndpoint(), '$_controller/passwordChange',
        {'email': email, 'newPassword': newPassword});
  }

  static Uri getPeople(int personId) {
    return Uri.http(ApiService.getEndpoint(), '$_controller/$personId');
  }

  static Uri postPeople() {
    return Uri.http(ApiService.getEndpoint(), _controller);
  }

  static Uri putPeople(int personId) {
    return Uri.http(ApiService.getEndpoint(), '$_controller/$personId');
  }

  static Uri deletePeople(int personId) {
    return Uri.http(ApiService.getEndpoint(), '$_controller/$personId');
  }
}
