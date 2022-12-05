// ignore_for_file: file_names
import 'dart:convert';
import 'package:easy_scrum/models/participant.dart';
import 'package:easy_scrum/service/participation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:easy_scrum/components/BottomAppBar.dart';
import 'package:easy_scrum/components/Error.dart';
import 'package:easy_scrum/components/TopAppBar.dart';
import 'package:easy_scrum/design/colors.dart';
import 'package:easy_scrum/models/developer.dart';
import 'package:easy_scrum/models/person.dart';
import 'package:easy_scrum/models/project.dart';
import 'package:easy_scrum/models/project_member.dart';
import 'package:easy_scrum/service/people.dart';

class ProjectMembersPage extends StatefulWidget {
  final Project currentProject;

  const ProjectMembersPage({Key? key, required this.currentProject})
      : super(key: key);

  @override
  State<ProjectMembersPage> createState() => _ProjectMembersPageState();
}

class _ProjectMembersPageState extends State<ProjectMembersPage> {
  List<Developer> _allMembers = [];
  List<Developer> _members = [];

  final TextEditingController _nicknameController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Feature to control deletion
  ProjectMember _lastRemoved = ProjectMember(-1, '', '', -1, '');
  int _lastRemovedPos = -1;

  // TO-DO: to integrate
  Future<void> _refresh() async {
    setState(() {
      _members = [..._allMembers];
    });
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<Person?> _getPerson() async {
    var response = await http
        .get(PeopleService.getPersonByNickname(_nicknameController.text));
    if (response.statusCode == 200) {
      return (Person.fromJson(json.decode(response.body)));
    } else {
      ErrorHandling.getModalBottomSheet(context, response);
    }
    return null;
  }

  Future<void> _addMember() async {
    Person? person = await _getPerson();
    if (person != null) {
      Map<String, Object?> data = {
        'developer': {
          'person': {'id': person.getId()}
        },
        'status': 'DEFAULT'
      };
      var response = await http.post(
        ParticipantService.postParticipant(),
        headers: {
          'accept': '*/*',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
        setState(() {
          _allMembers.add(Participant.fromJson(json.decode(response.body)).getDeveloper());
        });
        formKey.currentState!.reset();
        Navigator.pop(context);
      } else {
        ErrorHandling.getModalBottomSheet(context, response);
      }
    }
  }

  // TO-DO: to integrate
  Future<void> _remove(int index) async {
    setState(() {
      // _lastRemoved = _members[index];
      _lastRemovedPos = index;
      _members.removeAt(index);
    });
  }

  // TO-DO: to integrate
  Future<void> _cancelRemove() async {
    setState(() {
      // _members.insert(_lastRemovedPos, _lastRemoved);
    });
  }

  Widget _getItem(context, index) {
    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      background: Container(
        color: AppColors.error,
        child: Align(
          alignment: const Alignment(-0.9, 0.0),
          child: Icon(
            Icons.delete,
            color: AppColors.white,
          ),
        ),
      ),
      direction: DismissDirection.startToEnd,
      child: ListTile(
          leading: CircleAvatar(
            backgroundColor: AppColors.primaryPurple,
            child: const Icon(Icons.person),
          ),
          title: Text(_members[index].getPerson().getName()),
          subtitle: const Text('Desenvolvedor'),
          trailing: GestureDetector(
            // onTapDown: (TapDownDetails details) {
            //   _showChangeRoleDialog(index);
            // },
            child: const Icon(Icons.edit),
          )),
      onDismissed: (direction) {
        _remove(index);
        SnackBar snack = SnackBar(
          content: Text('Integrante ${_lastRemoved.getName()} removido'),
          action: SnackBarAction(label: 'Desfazer', onPressed: _cancelRemove),
          duration: const Duration(seconds: 5),
        );
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(snack);
      },
    );
  }

  Widget _getList() {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 10.0),
      itemCount: _members.length,
      itemBuilder: _getItem,
    );
  }

  Widget _getColumn() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text('Toque no ícone ',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.primaryPurple,
                    fontSize: 14,
                    fontWeight: FontWeight.bold)),
            const Icon(Icons.edit),
            Text(' para alterar o cargo',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.primaryPurple,
                    fontSize: 14,
                    fontWeight: FontWeight.bold))
          ]),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: _refresh,
            child: _getList(),
          ),
        ),
      ],
    );
  }

  void _showAddDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: const Text('Adicionar Integrante'),
              content: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  hintText: 'Nome do usuário'),
                              controller: _nicknameController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Insira o nome do usuário';
                                } else {
                                  return null;
                                }
                              },
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancelar'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                TextButton(
                    child: const Text('Adicionar'),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.primaryPurple,
                    ),
                    onPressed: () {
                      _addMember();
                    })
              ],
            );
          });
        });
  }

  List<Widget> getActions() {
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.add),
        tooltip: 'Adicionar Participante',
        onPressed: _showAddDialog,
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    List<Developer> members = [];
    widget.currentProject.getTeams().forEach((team) {
      team.getParticipants().forEach((participant) {
        if (members
            .where((member) =>
                member.getId() == participant.getDeveloper().getId())
            .isEmpty) {
          members.add(participant.getDeveloper());
        }
      });
    });
    _allMembers = members;
    _members = [..._allMembers];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(
        Key(DateTime.now().millisecondsSinceEpoch.toString()),
        'Integrantes do Projeto',
        getActions(),
      ),
      bottomNavigationBar: const BottomAppBarEasyScrum(),
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: _getColumn(),
      ),
    );
  }
}
