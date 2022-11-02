// ignore: file_names
import 'package:easy_scrum/colors.dart';
import 'package:easy_scrum/pages/home.dart';
import 'package:easy_scrum/pages/project/project-creation.dart';
import 'package:flutter/material.dart';

class BottomAppBarEasyScrum extends StatelessWidget {
  const BottomAppBarEasyScrum({Key? key}) : super(key: key);

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                tooltip: 'Home',
                icon: Icon(
                  Icons.home_outlined,
                  color: AppColors.primaryPurple,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage()));
                },
              ),
              //if (centerLocations.contains(fabLocation)) const Spacer(),
              IconButton(
                tooltip: 'Search',
                icon: Icon(
                  Icons.search,
                  color: AppColors.primaryPurple,
                ),
                onPressed: () {},
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProjectCreationPage()));
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
                tooltip: 'Messages',
                icon: Icon(
                  Icons.chat_bubble_outline,
                  color: AppColors.primaryPurple,
                ),
                onPressed: () {},
              ),
              IconButton(
                tooltip: 'Profile',
                icon: Icon(
                  Icons.person,
                  color: AppColors.primaryPurple,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
