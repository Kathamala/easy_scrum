import 'package:easy_scrum/colors.dart';
import 'package:flutter/material.dart';

import '../../components/BottomAppBar.dart';
import '../../components/TopAppBar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  void profile() {
    print("Profile!");
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const ProfilePage()));
  }

  @override
  Widget build(BuildContext context) {
    final cardProfile = Card(
        elevation: 4.0,
        child: Container(
          height: 320,
          width: 320,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 24, 8, 8),
                  child: Text("Informações do Usúario",
                      style: TextStyle(
                          color: AppColors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(35, 8, 35, 0),
                  child: Row(children: const [
                    Center(
                      heightFactor: 2,
                      child: Text('Username:',
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          )),
                    ),
                    Spacer(),
                    Center(
                      heightFactor: 2,
                      child: Text('Gabi',
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          )),
                    ),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(35, 8, 35, 0),
                  child: Row(children: const [
                    Center(
                      heightFactor: 2,
                      child: Text('E-mail:',
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          )),
                    ),
                    Spacer(),
                    Center(
                      heightFactor: 2,
                      child: Text('Gabi@gmail.com',
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          )),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                    //   child: Icon(
                    //     Icons.edit,
                    //     color: Colors.black,
                    //     size: 20.0,
                    //   ),
                    // ),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: TextButton(
                    child: Text("mudar senha...",
                        style: TextStyle(
                            color: AppColors.primaryPurple,
                            fontSize: 12,
                            fontWeight: FontWeight.bold)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProfilePage()));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 15, 8, 25),
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryPurple,
                          fixedSize: const Size(150, 50),
                          shape: StadiumBorder()),
                      child: const Text(
                        "Salvar alterações",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      )),
                )
              ]),
        ));

    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          title: const Text("Profile",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          centerTitle: true,
          actions: <Widget>[
            TextButton(
              onPressed: () {},
              child: IconButton(
                icon: const Icon(Icons.edit),
                color: Colors.black,
                tooltip: 'Editar perfil',
                onPressed: () {},
              ),
            ),
          ],
        ),
        bottomNavigationBar: const BottomAppBarEasyScrum(),
        body: SingleChildScrollView(
            child: Container(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            // Image.asset("assets/images/gabi.png"),
            Container(
                height: 150,
                width: 150,
                child: const CircleAvatar(
                  backgroundImage: AssetImage("assets/images/gabi.png"),
                )),
            cardProfile,
          ]),
        )));
  }
}
