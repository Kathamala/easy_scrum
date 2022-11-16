// ignore_for_file: file_names

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:easy_scrum/design/colors.dart';
import 'package:easy_scrum/pages/profile/profile.dart';

import 'package:easy_scrum/components/BottomAppBar.dart';
import 'package:easy_scrum/components/TopAppBar.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({Key? key}) : super(key: key);

  @override
  State<ProfileEditPage> createState() => _ProfileEditPage();
}

class _ProfileEditPage extends State<ProfileEditPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _username = TextEditingController();

  File? _image;

  Future getImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);

    if (image == null) return;

    final imageTemporary = File(image.path);

    setState(() {
      _image = imageTemporary;
    });
  }

  String username = 'Gabi';
  String email = 'gabi@gmail.com';

  void profile() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const ProfileEditPage()));
  }

  @override
  Widget build(BuildContext context) {
    Widget _editPhoto() {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
        child: TextButton(
            onPressed: _onButtonPressed,
            style: ElevatedButton.styleFrom(
                fixedSize: const Size(150, 50), shape: const StadiumBorder()),
            child: const Text(
              "Editar foto",
              style: TextStyle(
                  color: Colors.purple,
                  fontSize: 14,
                  fontWeight: FontWeight.w900),
            )),
      );
    }

    Widget _getForm() {
      return Padding(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: Column(children: [
          TextFormField(
            initialValue: username,
            decoration: const InputDecoration(
              labelText: 'Username',
              labelStyle: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            initialValue: email,
            decoration: const InputDecoration(
              labelText: 'Email',
            ),
          ),
        ]),
      );
    }

    Widget _getImage() {
      return _image != null
          ? Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: BoxFit.contain, image: FileImage(_image!)),
              ))
          : Container(
              height: 150,
              width: 150,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: BoxFit.contain,
                    image: AssetImage("assets/images/gabi.png")),
              ));
    }

    Widget _getButton() {
      return Padding(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: SizedBox(
          height: 50.0,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()));
            },
            child: const Text(
              'Salvar Alterações',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryPurple,
              textStyle: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const Text("Editar perfil",
            style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      bottomNavigationBar: const BottomAppBarEasyScrum(),
      body: Form(
        key: formKey,
        //autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _getImage(),
            const SizedBox(height: 16),
            _editPhoto(),
            const SizedBox(height: 16),
            _getForm(),
            const SizedBox(height: 32),
            _getButton(),
          ],
        ),
      ),
    );
  }

  void _onButtonPressed() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
            height: 180,
            child: Container(
              child: _navagationMenu(),
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
              ),
            ),
          );
        });
  }

  Column _navagationMenu() {
    return Column(
      children: <Widget>[
        const Center(
          child: Icon(Icons.maximize_rounded, size: 50, color: Colors.black45),
        ),
        ListTile(
          leading: const Icon(Icons.wallpaper, color: Colors.black),
          title: const Text('Galeria'),
          onTap: () => getImage(ImageSource.gallery),
        ),
        ListTile(
          leading: const Icon(Icons.photo_camera, color: Colors.black),
          title: const Text(
            'Câmera',
          ),
          onTap: () => getImage(ImageSource.camera),
        )
      ],
    );
  }
}
