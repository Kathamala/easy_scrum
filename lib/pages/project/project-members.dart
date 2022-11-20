// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:easy_scrum/design/colors.dart';
import 'package:easy_scrum/components/TopAppBar.dart';
import 'package:easy_scrum/components/BottomAppBar.dart';
import 'package:easy_scrum/models/project_member.dart';

class ProjectMembersPage extends StatefulWidget {
  const ProjectMembersPage({Key? key}) : super(key: key);

  @override
  State<ProjectMembersPage> createState() => _ProjectMembersPageState();
}

class _ProjectMembersPageState extends State<ProjectMembersPage> {
  final List<ProjectMember> _allMembers = [];
  List<ProjectMember> _members = [];

  late TextEditingController nomeController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String cargoNovoIntegrante = "";
  List checkListItems = [
    {
      "id": 0,
      "value": true,
      "title": "Scrum Master",
    },
    {
      "id": 1,
      "value": false,
      "title": "Product Owner",
    },
    {
      "id": 2,
      "value": false,
      "title": "Colaborador",
    }
  ];

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

  // TO-DO: to integrate
  Future<void> _addMember(String nome, String cargo) async {
    _allMembers.add(ProjectMember(-1, nome, '', -1, cargo));
    Navigator.pop(context);
    setState(() {
      _members = [..._allMembers];
    });
    formKey.currentState!.reset();
  }

  Future<void> _alterarCargo(int index, String cargo) async {
    _allMembers[index].setRole(cargo);
    Navigator.pop(context);
    setState(() {});
  }

  // TO-DO: to integrate
  Future<void> _remove(int index) async {
    setState(() {
      _lastRemoved = _members[index];
      _lastRemovedPos = index;
      _members.removeAt(index);
    });
  }

  // TO-DO: to integrate
  Future<void> _cancelRemove() async {
    setState(() {
      _members.insert(_lastRemovedPos, _lastRemoved);
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
          title: Text(_members[index].getName()),
          subtitle: Text(_members[index].getRole()),
          trailing: GestureDetector(
            onTapDown: (TapDownDetails details) {
              _showChangeRoleDialog(index);
            },
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
    String avisoCheckbox = '';
    bool marcouUmaCheckbox = false;

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
                                  hintText: 'Nome do novo integrante'),
                              controller: nomeController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  avisoCheckbox = '';
                                  return 'Insira o nome do novo integrante';
                                } else {
                                  return null;
                                }
                              },
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                          const Padding(
                              padding: EdgeInsets.fromLTRB(0, 24, 0, 24),
                              child:
                                  Text('Escolha o cargo do novo integrante')),
                        ],
                      ),
                      Column(
                        children: List.generate(
                          checkListItems.length,
                          (index) => CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            contentPadding: EdgeInsets.zero,
                            dense: true,
                            title: Text(
                              checkListItems[index]["title"],
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                              ),
                            ),
                            value: checkListItems[index]["value"],
                            onChanged: (value) {
                              setState(() {
                                for (var element in checkListItems) {
                                  element["value"] = false;
                                }
                                checkListItems[index]["value"] = value;
                                cargoNovoIntegrante =
                                    "${checkListItems[index]["title"]}";
                              });
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          avisoCheckbox,
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.red,
                          ),
                        ),
                      )
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
                      for (var element in checkListItems) {
                        if (element["value"] == true) {
                          marcouUmaCheckbox = true;
                        }
                      }
                      if (marcouUmaCheckbox) {
                        if (formKey.currentState!.validate()) {
                          avisoCheckbox = '';
                          marcouUmaCheckbox = false;

                          setState(() {});

                          _addMember(nomeController.text, cargoNovoIntegrante);
                          nomeController.text = '';
                        }
                      } else {
                        avisoCheckbox = 'Escolha um cargo';
                        setState(() {});
                      }
                    })
              ],
            );
          });
        });
  }

  void _showChangeRoleDialog(int index) {
    String avisoCheckbox = '';
    bool marcouUmaCheckbox = false;

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Text(
                  'Escolha o novo cargo de ' + _allMembers[index].getName()),
              content: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Column(
                      children: List.generate(
                        checkListItems.length,
                        (index) => CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                          title: Text(
                            checkListItems[index]["title"],
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          ),
                          value: checkListItems[index]["value"],
                          onChanged: (value) {
                            setState(() {
                              for (var element in checkListItems) {
                                element["value"] = false;
                              }
                              checkListItems[index]["value"] = value;
                              cargoNovoIntegrante =
                                  "${checkListItems[index]["title"]}";
                            });
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        avisoCheckbox,
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.red,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancelar'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                TextButton(
                    child: const Text('Alterar'),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.primaryPurple,
                    ),
                    onPressed: () {
                      for (var element in checkListItems) {
                        if (element["value"] == true) {
                          marcouUmaCheckbox = true;
                        }
                      }
                      if (marcouUmaCheckbox) {
                        avisoCheckbox = '';
                        marcouUmaCheckbox = false;

                        setState(() {});

                        _alterarCargo(index, cargoNovoIntegrante);
                      } else {
                        avisoCheckbox = 'Escolha um cargo';
                        setState(() {});
                      }
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
    _allMembers.add(ProjectMember(1, 'Alex', '', 1, 'Scrum Master'));
    _allMembers.add(ProjectMember(2, 'Antonio', '', 2, 'Product Owner'));
    _members = [..._allMembers];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(
        Key(DateTime.now().millisecondsSinceEpoch.toString()),
        'Integrantes do projeto',
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
