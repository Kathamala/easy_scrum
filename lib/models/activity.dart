class Activity {
  late int _id;
  late String _description;

  Activity(this._id, this._description);

  String getDescription(){
    return _description;
  }

  set description(String value) {
    _description = value;
  }

  int getId(){
    return _id;
  }

  set id(int value) {
    _id = value;
  }
}