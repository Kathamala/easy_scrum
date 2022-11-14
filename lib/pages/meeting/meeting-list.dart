// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:easy_scrum/components/BottomAppBar.dart';
import 'package:easy_scrum/components/TopAppBar.dart';
import 'package:easy_scrum/design/colors.dart';
import 'package:easy_scrum/models/category_meeting.dart';
import 'package:easy_scrum/models/meeting.dart';
import 'package:easy_scrum/models/person.dart';
import 'package:easy_scrum/models/project.dart';
import 'package:easy_scrum/pages/meeting/meeting.dart';
import 'package:easy_scrum/pages/meeting/meeting-detalis.dart';

class MeetingListPage extends StatefulWidget {
  const MeetingListPage({Key? key}) : super(key: key);

  @override
  State<MeetingListPage> createState() => _MeetingListPageState();
}

class _MeetingListPageState extends State<MeetingListPage> {
  final List<Meeting> _allMeetings = [];
  List<Meeting> _meetings = [];

  // Feature to control deletion
  Meeting _lastRemoved = Meeting(-1, '', '', '', DateTime.now(), Project(-1, ''), CategoryMeeting(-1, ''), []);
  int _lastRemovedPos = -1;

  final TextEditingController _filterController = TextEditingController();

  // TO-DO: to integrate
  Future<void> _refresh() async {
    setState(() {
      _filterController.text = '';
      _meetings = [..._allMeetings];
    });
    await Future.delayed(const Duration(seconds: 1));
  }

  // TO-DO: to integrate
  Future<void> _filter(String value) async {
    setState(() {
      _meetings = _allMeetings.where((item) => item.getTitle().contains(value)).toList();
    });
  }

  // TO-DO: to integrate
  Future<void> _remove(int index) async {
    setState(() {
      _lastRemoved = _meetings[index];
      _lastRemovedPos = index;
      _meetings.removeAt(index);
    });
  }

  // TO-DO: to integrate
  Future<void> _cancelRemove() async {
    setState(() {
      _meetings.insert(_lastRemovedPos, _lastRemoved);
    });
  }

  void _openMeeting() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MeetingPage(
          Key(DateTime.now().millisecondsSinceEpoch.toString()),
          null,
        ),
      ),
    );
  }

  void _openMeetingDetails(Meeting meeting) {
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

  Widget _getFilter() {
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
          child: const Icon(Icons.timer),
        ),
        title: Text(_meetings[index].getTitle()),
        subtitle: Text(_meetings[index].getLink()),
        onTap: () => _openMeetingDetails(_meetings[index]),
      ),
      onDismissed: (direction) {
        _remove(index);
        SnackBar snack = SnackBar(
          content: Text('Reunião ${_lastRemoved.getTitle()} removida'),
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
      itemCount: _meetings.length,
      itemBuilder: _getItem,
    );
  }

  Widget _getColumn() {
    return Column(
      children: <Widget>[
        _getFilter(),
        Expanded(
          child: RefreshIndicator(
            onRefresh: _refresh,
            child: _getList(),
          ),
        ),
      ],
    );
  }

  List<Widget> _getActions() {
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.add),
        tooltip: 'Adicionar Reunião',
        onPressed: () => _openMeeting(),
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    _allMeetings.add(Meeting(0, 'My Daily', 'https://meet.google.com/', 'Alguma descrição feita', DateTime.now(), Project(1, 'Easy Scrum'), CategoryMeeting(1, 'Daily'), [Person(0, 'Fulano de Tal', '')]));
    _allMeetings.add(Meeting(1, 'My Stand-up', 'https://meet.google.com/', 'Alguma descrição feita', DateTime.now(), Project(1, 'Easy Scrum'), CategoryMeeting(2, 'Stand-up'), [Person(0, 'Fulano de Tal', '')]));
    _meetings = [..._allMeetings];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(
        Key(DateTime.now().millisecondsSinceEpoch.toString()),
        'Lista de Reuniões',
        _getActions(),
      ),
      bottomNavigationBar: const BottomAppBarEasyScrum(),
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: _getColumn(),
      ),
    );
  }
}
