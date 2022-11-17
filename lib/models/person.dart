class Person {
  late int _id;
  late String _name;
  late String _username;
  late String _email;
  late String _imageUrl;

  Person(int id, String name, String username, String email, String imageUrl) {
    setId(id);
    setName(name);
    setUsername(username);
    setEmail(email);
    setImageUrl(imageUrl);
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

  String getUsername() {
    return _username;
  }

  void setUsername(String username) {
    _username = username;
  }

  String getEmail() {
    return _email;
  }

  void setEmail(String email) {
    _email = email;
  }

  String getImageUrl() {
    return _imageUrl;
  }

  void setImageUrl(String imageUrl) {
    _imageUrl = imageUrl;
  }
}
