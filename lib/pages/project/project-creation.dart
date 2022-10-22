// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print
import 'package:easy_scrum/colors.dart';
import 'package:easy_scrum/components/BottomAppBar.dart';
//import 'package:easy_scrum/pages/home.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProjectCreationPage extends StatefulWidget {
  const ProjectCreationPage({Key? key}) : super(key: key);

  @override
  State<ProjectCreationPage> createState() => _ProjectCreationPageState();
}

class _ProjectCreationPageState extends State<ProjectCreationPage> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController clienteController = TextEditingController();
  TextEditingController dataController = TextEditingController();
  TextEditingController prazoController = TextEditingController();
  TextEditingController duracaoSprintController = TextEditingController();
  TextEditingController quantidadeTimesController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  void _createProject() {
    print("Nome: " + nomeController.text + "\n");
    print("Cliente: " + clienteController.text + "\n");
    print("Data de início: " + dataController.text + "\n");
    print("Prazo: " + prazoController.text + "\n");
    print("Duração do sprint: " + duracaoSprintController.text + "\n");
    print("Quantidade de times: " + quantidadeTimesController.text + "\n");
    _resetCampos();
  }

  void _resetCampos() {
    nomeController = TextEditingController();
    clienteController = TextEditingController();
    dataController = TextEditingController();
    prazoController = TextEditingController();
    duracaoSprintController = TextEditingController();
    quantidadeTimesController = TextEditingController();
    formKey.currentState!.reset();
  }

  @override
  Widget build(BuildContext context) {
    final cardCriacaoProjeto = Card(
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 5, 30, 20),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    labelText: "Nome",
                    labelStyle: TextStyle(color: Colors.black)),
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.black, fontSize: 16.0),
                controller: nomeController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Insira o nome do projeto";
                  } else {
                    return null;
                  }
                },
              ),
              Padding(padding: EdgeInsets.only(top: 10.0)),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    labelText: "Cliente",
                    labelStyle: TextStyle(color: Colors.black)),
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.black, fontSize: 16.0),
                controller: clienteController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Insira o cliente do projeto";
                  } else {
                    return null;
                  }
                },
              ),
              Padding(padding: EdgeInsets.only(top: 10.0)),
              TextFormField(
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                    labelText: "Data de início",
                    labelStyle: TextStyle(color: Colors.black)),
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.black, fontSize: 16.0),
                controller: dataController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Insira a data de início do projeto";
                  } else {
                    return null;
                  }
                },
              ),
              Padding(padding: EdgeInsets.only(top: 10.0)),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Prazo (em semanas)",
                    labelStyle: TextStyle(color: Colors.black)),
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.black, fontSize: 16.0),
                controller: prazoController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Insira o prazo do projeto";
                  } else {
                    return null;
                  }
                },
              ),
              Padding(padding: EdgeInsets.only(top: 10.0)),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Duração do sprint (em dias)",
                    labelStyle: TextStyle(color: Colors.black)),
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.black, fontSize: 16.0),
                controller: duracaoSprintController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Insira a duração do sprint do projeto";
                  } else {
                    return null;
                  }
                },
              ),
              Padding(padding: EdgeInsets.only(top: 10.0)),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Quantidade de times",
                    labelStyle: TextStyle(color: Colors.black)),
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.black, fontSize: 16.0),
                controller: quantidadeTimesController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Insira a quantidade de times do projeto";
                  } else {
                    return null;
                  }
                },
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(20, 30, 15, 10),
                  child: SizedBox(
                      height: 50.0,
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            _createProject();
                          }
                        },
                        child: Text(
                          "Criar projeto",
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryPurple,
                            textStyle: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold)),
                      ))),
            ],
          ),
        ),
      ),
    );

    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          title: const Text("Criação de projeto",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        bottomNavigationBar: BottomAppBarEasyScrum(),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  cardCriacaoProjeto,
                  SizedBox(
                    height: 20,
                  ),
                ]),
          ),
        ));
  }
}
