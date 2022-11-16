// ignore: file_names
import 'package:easy_scrum/design/colors.dart';
import 'package:easy_scrum/pages/home.dart';
import 'package:easy_scrum/pages/project/project-creation.dart';
import 'package:flutter/material.dart';

import '../pages/profile/profile.dart';

class BottomAppBarEasyScrum extends StatelessWidget {
  final String? currentScreen;
  const BottomAppBarEasyScrum({Key? key, this.currentScreen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      elevation: 4.0,
      color: AppColors.white,
      child: IconTheme(
        data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 8.0, right: 8.0, top: 10, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                tooltip: 'Home',
                icon: Icon(
                  Icons.home_outlined,
                  color: AppColors.primaryPurple,
                ),
                onPressed: () {
                  if (currentScreen != "home") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()));
                  }
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (currentScreen != "project-creation") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProjectCreationPage()));
                  }
                },
                child: Icon(
                  Icons.add,
                  color: AppColors.white,
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryPurple,
                    shape: const StadiumBorder()),
              ),
              IconButton(
                tooltip: 'Profile',
                icon: Icon(
                  Icons.person,
                  color: AppColors.primaryPurple,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfilePage()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
