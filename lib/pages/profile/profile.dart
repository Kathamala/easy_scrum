import 'package:flutter/material.dart';
import 'package:easy_scrum/design/colors.dart';
import 'package:easy_scrum/components/BottomAppBar.dart';
import 'package:easy_scrum/components/TopAppBar.dart';
import 'package:easy_scrum/models/person.dart';
import 'package:easy_scrum/pages/login/recoveryPassword.dart';
import 'package:easy_scrum/pages/profile/profile-edit.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  late Person? _person;

  Widget _getProfile() {
    return Card(
      elevation: 4.0,
      child: SizedBox(
        height: 320,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
              child: Text(
                'Informações do Usúario',
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: Row(
                children: [
                  Center(
                    child: Text(
                      'Username:',
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.black,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Center(
                    child: Text(
                      _person!.getName(),
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.black,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: Row(
                children: [
                  Center(
                    child: Text(
                      'E-mail:',
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.black,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Center(
                    child: Text(
                      _person!.getName(),
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.black,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 24),
              child: TextButton(
                child: Text(
                  'mudar senha...',
                  style: TextStyle(
                    color: AppColors.primaryPurple,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RecoveryPasswordPage(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getAvatar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      height: 150,
      width: 150,
      child: const CircleAvatar(
        backgroundImage: AssetImage('assets/images/gabi.png'),
      ),
    );
  }

  List<Widget> _getActions() {
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.edit),
        color: AppColors.black,
        tooltip: 'Editar perfil',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ProfileEditPage(),
            ),
          );
        },
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    _person = Person(0, 'Gabi', 'Gabi', 'gabi@gmail.com', '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(
        Key(DateTime.now().millisecondsSinceEpoch.toString()),
        'Alterar Perfil',
        _getActions(),
      ),
      bottomNavigationBar: const BottomAppBarEasyScrum(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _getAvatar(),
              _getProfile(),
            ],
          ),
        ),
      ),
    );
  }
}
