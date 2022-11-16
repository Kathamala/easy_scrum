import 'package:easy_scrum/design/colors.dart';
import 'package:easy_scrum/components/TopAppBar.dart';
import 'package:easy_scrum/components/BottomAppBar.dart';
import 'package:flutter/material.dart';

class ActivityDetailsPage extends StatefulWidget {
  const ActivityDetailsPage ({Key? key}) : super(key: key);

  @override
  State<ActivityDetailsPage > createState() => _ActivityDetailsPageState();
}

class _ActivityDetailsPageState extends State<ActivityDetailsPage>{

  Future<void> _logout() async {}

  @override
  void initState() {
    super.initState();
  }

  String equipe = "Delta";
  DateTime dataInicio = DateTime.now();
  String prazo = "1";
  String descricaoAtividade = "Fazer X";
  String quantidadeTimes = "6";

  // TO-DO: to integrate
  Future<void> _remove() async {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
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
  Widget build(BuildContext context) {
    final cardDadosAtividades = Card(
        elevation: 4.0,
        child: SizedBox(
          width: double.infinity,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 24, 8, 8),
                  child: Text("Dados da atividade",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: AppColors.primaryPurple,
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                ),
                Column(
                  children: [
                    Padding(padding: EdgeInsets.only(top: 25.0)),
                    Text("Equipe: $equipe",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 16.0)),
                    Padding(padding: EdgeInsets.only(top: 25.0)),
                    Text(
                        "Data de início: ${dataInicio.day}/${dataInicio.month}/${dataInicio.year}",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 16.0)),
                    Padding(padding: EdgeInsets.only(top: 25.0)),
                    Text("Prazo: $prazo semana",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 16.0)),
                    Padding(padding: EdgeInsets.only(top: 25.0)),
                    Text("Descrição da atividade: $descricaoAtividade",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 16.0)),
                    Padding(padding: EdgeInsets.only(top: 25.0)),
                  ],
                ),
              ]),
        ));



    return Scaffold(
        appBar: TopAppBar(
          Key(DateTime.now().millisecondsSinceEpoch.toString()),
          "Projeto X",
          _getActions(),
        ),
        bottomNavigationBar: BottomAppBarEasyScrum(),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(24, 24, 8, 8),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  cardDadosAtividades,
                  SizedBox(
                    height: 20,
                  )
                ]),
          ),
        ));
  }
}