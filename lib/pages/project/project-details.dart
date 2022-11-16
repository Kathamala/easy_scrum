// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print
import 'package:easy_scrum/design/colors.dart';
import 'package:easy_scrum/components/TopAppBar.dart';
import 'package:easy_scrum/components/BottomAppBar.dart';
import 'package:easy_scrum/models/info.dart';
import 'package:easy_scrum/models/project.dart';
import 'package:easy_scrum/pages/meeting/meeting-list.dart';
import 'package:easy_scrum/pages/project/project-activity.dart';
import 'package:easy_scrum/pages/project/project-edit.dart';
import 'package:easy_scrum/pages/project/project-members.dart';
import 'package:flutter/material.dart';

class ProjectDetailsPage extends StatefulWidget {
  const ProjectDetailsPage({Key? key}) : super(key: key);

  @override
  State<ProjectDetailsPage> createState() => _ProjectDetailsPageState();
}

class _ProjectDetailsPageState extends State<ProjectDetailsPage> {
  @override
  void initState() {
    super.initState();
  }

  final String _clientName = 'cliente';
  final DateTime _startDate = DateTime.now();
  final String _deadline = '16';
  final String _sprintDuration = '7';
  final String _amountTimes = '6';

  // TO-DO: to integrate
  Future<void> _remove() async {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  void _openMeetings(Project project) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MeetingListPage(
          Key(DateTime.now().millisecondsSinceEpoch.toString()),
          project,
        ),
      ),
    );
  }

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alerta'),
          content: Text(
            'Deseja mesmo excluir o projeto?',
            style: const TextStyle(fontSize: 14),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Continuar'),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primaryPurple,
              ),
              onPressed: _remove,
            )
          ],
        );
      },
    );
  }

  List<Widget> _getActions() {
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.edit),
        tooltip: 'Editar Projeto',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProjectEditPage(),
            ),
          );
        },
      ),
      IconButton(
        icon: const Icon(Icons.delete),
        tooltip: 'Excluir Projeto',
        onPressed: _showDeleteDialog,
      ),
    ];
  }

  Widget _getGeneralInformation() {
    List<Info> list = [
      Info('Cliente', _clientName),
      Info('Data de Início', '${_startDate.day}/${_startDate.month}/${_startDate.year}'),
      Info('Prazo', '$_deadline semanas'),
      Info('Duração do sprint', '$_sprintDuration dias'),
      Info('Quantidade de times', '$_amountTimes times'),
    ];

    return Card(
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Text(
                "Informações Gerais",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.primaryPurple,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              for (var item in list)
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                  child: Row(
                    children: [
                      Text(
                        '${item.getProperty()}: ',
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        item.getValue(),
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cardConsultar = Card(
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 5, 30, 20),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 24, 8, 8),
                child: Text(
                  'Consultar',
                  style: TextStyle(
                    color: AppColors.primaryPurple,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondaryGrey,
                      fixedSize: Size(242, 20),
                    ),
                    onPressed: () {
                      Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ProjectActivitiesPage()));
                    },
                    child: Row(children: [
                      Icon(
                        Icons.list,
                        size: 28,
                      ),
                      Text(
                        'Atividades',
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ]),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondaryGrey,
                      fixedSize: Size(242, 20),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProjectMembersPage(),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.people,
                          size: 28,
                        ),
                        Text(
                          'Integrantes',
                          //textAlign: TextAlign.right,
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondaryGrey,
                      fixedSize: Size(242, 20),
                    ),
                    onPressed: () {
                      _openMeetings(Project(1, 'Easy Scrum'));
                    },
                    child: Row(children: [
                      Icon(
                        Icons.video_call_outlined,
                        size: 28,
                      ),
                      Text(
                        'Reuniões',
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ]),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: TopAppBar(
        Key(DateTime.now().millisecondsSinceEpoch.toString()),
        'Projeto X',
        _getActions(),
      ),
      bottomNavigationBar: BottomAppBarEasyScrum(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              _getGeneralInformation(),
              SizedBox(
                height: 20,
              ),
              cardConsultar
            ],
          ),
        ),
      ),
    );
  }
}
