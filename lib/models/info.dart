class Info {
  late String _property;
  late String _value;

  Info(String property, String value) {
    setProperty(property);
    setValue(value);
  }

  String getProperty() {
    return _property;
  }

  void setProperty(String property) {
    _property = property;
  }

  String getValue() {
    return _value;
  }

  void setValue(String value) {
    _value = value;
  }
}