class Item {
  late int _id;
  late String _name;

  Item(int id, String name) {
    setId(id);
    setName(name);
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
}
