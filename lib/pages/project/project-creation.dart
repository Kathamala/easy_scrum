import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:easy_scrum/design/colors.dart';
import 'package:easy_scrum/components/BottomAppBar.dart';
import 'package:easy_scrum/components/Error.dart';
//import 'package:easy_scrum/models/project.dart';
import 'package:easy_scrum/service/project.dart';
import 'package:easy_scrum/helpers/person.dart';

class ProjectCreationPage extends StatefulWidget {
  const ProjectCreationPage({Key? key}) : super(key: key);

  @override
  State<ProjectCreationPage> createState() => _ProjectCreationPageState();
}

class _ProjectCreationPageState extends State<ProjectCreationPage> {
  final PersonHelper _helper = PersonHelper();

  TextEditingController nomeController = TextEditingController();
  TextEditingController clienteController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController quantidadeTimesController = TextEditingController();
  DateTime startDate = DateTime.now();
  DateTime deadlineDate = DateTime.now();

  //Project? _projectController;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _createProject() async {
    Map<String, Object?> data;
    data = {
      //'id': '',
      'name': nomeController.text,
      'startDate':
          '${startDate.year}-${startDate.month}-${startDate.day}T${startDate.hour}:${startDate.minute}:${startDate.second}',
      'deadline':
          '${deadlineDate.year}-${deadlineDate.month}-${deadlineDate.day}T${deadlineDate.hour}:${deadlineDate.minute}:${deadlineDate.second}',
      'status': '',
      /*'productOwner': {'id': await _helper.getPerson()},
      'scrumMaster': {'id': await _helper.getPerson()},*/
      'productOwner': {'id': ''},
      'scrumMaster': {'id': ''},
      'productBacklog': {},
      'teams': {},
      'logo': '',
      'description': descriptionController.text
    };
    print(data);
    http.Response response;
    response = await http.post(
      ProjectService.postProject(),
      headers: {
        'accept': '*/*',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      Navigator.of(context).pop();
    } else {
      ErrorHandling.getModalBottomSheet(context, response);
    }
    //_resetCampos();
  }

  void _resetCampos() {
    nomeController = TextEditingController();
    clienteController = TextEditingController();
    descriptionController = TextEditingController();
    quantidadeTimesController = TextEditingController();
    setState(() => startDate = DateTime.now());
    setState(() => deadlineDate = DateTime.now());
    formKey.currentState!.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const Text(
          'Cadastrar Projeto',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: const BottomAppBarEasyScrum(
        currentScreen: 'project-creation',
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 5, 30, 20),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: 'Nome *',
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                      ),
                      controller: nomeController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Insira o nome do projeto';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const Padding(padding: EdgeInsets.only(top: 10.0)),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: 'Cliente *',
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                      ),
                      controller: clienteController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Insira o cliente do projeto';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const Padding(padding: EdgeInsets.only(top: 10.0)),
                    Row(
                      children: <Widget>[
                        const Expanded(
                          child: Text(
                            'Data de início:',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '${startDate.day}/${startDate.month}/${startDate.year}',
                            textAlign: TextAlign.left,
                            style: const TextStyle(fontSize: 18.0),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            DateTime? newDate = await showDatePicker(
                              context: context,
                              initialDate: startDate,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );
                            if (newDate == null) {
                              return;
                            }
                            setState(() => startDate = newDate);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                          ),
                          child: const Icon(Icons.edit_calendar,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(top: 10.0)),
                    Row(
                      children: <Widget>[
                        const Expanded(
                          child: Text('Deadline:',
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 16.0)),
                        ),
                        Expanded(
                          child: Text(
                              '${deadlineDate.day}/${deadlineDate.month}/${deadlineDate.year}',
                              textAlign: TextAlign.left,
                              style: const TextStyle(fontSize: 18.0)),
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              DateTime? newDate = await showDatePicker(
                                context: context,
                                initialDate: deadlineDate,
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                              );

                              if (newDate == null) {
                                return;
                              }

                              setState(() => deadlineDate = newDate);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.purple),
                            child: const Icon(Icons.edit_calendar,
                                color: Colors.white))
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(top: 10.0)),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: 'Descrição do projeto *',
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                      ),
                      controller: descriptionController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Insira a descrição do projeto';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const Padding(padding: EdgeInsets.only(top: 10.0)),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Quantidade de times *',
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                      ),
                      controller: quantidadeTimesController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Insira a quantidade de times do projeto';
                        } else {
                          return null;
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20.0,
                        bottom: 20.0,
                      ),
                      child: SizedBox(
                        height: 50.0,
                        child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              _createProject();
                            }
                          },
                          child: const Text(
                            'Cadastrar',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryPurple,
                            textStyle: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ]),
        ),
      ),
    );
  }
}
