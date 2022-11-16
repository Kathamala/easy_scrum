// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print
import 'package:easy_scrum/design/colors.dart';
import 'package:easy_scrum/components/TopAppBar.dart';
import 'package:easy_scrum/components/BottomAppBar.dart';
import 'package:easy_scrum/models/project.dart';
import 'package:easy_scrum/pages/meeting/meeting-list.dart';
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

  String clientName = "cliente";
  DateTime dataInicio = DateTime.now();
  String prazo = "16";
  String duracaoSprint = "7";
  String quantidadeTimes = "6";

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
              child: const Text("Cancelar"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text("Continuar"),
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

  List<Widget> getActions() {
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

  @override
  Widget build(BuildContext context) {
    final cardDadosProjeto = Card(
        elevation: 4.0,
        child: SizedBox(
          width: double.infinity,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 24, 8, 8),
                  child: Text("Dados do projeto",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: AppColors.primaryPurple,
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                ),
                Column(
                  children: [
                    Padding(padding: EdgeInsets.only(top: 15.0)),
                    Text("Cliente: $clientName",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 16.0)),
                    Padding(padding: EdgeInsets.only(top: 15.0)),
                    Text(
                        "DataInicio: ${dataInicio.day}/${dataInicio.month}/${dataInicio.year}",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 16.0)),
                    Padding(padding: EdgeInsets.only(top: 15.0)),
                    Text("Prazo: $prazo semanas",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 16.0)),
                    Padding(padding: EdgeInsets.only(top: 15.0)),
                    Text("Duração do sprint: $duracaoSprint dias",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 16.0)),
                    Padding(padding: EdgeInsets.only(top: 15.0)),
                    Text("Quantidade de times: $quantidadeTimes times",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 16.0)),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
                    )
                  ],
                ),
              ]),
        ));

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
                      child: Text("Consultar",
                          style: TextStyle(
                              color: AppColors.primaryPurple,
                              fontSize: 14,
                              fontWeight: FontWeight.bold)),
                    ),
                    Column(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.secondaryGrey,
                              fixedSize: Size(242, 20)),
                          onPressed: () {
                            /*Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ProjectActivitiesPage()));*/
                          },
                          child: Row(children: [
                            Icon(
                              Icons.list,
                              size: 28,
                            ),
                            Text("            Atividades",
                                //textAlign: TextAlign.right,
                                style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold))
                          ]),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.secondaryGrey,
                              fixedSize: Size(242, 20)),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ProjectMembersPage()));
                          },
                          child: Row(children: [
                            Icon(
                              Icons.people,
                              size: 28,
                            ),
                            Text("           Integrantes",
                                //textAlign: TextAlign.right,
                                style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold))
                          ]),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.secondaryGrey,
                              fixedSize: Size(242, 20)),
                          onPressed: () {
                            _openMeetings(Project(1, 'Easy Scrum'));
                          },
                          child: Row(children: [
                            Icon(
                              Icons.video_call_outlined,
                              size: 28,
                            ),
                            Text("             Reuniões",
                                //textAlign: TextAlign.right,
                                style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold))
                          ]),
                        ),
                      ],
                    ),
                  ]),
            )));

    return Scaffold(
        appBar: TopAppBar(
          Key(DateTime.now().millisecondsSinceEpoch.toString()),
          "Projeto X",
          getActions(),
        ),
        bottomNavigationBar: BottomAppBarEasyScrum(),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(24, 24, 8, 8),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  cardDadosProjeto,
                  SizedBox(
                    height: 20,
                  ),
                  cardConsultar
                ]),
          ),
        ));
  }
}
