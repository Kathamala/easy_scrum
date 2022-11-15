// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print
import 'package:easy_scrum/design/colors.dart';
import 'package:easy_scrum/components/TopAppBar.dart';
import 'package:easy_scrum/components/BottomAppBar.dart';
import 'package:easy_scrum/models/project_member.dart';
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
  final List<ProjectMember> _allMembers = [];
  List<ProjectMember> _members = [];

  //TextEditingController nomeController = TextEditingController();
  //TextEditingController clienteController = TextEditingController();

  // Feature to control deletion
  ProjectMember _lastRemoved = ProjectMember(-1, '', '', -1, '');
  int _lastRemovedPos = -1;

  // TO-DO: to integrate
  Future<void> _refresh() async {
    setState(() {
      _members = [..._allMembers];
    });
    await Future.delayed(const Duration(seconds: 1));
  }

  // TO-DO: to integrate
  Future<void> _addMember() async {
    _allMembers.add(ProjectMember(-1, 'Fulano', '', -1, 'Colaborador'));
    Navigator.pop(context);
    setState(() {
      _members = [..._allMembers];
    });
  }

  // TO-DO: to integrate
  Future<void> _remove(int index) async {
    setState(() {
      _lastRemoved = _members[index];
      _lastRemovedPos = index;
      _members.removeAt(index);
    });
  }

  // TO-DO: to integrate
  Future<void> _cancelRemove() async {
    setState(() {
      _members.insert(_lastRemovedPos, _lastRemoved);
    });
  }

  Widget _getItem(context, index) {
    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      background: Container(
        color: AppColors.error,
        child: Align(
          alignment: const Alignment(-0.9, 0.0),
          child: Icon(
            Icons.delete,
            color: AppColors.white,
          ),
        ),
      ),
      direction: DismissDirection.startToEnd,
      child: ListTile(
          leading: CircleAvatar(
            backgroundColor: AppColors.primaryPurple,
            child: const Icon(Icons.person),
          ),
          title: Text(_members[index].getName()),
          subtitle: Text(_members[index].getRole()),
          trailing: GestureDetector(
            onTapDown: (TapDownDetails details) {
              _showPopupMenu(details.globalPosition);
            },
            child: Icon(Icons.more_vert),
          )),
      onDismissed: (direction) {
        _remove(index);
        SnackBar snack = SnackBar(
          content: Text('Integrante ${_lastRemoved.getName()} removido'),
          action: SnackBarAction(label: 'Desfazer', onPressed: _cancelRemove),
          duration: const Duration(seconds: 5),
        );
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(snack);
      },
    );
  }

  Widget _getList() {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 10.0),
      itemCount: _members.length,
      itemBuilder: _getItem,
    );
  }

  Widget _getColumn() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 24, 8, 8),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
          ]),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: _refresh,
            child: _getList(),
          ),
        ),
      ],
    );
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
      ],
      elevation: 8.0,
    );
  }

  void _showAddDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Adicionar Integrante'),
          content: Text(
            'Deseja adicionar fulano ao projeto?',
            style: const TextStyle(fontSize: 14),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancelar"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text("Continuar"),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primaryPurple,
              ),
              onPressed: _addMember,
            )
          ],
        );
      },
    );
  }

  List<Widget> getActions() {
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.add),
        tooltip: 'Adicionar Participante',
        onPressed: _showAddDialog,
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    _allMembers.add(ProjectMember(1, 'Alex', '', 1, 'Scrum Master'));
    _allMembers.add(ProjectMember(2, 'Antonio', '', 2, 'Product Owner'));
    _members = [..._allMembers];
  }

  @override
  Widget build(BuildContext context) {
    List<Integrante> listaMembros = getMembersFromId(1);

    return Scaffold(
      appBar: TopAppBar(
        Key(DateTime.now().millisecondsSinceEpoch.toString()),
        "Integrantes do projeto",
        getActions(),
      ),
      bottomNavigationBar: BottomAppBarEasyScrum(),
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: _getColumn(),
      ),
    );
  }
}
