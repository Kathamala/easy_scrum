import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_scrum/components/BottomAppBar.dart';
import 'package:easy_scrum/components/Error.dart';
import 'package:easy_scrum/design/colors.dart';
import 'package:easy_scrum/models/company.dart';
import 'package:easy_scrum/models/meeting.dart';
import 'package:easy_scrum/models/person.dart';
import 'package:easy_scrum/models/product_backlog.dart';
import 'package:easy_scrum/models/product_owner.dart';
import 'package:easy_scrum/models/project.dart';
import 'package:easy_scrum/models/scrum_master.dart';
import 'package:easy_scrum/helpers/person.dart';
import 'package:easy_scrum/pages/meeting/meeting-list.dart';
import 'package:easy_scrum/pages/project/project-details.dart';
import 'package:easy_scrum/service/meeting.dart';
import 'package:easy_scrum/utils/date.dart';

class HomePage extends StatefulWidget {
  final Person? loggedUser;
  const HomePage({Key? key, this.loggedUser}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PersonHelper _helper = PersonHelper();
  final List<Project> _projects = [];
  List<Meeting> _meetings = [];

  Future<void> _findMeetings() async {
    var response = await http.get(MeetingService.getMeetingsToday(await _helper.getPerson()));
    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      setState(() {
        _meetings =
            List<Meeting>.from(list.map((model) => Meeting.fromJson(model)));
      });
    } else {
      ErrorHandling.getModalBottomSheet(context, response);
    }
  }

  void _openProject(Project project) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const ProjectDetailsPage()));
  }

  void _openMeetings() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MeetingListPage(
          Key(DateTime.now().millisecondsSinceEpoch.toString()),
          null,
        ),
      ),
    ).then((value) => _findMeetings());
  }

  // TO-DO: to integrate
  Future<void> _logout() async {
    _helper.deletePerson(widget.loggedUser!.getId());
    Navigator.of(context).pop();
  }

  Future<void> _openLink(String link) async {
    Uri url = Uri.parse(link);
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }

  Widget _getProjects() {
    return Card(
      elevation: 4.0,
      child: SizedBox(
        width: double.infinity,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 24, 8, 8),
                child: Text(
                  'Projetos',
                  style: TextStyle(
                    color: AppColors.primaryPurple,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Column(
                children: [
                  for (var item in _projects)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondaryGrey,
                        fixedSize: const Size(270, 20),
                      ),
                      onPressed: () {
                        _openProject(item);
                      },
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          item.getName(),
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(8, 24, 8, 10),
              ),
            ]),
      ),
    );
  }

  Widget _getMeetings() {
    return Card(
      elevation: 4.0,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 24, 8, 8),
              child: Text(
                'Reuniões de Hoje',
                style: TextStyle(
                  color: AppColors.primaryPurple,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Column(
              children: [
                for (var item in _meetings)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondaryGrey,
                      fixedSize: const Size(270, 20),
                    ),
                    onPressed: () {
                      _openLink(item.getLink());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.timer,
                              size: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                Datetime.getTime(item.getDatetime()),
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Text(
                                item.getCategory(),
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.video_call_outlined,
                              color: AppColors.primaryPurple,
                              size: 22,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 24, 8, 10),
              child: TextButton(
                child: Text(
                  'ver mais...',
                  style: TextStyle(
                    color: AppColors.primaryPurple,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  _openMeetings();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _getActions() {
    return [
      IconButton(
        icon: const Icon(Icons.logout),
        tooltip: 'Sair',
        onPressed: _logout,
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    _projects.add(
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

    _findMeetings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'Bem vindo!',
          style: TextStyle(
            color: AppColors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: _getActions(),
      ),
      bottomNavigationBar: const BottomAppBarEasyScrum(
        currentScreen: "home",
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _getProjects(),
              const SizedBox(height: 20),
              _getMeetings(),
            ],
          ),
        ),
      ),
    );
  }
}
