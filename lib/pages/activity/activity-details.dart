import 'package:easy_scrum/design/colors.dart';
import 'package:easy_scrum/components/TopAppBar.dart';
import 'package:easy_scrum/components/BottomAppBar.dart';
import 'package:easy_scrum/pages/activity/activity-edit.dart';
import 'package:flutter/material.dart';

import '../../models/info.dart';

class ActivityDetailsPage extends StatefulWidget {
  const ActivityDetailsPage ({Key? key}) : super(key: key);

  @override
  State<ActivityDetailsPage > createState() => _ActivityDetailsPageState();
}

class _ActivityDetailsPageState extends State<ActivityDetailsPage>{

  @override
  void initState() {
    super.initState();
  }
  final String _name = 'Atividade X';
  final String _team = 'Delta';
  final DateTime _startDate = DateTime.now();
  final String _deadline = '16';
  final String _description = 'Fazer X';

  List<Widget> _getActions() {
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.edit),
        tooltip: 'Editar atividade',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ActivityEditPage(),
            ),
          );
        }
      ),
    ];
  }

  Widget _getGeneralInformation() {
    List<Info> list = [
      Info('Nome', _name),
      Info('Time', _team),
      Info('Data de Início', '${_startDate.day}/${_startDate.month}/${_startDate.year}'),
      Info('Prazo', '$_deadline semanas'),
      Info('Descrição', '$_description'),
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
            ],
          ),
        ),
      ),
    );
  }
}