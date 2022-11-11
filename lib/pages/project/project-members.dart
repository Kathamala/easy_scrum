// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print
import 'package:easy_scrum/colors.dart';
import 'package:easy_scrum/components/BottomAppBar.dart';
//import 'package:easy_scrum/pages/project/project-details.dart';
import 'package:flutter/material.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class ProjectMembersPage extends StatefulWidget {
  const ProjectMembersPage({Key? key}) : super(key: key);

  @override
  State<ProjectMembersPage> createState() => _ProjectMembersPageState();
}

class _ProjectMembersPageState extends State<ProjectMembersPage> {
  @override
  void initState() {
    super.initState();
  }

  _showPopupMenu(Offset offset) async {
    double left = offset.dx;
    double top = offset.dy;
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(left, top, 0, 0),
      items: [
        PopupMenuItem<String>(child: const Text('Mensagem'), value: 'Mensagem'),
        PopupMenuItem<String>(child: const Text('Remover'), value: 'Remover'),
      ],
      elevation: 8.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<String> listaMembros = [
      "Alex",
      "Antonio",
      "Davi",
      "Daniel",
      "Tiago"
    ];

    final cardMembers = Card(
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 5, 30, 20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                  padding: const EdgeInsets.fromLTRB(8, 24, 8, 8),
                  child: Text("Para mais opções toque no ícone",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.primaryPurple,
                          fontSize: 14,
                          fontWeight: FontWeight.bold))),
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: listaMembros.length,
                itemBuilder: (context, index) {
                  return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: AppColors.primaryPurple,
                        child: Icon(Icons.person),
                      ),
                      title: Text(listaMembros[index]),
                      subtitle: Text('Cargo'),
                      trailing: GestureDetector(
                        onTapDown: (TapDownDetails details) {
                          _showPopupMenu(details.globalPosition);
                        },
                        child: Icon(Icons.more_vert),
                      )
                      /*trailing: Icon(Icons.more_vert),
                      enabled: true,
                      onTap: () {_showPopupMenu()}*/
                      );
                },
              ),
            ]),
      ),
    );

    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          title: const Text("Integrantes de projeto X",
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
                children: [cardMembers]),
          ),
        ));
  }
}
