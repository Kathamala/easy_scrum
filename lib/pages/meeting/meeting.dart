import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:easy_scrum/components/BottomAppBar.dart';
import 'package:easy_scrum/components/Error.dart';
import 'package:easy_scrum/components/MultiSelectChip.dart';
import 'package:easy_scrum/components/TopAppBar.dart';
import 'package:easy_scrum/design/colors.dart';
import 'package:easy_scrum/helpers/person.dart';
import 'package:easy_scrum/models/item.dart';
import 'package:easy_scrum/models/meeting.dart';
import 'package:easy_scrum/models/project.dart';
import 'package:easy_scrum/service/meeting.dart';
import 'package:easy_scrum/service/project.dart';

class MeetingPage extends StatefulWidget {
  final Meeting? _meeting;

  const MeetingPage(Key key, this._meeting) : super(key: key);

  @override
  State<MeetingPage> createState() => _MeetingPageState();
}

class _MeetingPageState extends State<MeetingPage> {
  final PersonHelper _helper = PersonHelper();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<Project> _projects = [];
  List<Item> _people = [];
  List<Item> _chosenPeople = [];

  final List<String> _categories = [];

  final TextEditingController _linkController = TextEditingController();
  final TextEditingController _datetimeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Project? _projectController;
  String? _categoryController;

  Future<void> _findProject() async {
    var response =
        await http.get(ProjectService.getProject(_projectController!.getId()));
    if (response.statusCode == 200) {
      Project project = Project.fromJson(json.decode(response.body));
      List<Item> people = [];
      people.add(Item(project.getScrumMaster().getPerson().getId(),
          project.getScrumMaster().getPerson().getName()));
      project.getTeams().forEach((item) {
        item.getParticipants().forEach((element) {
          people.add(Item(element.getDeveloper().getPerson().getId(),
              element.getDeveloper().getPerson().getName()));
        });
      });
      setState(() {
        _people = [...people];
      });
      if (widget._meeting != null) {
        List<Item> guests = [];
        widget._meeting!.getPeople().forEach((element) {
          guests.add(Item(element.getId(), element.getName()));
        });
        setState(() {
          _chosenPeople = [...guests];
        });
      }
    } else {
      ErrorHandling.getModalBottomSheet(context, response);
    }
  }

