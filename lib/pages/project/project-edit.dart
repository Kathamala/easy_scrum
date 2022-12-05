import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:easy_scrum/design/colors.dart';
import 'package:easy_scrum/components/BottomAppBar.dart';
import 'package:easy_scrum/components/Error.dart';
/*import 'package:easy_scrum/models/company.dart';
import 'package:easy_scrum/models/info.dart';
import 'package:easy_scrum/models/person.dart';
import 'package:easy_scrum/models/product_backlog.dart';
import 'package:easy_scrum/models/product_owner.dart';
import 'package:easy_scrum/models/scrum_master.dart';*/
import 'package:easy_scrum/models/project.dart';
import 'package:easy_scrum/helpers/person.dart';
import 'package:easy_scrum/service/project.dart';
import 'package:flutter/material.dart';

class ProjectEditPage extends StatefulWidget {
  final Project currentProject;
  const ProjectEditPage({Key? key, required this.currentProject})
      : super(key: key);

  @override
  State<ProjectEditPage> createState() => _ProjectEditPageState();
}

class _ProjectEditPageState extends State<ProjectEditPage> {
  final PersonHelper _helper = PersonHelper();

  TextEditingController nomeController = TextEditingController();
  TextEditingController clienteController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController quantidadeTimesController = TextEditingController();
  DateTime startDate = DateTime.now();
  DateTime deadlineDate = DateTime.now();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    nomeController.text = widget.currentProject.getName();
    clienteController.text =
        widget.currentProject.getProductOwner().getPerson().getName();
    startDate = widget.currentProject.getStartDate();
    deadlineDate = widget.currentProject.getDeadline();
    descriptionController.text = '';
    quantidadeTimesController.text = '';

    super.initState();
  }

  Future<void> _editProject() async {
    Map<String, Object?> data;
    data = {
      'id': widget.currentProject.getId(),
      'name': nomeController.text,
      'startDate':
          '${startDate.year}-${startDate.month}-${startDate.day}T${startDate.hour}:${startDate.minute}:${startDate.second}',
      'deadline':
          '${deadlineDate.year}-${deadlineDate.month}-${deadlineDate.day}T${deadlineDate.hour}:${deadlineDate.minute}:${deadlineDate.second}',
      'status': '',
      'productOwner': {'id': _helper.getPerson()},
      'scrumMaster': {'id': _helper.getPerson()},
      'productBacklog': {},
      'teams': {},
      'logo': '',
      'description': descriptionController.text
    };
    http.Response response;
    response = await http.put(
      ProjectService.putProject(widget.currentProject.getId()),
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
    //Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          title: const Text('Alterar Projeto',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        bottomNavigationBar: const BottomAppBarEasyScrum(),
        body: SingleChildScrollView(
          child: Container(
            padding:
                const EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                                labelText: 'Nome',
                                labelStyle: TextStyle(color: Colors.black)),
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 16.0),
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
                                labelText: 'Cliente',
                                labelStyle: TextStyle(color: Colors.black)),
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 16.0),
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
                                child: Text('Data de início:',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(fontSize: 16.0)),
                              ),
                              Expanded(
                                child: Text(
                                    '${startDate.day}/${startDate.month}/${startDate.year}',
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(fontSize: 18.0)),
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
                                      backgroundColor: Colors.purple),
                                  child: const Icon(Icons.edit_calendar,
                                      color: Colors.white))
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
                                labelText: 'Descrição do projeto',
                                labelStyle: TextStyle(color: Colors.black)),
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 16.0),
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
                                labelText: 'Quantidade de times',
                                labelStyle: TextStyle(color: Colors.black)),
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 16.0),
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
                                        _editProject();
                                      }
                                    },
                                    child: const Text(
                                      'Alterar',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20.0),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            AppColors.primaryPurple,
                                        textStyle: const TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold)),
                                  ))),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ]),
          ),
        ));
  }
}
