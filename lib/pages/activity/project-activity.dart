import 'package:easy_scrum/pages/activity/activity-creation.dart';
import 'package:easy_scrum/pages/activity/activity-details.dart';
import 'package:flutter/material.dart';
import 'package:easy_scrum/design/colors.dart';
import 'package:easy_scrum/components/BottomAppBar.dart';
import 'package:easy_scrum/components/TopAppBar.dart';
import 'package:easy_scrum/models/activity.dart';

class ProjectActivitiesPage extends StatefulWidget {
  const ProjectActivitiesPage({Key? key}) : super(key: key);

  @override
  State<ProjectActivitiesPage> createState() => _ProjectActivitiesPageState();
}

class _ProjectActivitiesPageState extends State<ProjectActivitiesPage> {
  final List<Activity> _activities = [];


  Widget _getActivities() {
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
                  'Atividades',
                  style: TextStyle(
                    color: AppColors.primaryPurple,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(8, 12, 8, 8),
              ),
              Column(
                children: [
                  for (var item in _activities)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondaryGrey,
                        fixedSize: const Size(270, 20),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ActivityDetailsPage(),
                          ),
                        );
                        //print("Detalhes da atividade : " + item.getDescription());
                      },
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          item.getDescription(),
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
                padding: EdgeInsets.fromLTRB(8, 12, 8, 10),
              ),
            ]),

      ),
    );
  }


  List<Widget> _getActions() {
    return [
      IconButton(
        onPressed: (){
          Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ActivityCreationPage(),
            ),
          );
        },
        icon: const Icon(Icons.add))
    ];
  }

  @override
  void initState() {
    super.initState();
    _activities.add(
      Activity(1, 'Elaborar modelo EER'),
    );
    _activities.add(
      Activity(2, 'Definir arquitetura da API'),
    );
    _activities.add(
      Activity(3, 'Criar estrutura da API'),
    );
    _activities.add(
      Activity(4, 'Documentar problema e solução'),
    );
    _activities.add(
      Activity(5, 'Prototipar telas'),
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(
        Key(DateTime.now().millisecondsSinceEpoch.toString()),
        "Projeto X",
        _getActions(),
      ),
      bottomNavigationBar: const BottomAppBarEasyScrum(
        currentScreen: "project-activity",
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _getActivities(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}