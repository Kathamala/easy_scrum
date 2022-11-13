// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_scrum/components/BottomAppBar.dart';
import 'package:easy_scrum/components/TopAppBar.dart';
import 'package:easy_scrum/models/meeting.dart';

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

  List<Widget> getActions() {
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.edit),
        tooltip: 'Editar Reunião',
        onPressed: () {
          // handle the press
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(
        Key(DateTime.now().millisecondsSinceEpoch.toString()),
        widget._meeting.getName(),
        getActions(),
      ),
      bottomNavigationBar: const BottomAppBarEasyScrum(),
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Text(widget._meeting.getTitle()),
      ),
    );
  }
}
