// ignore_for_file: file_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:easy_scrum/components/BottomAppBar.dart';
import 'package:easy_scrum/components/Error.dart';
import 'package:easy_scrum/design/colors.dart';
import 'package:easy_scrum/models/project.dart';
import 'package:easy_scrum/service/project.dart';
import 'package:easy_scrum/utils/number.dart';

class ProjectEditPage extends StatefulWidget {
  final Project currentProject;
  const ProjectEditPage({Key? key, required this.currentProject}): super(key: key);

  @override
  State<ProjectEditPage> createState() => _ProjectEditPageState();
}

class _ProjectEditPageState extends State<ProjectEditPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _clientController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime _startDate = DateTime.now();
  DateTime _deadlineDate = DateTime.now();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<Map<String, Object?>> _findProject() async {
    var response = await http.get(ProjectService.getProject(widget.currentProject.getId()));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      ErrorHandling.getModalBottomSheet(context, response);
    }
    return {};
  }

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.currentProject.getName();
    _clientController.text = widget.currentProject.getProductOwner();
    _startDate = widget.currentProject.getStartDate();
    _deadlineDate = widget.currentProject.getDeadline();
    _descriptionController.text = widget.currentProject.getDescription();
  }

  Future<void> _editProject() async {
    Map<String, Object?> data = await _findProject();
    data['name'] = _nameController.text;
    data['startDate'] = '${Number.formatNumber(_startDate.year)}-${Number.formatNumber(_startDate.month)}-${Number.formatNumber(_startDate.day)}T${Number.formatNumber(_startDate.hour)}:${Number.formatNumber(_startDate.minute)}:${Number.formatNumber(_startDate.second)}';
    data['deadline'] = '${Number.formatNumber(_deadlineDate.year)}-${Number.formatNumber(_deadlineDate.month)}-${Number.formatNumber(_deadlineDate.day)}T${Number.formatNumber(_deadlineDate.hour)}:${Number.formatNumber(_deadlineDate.minute)}:${Number.formatNumber(_deadlineDate.second)}';
    data['productOwner'] = _clientController.text;
    data['description'] = _descriptionController.text;
    var response = await http.put(
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
                            controller: _nameController,
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
                            controller: _clientController,
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
                                    '${_startDate.day}/${_startDate.month}/${_startDate.year}',
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(fontSize: 18.0)),
                              ),
                              ElevatedButton(
                                  onPressed: () async {
                                    DateTime? newDate = await showDatePicker(
                                      context: context,
                                      initialDate: _startDate,
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2100),
                                    );

                                    if (newDate == null) {
                                      return;
                                    }

                                    setState(() => _startDate = newDate);
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
                                    '${_deadlineDate.day}/${_deadlineDate.month}/${_deadlineDate.year}',
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(fontSize: 18.0)),
                              ),
                              ElevatedButton(
                                  onPressed: () async {
                                    DateTime? newDate = await showDatePicker(
                                      context: context,
                                      initialDate: _deadlineDate,
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2100),
                                    );

                                    if (newDate == null) {
                                      return;
                                    }

                                    setState(() => _deadlineDate = newDate);
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
                            controller: _descriptionController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Insira a descrição do projeto';
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
