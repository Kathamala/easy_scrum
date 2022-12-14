// ignore_for_file: file_names
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:easy_scrum/service/meeting.dart';
import 'package:easy_scrum/components/BottomAppBar.dart';
import 'package:easy_scrum/components/Error.dart';
import 'package:easy_scrum/components/TopAppBar.dart';
import 'package:easy_scrum/design/colors.dart';
import 'package:easy_scrum/helpers/person.dart';
import 'package:easy_scrum/models/meeting.dart';
import 'package:easy_scrum/models/project.dart';
import 'package:easy_scrum/pages/meeting/meeting.dart';
import 'package:easy_scrum/pages/meeting/meeting-detalis.dart';

class MeetingListPage extends StatefulWidget {
  final Project? _project;

  const MeetingListPage(Key key, this._project) : super(key: key);

  @override
  State<MeetingListPage> createState() => _MeetingListPageState();
}

class _MeetingListPageState extends State<MeetingListPage> {
  final PersonHelper _helper = PersonHelper();

  List<Meeting> _allMeetings = [];
  List<Meeting> _meetings = [];

  // Feature to control deletion
  Meeting? _lastRemoved;
  int? _lastRemovedPos;

  final TextEditingController _filterController = TextEditingController();

  Future<void> _findAll(int limit, int page) async {
    Uri uri;
    if (widget._project == null) {
      uri = MeetingService.getMeetingsByPerson(await _helper.getPerson(), limit, page);
    } else {
      uri = MeetingService.getMeetingsByProjetc(await _helper.getPerson(), widget._project!.getId(), limit, page);
    }
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      setState(() {
        _allMeetings =
            List<Meeting>.from(list.map((model) => Meeting.fromJson(model)));
        _meetings = [..._allMeetings];
      });
    } else {
      ErrorHandling.getModalBottomSheet(context, response);
    }
  }

  Future<void> _refresh() async {
    setState(() {
      _filterController.text = '';
    });
    await _findAll(10, 0);
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<void> _filter(String value) async {
    setState(() {
      _meetings = _allMeetings
          .where((item) => item.getTitle().contains(value))
          .toList();
    });
  }

  Future<void> _remove(int index) async {
    setState(() {
      _lastRemoved = _meetings[index];
      _lastRemovedPos = index;
      _meetings.removeAt(index);
    });
    await Future.delayed(const Duration(seconds: 4));
    if (_lastRemoved != null) {
      var response = await http.delete(MeetingService.deleteMeeting(_lastRemoved!.getId()));
      if (response.statusCode == 200) {
        setState(() {
          _lastRemoved = null;
          _lastRemovedPos = -1;
        });
      } else {
        ErrorHandling.getModalBottomSheet(context, response);
      }
    }
  }

  Future<void> _cancelRemove() async {
    setState(() {
      _meetings.insert(_lastRemovedPos!, _lastRemoved!);
      _lastRemoved = null;
      _lastRemovedPos = -1;
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
    ).then((_) => _refresh());
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
    ).then((_) => _refresh());
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
          content: Text('Reuni??o ${_lastRemoved!.getTitle()} removida'),
          action: SnackBarAction(label: 'Desfazer', onPressed: _cancelRemove),
          duration: const Duration(seconds: 3),
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
        tooltip: 'Adicionar Reuni??o',
        onPressed: () => _openMeeting(),
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    _findAll(10, 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(
        Key(DateTime.now().millisecondsSinceEpoch.toString()),
        'Lista de Reuni??es',
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
