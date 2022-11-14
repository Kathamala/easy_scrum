// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print
import 'package:easy_scrum/design/colors.dart';
import 'package:easy_scrum/components/BottomAppBar.dart';
import 'package:flutter/material.dart';

class Integrante {
  String nome;
  String cargo;

  Integrante(this.nome, this.cargo);
}

List<Integrante> getMembersFromId(int id) {
  List<Integrante> novaLista = [];
  novaLista.add(Integrante("Alex", "Scrum Master"));
  novaLista.add(Integrante("Antonio", "Colaborador"));
  novaLista.add(Integrante("Daniel", "Product Owner"));
  novaLista.add(Integrante("Davi", "Colaborador"));
  novaLista.add(Integrante("Tiago", "Colaborador"));

  return novaLista;
}

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
        PopupMenuItem<String>(
            child: const Text('Alterar Cargo'), value: 'Alterar Cargo'),
        PopupMenuItem<String>(child: const Text('Mensagem'), value: 'Mensagem'),
        PopupMenuItem<String>(child: const Text('Remover'), value: 'Remover'),
      ],
      elevation: 8.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Integrante> listaMembros = getMembersFromId(1);

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                      padding: const EdgeInsets.fromLTRB(8, 24, 8, 8),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Toque no ícone",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: AppColors.primaryPurple,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                            Icon(Icons.more_vert),
                            Text("para opções",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: AppColors.primaryPurple,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold))
                          ])),
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
                          title: Text(listaMembros[index].nome),
                          subtitle: Text(listaMembros[index].cargo),
                          trailing: GestureDetector(
                            onTapDown: (TapDownDetails details) {
                              _showPopupMenu(details.globalPosition);
                            },
                            child: Icon(Icons.more_vert),
                          ));
                    },
                  ),
                ]),
          ),
        ));
  }
}
