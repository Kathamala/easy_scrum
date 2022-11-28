class Person {
  late int _id;
  late String _name;
  late String _nickname;
  late String _email;
  late String _password;
  late String _imageUrl;

  Person(
    int? id,
    String? name,
    String? nickname,
    String? email,
    String? password,
    String? imageUrl,
  ) {
    setId(id!);
    setName(name!);
    setNickname(nickname!);
    setEmail(email!);
    setPassword(password!);
    setImageUrl(imageUrl!);
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

  String getNickname() {
    return _nickname;
  }

  void setNickname(String nickname) {
    _nickname = nickname;
  }

  String getEmail() {
    return _email;
  }

  void setEmail(String email) {
    _email = email;
  }

  String getPassword() {
    return _password;
  }

  void setPassword(String password) {
    _password = password;
  }

  String getImageUrl() {
    return _imageUrl;
  }

  void setImageUrl(String imageUrl) {
    _imageUrl = imageUrl;
  }

  static Person fromJson(dynamic json) {
    return Person(
      json['id'],
      json['name'],
      json['nickname'],
      json['email'],
      json['password'],
      '',
    );
  }
}
