class Company {
  late int _id;
  late String _cnpj;
  late String _name;

  Company(
    int? id,
    String? cnpj,
    String? name,
  ) {
    setId(id!);
    setCnpj(cnpj!);
    setName(name!);
  }

  int getId() {
    return _id;
  }

  void setId(int id) {
    _id = id;
  }

  String getCnpj() {
    return _cnpj;
  }

  void setCnpj(String cnpj) {
    _cnpj = cnpj;
  }

  String getName() {
    return _name;
  }

  void setName(String name) {
    _name = name;
  }

  static Company fromJson(dynamic json) {
    return Company(
      json['id'],
      json['cnpj'],
      json['name'],
    );
  }
}
