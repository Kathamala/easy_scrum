class Person {
  late int _id;
  late String _name;
  late String _imageUrl;

  Person(int id, String name, String imageUrl) {
    setId(id);
    setName(name);
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

  String getImageUrl() {
    return _imageUrl;
  }

  void setImageUrl(String imageUrl) {
    _imageUrl = imageUrl;
  }
}
