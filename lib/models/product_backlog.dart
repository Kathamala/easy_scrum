import 'package:easy_scrum/models/user_story.dart';

class ProductBacklog {
  late int _id;
  late Set<UserStory> _stories;

  ProductBacklog(
    int? id,
    Set<UserStory>? stories,
  ) {
    setId(id!);
    setStories(stories!);
  }

  int getId() {
    return _id;
  }

  void setId(int id) {
    _id = id;
  }

  Set<UserStory> getStories() {
    return _stories;
  }

  void setStories(Set<UserStory> stories) {
    _stories = stories;
  }

  static ProductBacklog fromJson(dynamic json) {
    return ProductBacklog(
      json['id'],
      Set<UserStory>.from(json['stories'].map((model) => UserStory.fromJson(model))),
    );
  }
}
