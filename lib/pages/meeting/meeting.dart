import 'package:flutter/material.dart';
import 'package:easy_scrum/components/BottomAppBar.dart';
import 'package:easy_scrum/components/TopAppBar.dart';
import 'package:easy_scrum/models/meeting.dart';

class MeetingPage extends StatefulWidget {
  final Meeting? _meeting;

  const MeetingPage(Key key, this._meeting) : super(key: key);

  @override
  State<MeetingPage> createState() => _MeetingPageState();
}

class _MeetingPageState extends State<MeetingPage> {
  String _getTitle() {
    if (widget._meeting == null) {
      return 'Cadastrar Reunião';
    }
    return 'Alterar Reunião';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(
        Key(DateTime.now().millisecondsSinceEpoch.toString()),
        _getTitle(),
        List.empty(),
      ),
      bottomNavigationBar: const BottomAppBarEasyScrum(),
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Text(_getTitle()),
      ),
    );
  }
}
