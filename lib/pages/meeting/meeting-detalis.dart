// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_scrum/components/BottomAppBar.dart';
import 'package:easy_scrum/components/TopAppBar.dart';
import 'package:easy_scrum/design/colors.dart';
import 'package:easy_scrum/models/info.dart';
import 'package:easy_scrum/models/meeting.dart';
import 'package:easy_scrum/pages/meeting/meeting.dart';
import 'package:easy_scrum/service/meeting.dart';
import 'package:easy_scrum/utils/date.dart';

class MeetingDetailsPage extends StatefulWidget {
  final Meeting _meeting;

  const MeetingDetailsPage(Key key, this._meeting) : super(key: key);

  @override
  State<MeetingDetailsPage> createState() => _MeetingDetailsPageState();
}

class _MeetingDetailsPageState extends State<MeetingDetailsPage> {
  Future<void> _openLink(String link) async {
    Uri url = Uri.parse(link);
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }

  Future<void> _remove() async {
    var response = await http.delete(MeetingService.deleteMeeting(widget._meeting.getId()));
    if (response.statusCode == 200) {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    }
  }

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alerta'),
          content: Text(
            'Deseja mesmo excluir a reunião ${widget._meeting.getTitle()}?',
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
        icon: const Icon(Icons.link),
        tooltip: 'Ir para Reunião',
        onPressed: () {
          _openLink(widget._meeting.getLink());
        },
      ),
      IconButton(
        icon: const Icon(Icons.edit),
        tooltip: 'Editar Reunião',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MeetingPage(
                Key(DateTime.now().millisecondsSinceEpoch.toString()),
                widget._meeting,
              ),
            ),
          );
        },
      ),
      IconButton(
        icon: const Icon(Icons.delete),
        tooltip: 'Excluir Reunião',
        onPressed: _showDeleteDialog,
      ),
    ];
  }

  Widget _getIcon() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
      child: IconButton(
        icon: const Icon(Icons.timer),
        iconSize: 100,
        color: AppColors.primaryPurple,
        tooltip: 'Ir para Reunião',
        onPressed: () {
          _openLink(widget._meeting.getLink());
        },
      ),
    );
  }

  Widget _getGeneralInformation() {
    List<Info> list = [
      Info('Link', widget._meeting.getLink()),
      Info('Data/Hora', Datetime.formatDatetime(widget._meeting.getDatetime())),
      Info('Categoria', widget._meeting.getCategory()),
      Info('Projeto', widget._meeting.getProject().getName()),
      Info('Descrição', widget._meeting.getDescription())
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

  Widget _getParticipants() {
    return Card(
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Text(
                'Convidados',
                style: TextStyle(
                  color: AppColors.primaryPurple,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              for (var item in widget._meeting.getPeople())
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                  child: Row(
                    children: [
                      const Icon(Icons.person),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                        child: Text(
                          '${item.getName()} (${item.getEmail()})',
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
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

  Widget _getColumn() {
    return Column(
      children: [
        _getIcon(),
        _getGeneralInformation(),
        _getParticipants(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(
        Key(DateTime.now().millisecondsSinceEpoch.toString()),
        widget._meeting.getCategory(),
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
