import 'package:easy_scrum/models/category_meeting.dart';
import 'package:easy_scrum/models/person.dart';
import 'package:easy_scrum/models/project.dart';
import 'package:easy_scrum/utils/number.dart';

class Meeting {
  late int _id;
  late String _name;
  late String _link;
  late String _description;
  late DateTime _datetime;
  late Project _project;
  late CategoryMeeting _category;
  late List<Person> _people;

  Meeting(int id, String name, String link, String description, DateTime datetime, Project project, CategoryMeeting category, List<Person> people) {
    setId(id);
    setName(name);
    setLink(link);
    setDescription(description);
    setDatetime(datetime);
    setProject(project);
    setCategory(category);
    setPeople(people);
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

	String getLink() {
		return _link;
	}

	void setLink(String link) {
		_link = link;
	}

	String getDescription() {
		return _description;
	}

	void setDescription(String description) {
		_description = description;
	}

	DateTime getDatetime() {
		return _datetime;
	}

	void setDatetime(DateTime datetime) {
		_datetime = datetime;
	}

	Project getProject() {
		return _project;
	}

	void setProject(Project project) {
		_project = project;
	}

	CategoryMeeting getCategory() {
		return _category;
	}

	void setCategory(CategoryMeeting category) {
		_category = category;
	}

	List<Person> getPeople() {
		return _people;
	}

	void setPeople(List<Person> people) {
		_people = people;
	}

  String getTitle() {
    String datetime = '${Number.format(getDatetime().day)}/${Number.format(getDatetime().month)}/${Number.format(getDatetime().year)} ${Number.format(getDatetime().hour)}:${Number.format(getDatetime().minute)}:${Number.format(getDatetime().second)}';
    return '$datetime [${getCategory().getName()}]';
  }
}