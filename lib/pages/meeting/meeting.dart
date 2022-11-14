import 'package:flutter/material.dart';
import 'package:easy_scrum/components/BottomAppBar.dart';
import 'package:easy_scrum/components/MultiSelectChip.dart';
import 'package:easy_scrum/components/TopAppBar.dart';
import 'package:easy_scrum/design/colors.dart';
import 'package:easy_scrum/models/category_meeting.dart';
import 'package:easy_scrum/models/item.dart';
import 'package:easy_scrum/models/meeting.dart';
import 'package:easy_scrum/models/project.dart';

class MeetingPage extends StatefulWidget {
  final Meeting? _meeting;

  const MeetingPage(Key key, this._meeting) : super(key: key);

  @override
  State<MeetingPage> createState() => _MeetingPageState();
}

class _MeetingPageState extends State<MeetingPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<Project> _projects = [];
  final List<CategoryMeeting> _categories = [];
  final List<Item> _people = [];
  late List<Item> _chosenPeople = [];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();
  final TextEditingController _datetimeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Project _projectController = Project(-1, '');
  CategoryMeeting _categoryController = CategoryMeeting(-1, '');

  String _getTitle() {
    if (widget._meeting == null) {
      return 'Cadastrar Reunião';
    }
    return 'Alterar Reunião';
  }

  String _getButtonName() {
    if (widget._meeting == null) {
      return 'Cadastrar';
    }
    return 'Alterar';
  }

  void _setInfo() {
    setState(() {
      _nameController.text = widget._meeting!.getName();
      _linkController.text = widget._meeting!.getLink();
      _datetimeController.text = widget._meeting!.getDatetime().toString();
      for (var element in _projects) {
        if (element.getId() == widget._meeting!.getProject().getId()) {
          _projectController = element;
        }
      }
      for (var element in _categories) {
        if (element.getId() == widget._meeting!.getCategory().getId()) {
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

  // TO-DO
  void _submit() {
    Navigator.of(context).pop();
  }

  Widget _getNameField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Nome *',
        helperText: 'Ex: Reunião Urgente',
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
      controller: _nameController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Insira o nome da reunião!';
        } else {
          return null;
        }
      },
    );
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
          return 'Insira o link da reunião!';
        } else {
          return null;
        }
      },
    );
  }

  Widget _getDatetimeField() {
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
      validator: (value) {
        if (value!.isEmpty) {
          return 'Insira a data e hora da reunião!';
        } else {
          return null;
        }
      },
    );
  }

  Widget _getCategory() {
    return Padding(
      padding:
          const EdgeInsets.only(left: 0.0, right: 0.0, top: 10.0, bottom: 0.0),
      child: DropdownButtonFormField<CategoryMeeting>(
        decoration: InputDecoration(
          labelText: 'Categoria *',
          labelStyle: TextStyle(
            color: AppColors.black,
          ),
        ),
        items: _categories
            .map<DropdownMenuItem<CategoryMeeting>>((CategoryMeeting value) {
          return DropdownMenuItem<CategoryMeeting>(
            value: value,
            child: Text(value.getName()),
          );
        }).toList(),
        value: _categoryController,
        onChanged: (CategoryMeeting? value) {
          setState(() {
            _categoryController = value!;
          });
        },
        validator: (value) {
          if (value!.getId() == 0) {
            return 'Selecione uma categoria!';
          } else {
            return null;
          }
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

  void _showReportDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Participantes"),
          content: MultiSelectChip(
            _people,
            _chosenPeople,
            maxSelection: _people.length,
            onSelectionChanged: (list) {
              setState(() {
                _chosenPeople = list;
              });
            },
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Fechar"),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        );
      },
    );
  }

  Widget _getDescriptionField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Descrição',
        helperText: 'Ex: Reunião com objetivo ...',
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
          _getNameField(),
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

  // 1º Modo de selecionar participantes
  List<Widget> _getActions() {
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.people),
        tooltip: 'Gerir Participantes',
        onPressed: () => _showReportDialog(),
      ),
    ];
  }

  // 2º Modo de selecionar participantes
  // Widget getPeople() {
  //   return Padding(
  //     padding:
  //         const EdgeInsets.only(left: 0.0, right: 0.0, top: 10.0, bottom: 0.0),
  //     child: TextButton(
  //       style: TextButton.styleFrom(
  //         foregroundColor: AppColors.primaryPurple,
  //       ),
  //       child: const Text("Selecionar participantes"),
  //       onPressed: () => _showReportDialog(),
  //     ),
  //   );
  // }

  @override
  void initState() {
    super.initState();
    _projects.add(Project(0, 'Escolha uma opção'));
    _projects.add(Project(1, 'Easy Scrum'));
    _categories.add(CategoryMeeting(0, 'Escolha uma opção'));
    _categories.add(CategoryMeeting(1, 'Daily'));
    _categories.add(CategoryMeeting(2, 'Stand-up'));
    _people.add(Item(0, 'Fulano de Tal'));
    _people.add(Item(1, 'Cicrano de Tal'));
    _projectController = _projects.first;
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
