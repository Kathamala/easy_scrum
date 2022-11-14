// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_scrum/components/BottomAppBar.dart';
import 'package:easy_scrum/design/colors.dart';
import 'package:easy_scrum/models/category_meeting.dart';
import 'package:easy_scrum/models/meeting.dart';
import 'package:easy_scrum/models/person.dart';
import 'package:easy_scrum/models/project.dart';
import 'package:easy_scrum/pages/meeting/meeting-list.dart';
import 'package:easy_scrum/pages/project/project-details.dart';
import 'package:easy_scrum/utils/date.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //List<Project> projects = new List<Project>;
  final List<Meeting> _meetings = [];

  void _openProject(int projectId) {
    print("Opening project " + projectId.toString());
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const ProjectDetailsPage()));
  }

  void _openMeetings() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const MeetingListPage()));
  }

  Future<void> _openLink(String link) async {
    Uri url = Uri.parse(link);
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    //load projects...
    _meetings.add(Meeting(
        0,
        'My Daily',
        'https://meet.google.com/',
        'Alguma descrição feita',
        DateTime.now(),
        Project(1, 'Easy Scrum'),
        CategoryMeeting(1, 'Daily'),
        [Person(0, 'Fulano de Tal', '')]));
    _meetings.add(Meeting(
        1,
        'My Stand-up',
        'https://meet.google.com/',
        'Alguma descrição feita',
        DateTime.now(),
        Project(1, 'Easy Scrum'),
        CategoryMeeting(2, 'Stand-up'),
        [Person(0, 'Fulano de Tal', '')]));
  }

  @override
  Widget build(BuildContext context) {
    final cardProjetos = Card(
        elevation: 4.0,
        child: SizedBox(
          width: double.infinity,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 24, 8, 8),
                  child: Text("Projetos",
                      style: TextStyle(
                          color: AppColors.primaryPurple,
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                ),
                Column(
                  children: [
                    //projects
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondaryGrey,
                          fixedSize: Size(270, 20)),
                      onPressed: () {
                        _openProject(1);
                      },
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Easy Scrum",
                            style: TextStyle(
                                color: AppColors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondaryGrey,
                          fixedSize: Size(270, 20)),
                      onPressed: () {
                        _openProject(1);
                      },
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Projeto 0",
                            style: TextStyle(
                                color: AppColors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondaryGrey,
                          fixedSize: Size(270, 20)),
                      onPressed: () {
                        _openProject(1);
                      },
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Projeto teste",
                            style: TextStyle(
                                color: AppColors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 24, 8, 10),
                  child: TextButton(
                      child: Text("ver mais...",
                          style: TextStyle(
                              color: AppColors.primaryPurple,
                              fontSize: 11,
                              fontWeight: FontWeight.bold)),
                      onPressed: () {}),
                ),
              ]),
        ));

    final meetingCard = Card(
        elevation: 4.0,
        child: SizedBox(
          width: double.infinity,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 24, 8, 8),
                  child: Text(
                    "Reuniões de Hoje",
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
                          fixedSize: Size(270, 20),
                        ),
                        onPressed: () {
                          _openLink(item.getLink());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
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
                                    item.getName(),
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
                      child: Text("ver mais...",
                          style: TextStyle(
                              color: AppColors.primaryPurple,
                              fontSize: 11,
                              fontWeight: FontWeight.bold)),
                      onPressed: () {
                        _openMeetings();
                      }),
                ),
              ]),
        ));

    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          title: const Text("Home",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        bottomNavigationBar: BottomAppBarEasyScrum(),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  cardProjetos,
                  SizedBox(
                    height: 20,
                  ),
                  meetingCard,
                ]),
          ),
        ));
  }
}
