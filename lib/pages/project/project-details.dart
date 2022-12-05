import 'package:http/http.dart' as http;
import 'package:easy_scrum/design/colors.dart';
import 'package:easy_scrum/components/TopAppBar.dart';
import 'package:easy_scrum/components/BottomAppBar.dart';
import 'package:easy_scrum/components/Error.dart';
import 'package:easy_scrum/models/company.dart';
import 'package:easy_scrum/models/info.dart';
import 'package:easy_scrum/models/person.dart';
import 'package:easy_scrum/models/product_backlog.dart';
import 'package:easy_scrum/models/product_owner.dart';
import 'package:easy_scrum/models/project.dart';
import 'package:easy_scrum/models/scrum_master.dart';
import 'package:easy_scrum/pages/meeting/meeting-list.dart';
import 'package:easy_scrum/pages/activity/project-activity.dart';
import 'package:easy_scrum/pages/project/project-edit.dart';
import 'package:easy_scrum/pages/project/project-members.dart';
import 'package:easy_scrum/service/project.dart';
import 'package:flutter/material.dart';

class ProjectDetailsPage extends StatefulWidget {
  final Project currentProject;
  const ProjectDetailsPage({Key? key, required this.currentProject})
      : super(key: key);

  @override
  State<ProjectDetailsPage> createState() => _ProjectDetailsPageState();
}

class _ProjectDetailsPageState extends State<ProjectDetailsPage> {
  String _projectName = '';
  String _clientName = '';
  DateTime _startDate = DateTime.now();
  String _deadline = '';
  String _description = '';
  String _amountTimes = '';

  @override
  void initState() {
    _projectName = widget.currentProject.getName();
    _clientName =
        widget.currentProject.getProductOwner().getPerson().getName() +
            ', ' +
            widget.currentProject.getProductOwner().getCompany().getName();
    _startDate = widget.currentProject.getStartDate();
    _deadline = widget.currentProject.getDeadline().toString();
    _description = widget.currentProject.getDescription();
    _amountTimes = widget.currentProject.getTeams().length.toString();

    super.initState();
  }

  Future<void> _remove() async {
    await Future.delayed(const Duration(seconds: 2));
    var response = await http
        .delete(ProjectService.deleteProject(widget.currentProject.getId()));
    if (response.statusCode == 200) {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    } else {
      ErrorHandling.getModalBottomSheet(context, response);
    }
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
          content: const Text(
            'Deseja mesmo excluir o projeto?',
            style: TextStyle(fontSize: 14),
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
              builder: (context) =>
                  ProjectEditPage(currentProject: widget.currentProject),
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
      Info('Data de Início',
          '${_startDate.day}/${_startDate.month}/${_startDate.year}'),
      Info('Prazo', _deadline),
      Info('Descrição', _description),
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
                      fixedSize: const Size(270, 20),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ProjectActivitiesPage()));
                    },
                    child: Row(children: [
                      const Icon(
                        Icons.list,
                        size: 28,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Text(
                          'Atividades',
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ]),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondaryGrey,
                      fixedSize: const Size(270, 20),
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
                        const Icon(
                          Icons.people,
                          size: 28,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Text(
                            'Integrantes',
                            style: TextStyle(
                              color: AppColors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondaryGrey,
                      fixedSize: const Size(270, 20),
                    ),
                    onPressed: () {
                      _openMeetings(
                        Project(
                          1,
                          'Easy Scrum',
                          DateTime.now(),
                          DateTime.now(),
                          '',
                          ProductOwner(
                            1,
                            Person(1, '', '', '', '', ''),
                            Company(1, '', ''),
                          ),
                          ScrumMaster(
                            1,
                            Person(1, '', '', '', '', ''),
                          ),
                          ProductBacklog(1, {}),
                          {},
                          '',
                          '',
                        ),
                      );
                    },
                    child: Row(children: [
                      const Icon(
                        Icons.video_call_outlined,
                        size: 28,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Text(
                          'Reuniões',
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
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
        _projectName,
        _getActions(),
      ),
      bottomNavigationBar: const BottomAppBarEasyScrum(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              _getGeneralInformation(),
              const SizedBox(
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
