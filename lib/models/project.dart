import 'package:easy_scrum/models/dev_team.dart';
import 'package:easy_scrum/models/product_backlog.dart';
import 'package:easy_scrum/models/product_owner.dart';
import 'package:easy_scrum/models/scrum_master.dart';

class Project {
  late int _id;
  late String _name;
  late DateTime _startDate;
  late DateTime _deadline;
  late String _status;
  late String _productOwner;
  late ScrumMaster _scrumMaster;
  late ProductBacklog _productBacklog;
  late Set<DevTeam> _teams;
  late String _logo;
  late String _description;

  Project(
      int? id,
      String? name,
      DateTime? startDate,
      DateTime? deadline,
      String? status,
      String? productOwner,
      ScrumMaster? scrumMaster,
      ProductBacklog? productBacklog,
      Set<DevTeam>? teams,
      String? logo,
      String? description) {
    setId(id!);
    setName(name!);
    setStartDate(startDate!);
    setDeadline(deadline!);
    setStatus(status!);
    setProductOwner(productOwner!);
    setScrumMaster(scrumMaster!);
    setProductBacklog(productBacklog!);
    setTeams(teams!);
    setLogo(logo!);
    setDescription(description!);
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

  DateTime getStartDate() {
    return _startDate;
  }

  void setStartDate(DateTime startDate) {
    _startDate = startDate;
  }

  DateTime getDeadline() {
    return _deadline;
  }

  void setDeadline(DateTime deadline) {
    _deadline = deadline;
  }

  String getStatus() {
    return _status;
  }

  void setStatus(String status) {
    _status = status;
  }

  String getProductOwner() {
    return _productOwner;
  }

  void setProductOwner(String productOwner) {
    _productOwner = productOwner;
  }

  ProductBacklog getProductBacklog() {
    return _productBacklog;
  }

  void setProductBacklog(ProductBacklog productBacklog) {
    _productBacklog = productBacklog;
  }

  ScrumMaster getScrumMaster() {
    return _scrumMaster;
  }

  void setScrumMaster(ScrumMaster scrumMaster) {
    _scrumMaster = scrumMaster;
  }

  Set<DevTeam> getTeams() {
    return _teams;
  }

  void setTeams(Set<DevTeam> teams) {
    _teams = teams;
  }

  String getLogo() {
    return _logo;
  }

  void setLogo(String logo) {
    _logo = logo;
  }

  String getDescription() {
    return _description;
  }

  void setDescription(String description) {
    _description = description;
  }

  static Project fromJson(dynamic json) {
    return Project(
      json['id'],
      json['name'],
      DateTime.parse(json['startDate']),
      DateTime.parse(json['deadline']),
      json['status'],
      json['productOwner'],
      ScrumMaster.fromJson(json['scrumMaster']),
      ProductBacklog.fromJson(json['productBacklog']),
      Set<DevTeam>.from(json['teams'].map((model) => DevTeam.fromJson(model))),
      json['logo'],
      json['description'],
    );
  }
}
