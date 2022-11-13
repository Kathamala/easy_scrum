// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:easy_scrum/components/BottomAppBar.dart';
import 'package:easy_scrum/components/TopAppBar.dart';
import 'package:easy_scrum/design/colors.dart';
import 'package:easy_scrum/models/category_meeting.dart';
import 'package:easy_scrum/models/meeting.dart';
import 'package:easy_scrum/models/person.dart';
import 'package:easy_scrum/models/project.dart';
import 'package:easy_scrum/pages/meeting/meeting-detalis.dart';

class MeetingListPage extends StatefulWidget {
  const MeetingListPage({Key? key}) : super(key: key);

  @override
  State<MeetingListPage> createState() => _MeetingListPageState();
}

class _MeetingListPageState extends State<MeetingListPage> {
  late final List<Meeting> _meetings = [
    Meeting(0, 'My Daily', 'https://meet.google.com/', '', DateTime.now(), Project(0, 'Scrum'), CategoryMeeting(0, 'DAILY'), [Person(0, 'Fulano')]),
    Meeting(1, 'My RG', 'https://meet.google.com/', '', DateTime.now(), Project(0, 'Scrum'), CategoryMeeting(1, 'RG'), [Person(0, 'Fulano')]),
  ];

  final TextEditingController _filterController = TextEditingController();

  // TO-DO
  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  // TO-DO
  Future<void> _filter(String value) async {}

  // TO-DO
  // ignore: unused_element
  Future<void> _remove(Meeting meeting) async {}

  void _openMeeting(Meeting meeting) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MeetingDetailsPage(
          Key(DateTime.now().millisecondsSinceEpoch.toString()),
          meeting,
        ),
      ),
    );
  }

  Widget getFilter() {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
      child: TextFormField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: "Procurar",
          labelStyle: TextStyle(
            color: AppColors.black,
          ),
        ),
        textAlign: TextAlign.left,
        style: TextStyle(
          color: AppColors.black,
          fontSize: 16.0,
        ),
        controller: _filterController,
        onChanged: _filter,
      ),
    );
  }

  Widget getItem(context, index) {
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
          child: const Icon(Icons.timer),
        ),
        title: Text(_meetings[index].getTitle()),
        subtitle: Text(_meetings[index].getLink()),
        onTap: () => _openMeeting(_meetings[index]),
      ),
      onDismissed: (direction) {
        SnackBar snack = SnackBar(
          content: Text('Reunião ${_meetings[index].getTitle()} removida'),
          action: SnackBarAction(label: 'Desfazer', onPressed: () {}),
          duration: const Duration(seconds: 5),
        );
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(snack);
      },
    );
  }

  Widget getList() {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 10.0),
      itemCount: _meetings.length,
      itemBuilder: getItem,
    );
  }

  Widget getColumn() {
    return Column(
      children: <Widget>[
        getFilter(),
        Expanded(
          child: RefreshIndicator(
            onRefresh: _refresh,
            child: getList(),
          ),
        ),
      ],
    );
  }

  List<Widget> getActions() {
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.add),
        tooltip: 'Adicionar Reunião',
        onPressed: () {
          // handle the press
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(null, 'Lista de Reuniões', getActions()),
      bottomNavigationBar: const BottomAppBarEasyScrum(),
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: getColumn(),
      ),
    );
  }
}
