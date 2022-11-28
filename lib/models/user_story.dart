class UserStory {
  late int _id;
  late String _title;
  late String _acceptanceCriterion;
  late String _description;
  late String _status;

  UserStory(
    int? id,
    String? title,
    String? acceptanceCriterion,
    String? description,
    String? status,
  ) {
    setId(id!);
    setTitle(title!);
    setAcceptanceCriterion(acceptanceCriterion!);
    setDescription(description!);
    setStatus(status!);
  }

  int getId() {
    return _id;
  }

  void setId(int id) {
    _id = id;
  }

  String getTitle() {
    return _title;
  }

  void setTitle(String title) {
    _title = title;
  }

  String getAcceptanceCriterion() {
    return _acceptanceCriterion;
  }

  void setAcceptanceCriterion(String acceptanceCriterion) {
    _acceptanceCriterion = acceptanceCriterion;
  }

  String getDescription() {
    return _description;
  }

  void setDescription(String description) {
    _description = description;
  }

  String getStatus() {
    return _status;
  }

  void setStatus(String status) {
    _status = status;
  }

  static UserStory fromJson(dynamic json) {
    return UserStory(
      json['id'],
      json['title'],
      json['acceptanceCriterion'],
      json['description'],
      json['status'],
    );
  }
}