  Future<void> _findProjects(int limit, int page) async {
    var response = await http.get(ProjectService.getProjectsByPerson(
        await _helper.getPerson(), limit, page));
    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      setState(() {
        _projects = [
          ...List<Project>.from(list.map((model) => Project.fromJson(model)))
        ];
        if (_projects.isEmpty == false) {
          _projectController = _projects.first;
          _findProject();
        }
      });
    } else {
      ErrorHandling.getModalBottomSheet(context, response);
    }
  }

  Object _getGuest(Item item) {
    Object data = {};
    widget._meeting!.getGuests().forEach((element) {
      if (element.getPerson().getId() == item.getId()) {
        data = {'id': element.getId()};
      }
    });
    if (data == {}) {
      data = {
        'person': {'id': item.getId()},
        'category': 'DEFAULT'
      };
    }
    return data;
  }

  Future<void> _submit() async {
    Map<String, Object?> data;
    List<String> datetime = _datetimeController.text.split(' ');
    List<String> date = datetime[0].split('/');
    List<String> time = datetime[1].split(':');
    data = {
      'link': _linkController.text,
      'datetime':
          '${date[2]}-${date[1]}-${date[0]}T${time[0]}:${time[1]}:${time[2]}',
      'category': _categoryController,
      'project': {'id': _projectController!.getId()},
      'description': _descriptionController.text
    };
    http.Response response;
    if (widget._meeting == null) {
      data['guests'] = List<Object>.from(
        _chosenPeople.map(
          (element) => {
            'person': {'id': element.getId()},
            'category': 'DEFAULT'
          },
        ),
      );
      response = await http.post(
        MeetingService.postMeeting(),
        headers: {
          'accept': '*/*',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );
    } else {
      data['id'] = widget._meeting!.getId();
      data['guests'] = List<Object>.from(
        _chosenPeople.map(
          (element) => _getGuest(element),
        ),
      );
      response = await http.put(
        MeetingService.putMeeting(widget._meeting!.getId()),
        headers: {
          'accept': '*/*',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );
    }
    if (response.statusCode == 200) {
      Navigator.of(context).pop();
    } else {
      ErrorHandling.getModalBottomSheet(context, response);
    }
  }

  String _getTitle() {
    if (widget._meeting == null) {
      return 'Cadastrar Reuni??o';
    }
    return 'Alterar Reuni??o';
  }

  String _getButtonName() {
    if (widget._meeting == null) {
      return 'Cadastrar';
    }
    return 'Alterar';
  }

  void _setInfo() {
    setState(() {
      _linkController.text = widget._meeting!.getLink();
      _datetimeController.text =
          widget._meeting!.getDatetime().toString().split('.')[0];
      for (var element in _projects) {
        if (element.getId() == widget._meeting!.getProject().getId()) {
          _projectController = element;
        }
      }
      for (var element in _categories) {
        if (element == widget._meeting!.getCategory()) {
          _categoryController = element;
        }
      }
      _chosenPeople = widget._meeting!
          .getPeople()
          .map((element) => Item(element.getId(), element.getName()))
          .toList();
      _descriptionController.text = widget._meeting!.getDescription();
    });
  }

  Widget _getLinkField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Link *',
        helperText: 'Ex: https://meet.google.com',
        labelStyle: TextStyle(
          color: AppColors.black,
          fontSize: 12,
        ),
      ),
      textAlign: TextAlign.center,
      style: TextStyle(
        color: AppColors.black,
      ),
      keyboardType: TextInputType.text,
      controller: _linkController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Insira o link da reuni??o!';
        } else {
          return null;
        }
      },
    );
  }

  Widget _getDatetimeField() {
    var maskFormatter = MaskTextInputFormatter(
        mask: '##/##/#### ##:##:##', filter: {"#": RegExp(r'[0-9]')});
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Data e Hora *',
        helperText: 'Ex: 10/10/2022 10:00:00',
        labelStyle: TextStyle(
          color: AppColors.black,
          fontSize: 12,
        ),
      ),
      textAlign: TextAlign.center,
      style: TextStyle(
        color: AppColors.black,
      ),
      keyboardType: TextInputType.datetime,
      controller: _datetimeController,
      inputFormatters: [maskFormatter],
      validator: (value) {
        if (value!.isEmpty) {
          return 'Insira a data e hora da reuni??o!';
        } else {
          if (value.length != 19) {
            return 'Complete a data e hora da reuni??o!';
          }
        }
        return null;
      },
    );
  }

  Widget _getCategory() {
    return Padding(
      padding:
          const EdgeInsets.only(left: 0.0, right: 0.0, top: 10.0, bottom: 0.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Categoria *',
          labelStyle: TextStyle(
            color: AppColors.black,
          ),
        ),
        items: _categories.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value.toLowerCase()),
          );
        }).toList(),
        value: _categoryController,
        onChanged: (String? value) {
          setState(() {
            _categoryController = value!;
          });
        },
      ),
    );
  }

  Widget _getProject() {
    return Padding(
      padding:
          const EdgeInsets.only(left: 0.0, right: 0.0, top: 10.0, bottom: 0.0),
      child: DropdownButtonFormField<Project>(
        decoration: InputDecoration(
          labelText: 'Projeto *',
          labelStyle: TextStyle(
            color: AppColors.black,
          ),
        ),
        items: _projects.map<DropdownMenuItem<Project>>((Project value) {
          return DropdownMenuItem<Project>(
            value: value,
            child: Text(value.getName()),
          );
        }).toList(),
        value: _projectController,
        onChanged: (Project? value) {
          setState(() {
            _projectController = value!;
          });
        },
        validator: (value) {
          if (value!.getId() == 0) {
            return 'Selecione um projeto!';
          } else {
            return null;
          }
        },
      ),
    );
  }

  Widget _getDescriptionField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Descri????o',
        helperText: 'Ex: Reuni??o com objetivo ...',
        labelStyle: TextStyle(
          color: AppColors.black,
          fontSize: 12,
        ),
      ),
      textAlign: TextAlign.center,
      style: TextStyle(
        color: AppColors.black,
      ),
      keyboardType: TextInputType.multiline,
      minLines: 2,
      maxLines: null,
      controller: _descriptionController,
    );
  }

  Widget _getButton() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20.0,
        bottom: 20.0,
      ),
      child: SizedBox(
        height: 50.0,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(AppColors.primaryPurple),
          ),
          child: Text(
            _getButtonName(),
            style: TextStyle(
              color: AppColors.white,
              fontSize: 20.0,
            ),
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _submit();
            }
          },
        ),
      ),
    );
  }

  Widget getForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _getLinkField(),
          _getDatetimeField(),
          _getCategory(),
          _getProject(),
          _getDescriptionField(),
          _getButton(),
        ],
      ),
    );
  }

  void _showPeopleDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Convidados'),
          content: MultiSelectChip(
            _people,
            _chosenPeople,
            maxSelection: _people.length,
            onSelectionChanged: (list) {
              setState(() {
                _chosenPeople = [...list];
              });
            },
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Fechar'),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        );
      },
    );
  }

  List<Widget> _getActions() {
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.people),
        tooltip: 'Gerir Convidados',
        onPressed: () => _showPeopleDialog(),
      ),
    ];
  }

  @override
  void initState() {
    super.initState();

    _findProjects(10, 0);

    _categories.add('DEFAULT');
    _categories.add('DAILY');
    _categories.add('PLANNING');
    _categories.add('REVIEW');
    _categories.add('RETROSPECTIVE');
    _categories.add('PRODUCT_BACKLOG_REFINEMENT');

    _categoryController = _categories.first;

    if (widget._meeting == null) {
    } else {
      _setInfo();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(
        Key(DateTime.now().millisecondsSinceEpoch.toString()),
        _getTitle(),
        _getActions(),
      ),
      bottomNavigationBar: const BottomAppBarEasyScrum(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        child: getForm(),
      ),
    );
  }
}
