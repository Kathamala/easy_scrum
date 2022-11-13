// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print
import 'package:easy_scrum/design/colors.dart';
import 'package:easy_scrum/components/BottomAppBar.dart';
import 'package:easy_scrum/pages/meeting/meeting-list.dart';
//import 'package:easy_scrum/pages/login/login.dart';
import 'package:easy_scrum/pages/project/project-details.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //List<Project> projects = new List<Project>;
  //List<Project> meetings = new List<Meeting>;

  @override
  void initState() {
    super.initState();
    //load projects...
    //load meetings...
  }

  void openProject(int projectId) {
    print("Opening project " + projectId.toString());
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const ProjectDetailsPage()));
  }

  void openMeetings() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const MeetingListPage()));
  }

  @override
  Widget build(BuildContext context) {
    final cardProjetos = Card(
        elevation: 4.0,
        child: SizedBox(
          height: 320,
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
                        openProject(1);
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
                        openProject(1);
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
                        openProject(1);
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

    final cardReunioes = Card(
        elevation: 4.0,
        child: SizedBox(
          height: 320,
          width: double.infinity,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 24, 8, 8),
                  child: Text("Reuniões",
                      style: TextStyle(
                          color: AppColors.primaryPurple,
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                ),
                Column(
                  children: [
                    //reunions
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondaryGrey,
                          fixedSize: Size(270, 20)),
                      onPressed: () {},
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
                                child: Text("09:00",
                                    style: TextStyle(
                                        color: AppColors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Text("Easy Scrum",
                                    style: TextStyle(
                                        color: AppColors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold)),
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
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondaryGrey,
                          fixedSize: Size(270, 20)),
                      onPressed: () {},
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
                                child: Text("09:00",
                                    style: TextStyle(
                                        color: AppColors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Text("Projeto 0",
                                    style: TextStyle(
                                        color: AppColors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold)),
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
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondaryGrey,
                          fixedSize: Size(270, 20)),
                      onPressed: () {},
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
                                child: Text("09:00",
                                    style: TextStyle(
                                        color: AppColors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Text("Projeto teste",
                                    style: TextStyle(
                                        color: AppColors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold)),
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
                        openMeetings();
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
                  cardReunioes
                ]),
          ),
        ));
  }
}
