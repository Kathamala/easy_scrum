// ignore_for_file: file_names

import 'dart:io';
import 'package:easy_scrum/models/person.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:easy_scrum/design/colors.dart';
import 'package:easy_scrum/components/BottomAppBar.dart';
import 'package:easy_scrum/components/TopAppBar.dart';
import 'package:easy_scrum/pages/profile/profile.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({Key? key}) : super(key: key);

  @override
  State<ProfileEditPage> createState() => _ProfileEditPage();
}

class _ProfileEditPage extends State<ProfileEditPage> {
  File? _image;
  late Person _person;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  Future _getImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);

    if (image == null) return;

    final imageTemporary = File(image.path);

    setState(() {
      _image = imageTemporary;
    });
  }

  // TO-DO: to integrate
  Future<void> _submit() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProfilePage(),
      ),
    );
  }

  Column _navagationMenu() {
    return Column(
      children: <Widget>[
        const Center(
          child: Icon(
            Icons.maximize_rounded,
            size: 50,
            color: Colors.black45,
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.wallpaper,
            color: AppColors.black,
          ),
          title: const Text('Galeria'),
          onTap: () => _getImage(ImageSource.gallery),
        ),
        ListTile(
          leading: Icon(
            Icons.photo_camera,
            color: AppColors.black,
          ),
          title: const Text('Câmera'),
          onTap: () => _getImage(ImageSource.camera),
        )
      ],
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
                topRight: Radius.circular(10),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget __getImage() {
    return _image != null
        ? Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.contain,
                image: FileImage(_image!),
              ),
            ),
          )
        : Container(
            height: 150,
            width: 150,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage('assets/images/gabi.png'),
              ),
            ),
          );
  }

  Widget _getForm() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Nome de usuário',
              labelStyle: TextStyle(
                color: AppColors.black,
              ),
            ),
            controller: _usernameController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Insira o nome de usuário!';
              } else {
                return null;
              }
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Email',
            ),
            controller: _emailController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Insira o email!';
              } else {
                return null;
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _person = Person(0, 'Gabi', 'Gabi', 'gabi@gmail.com', '', '');
    _usernameController.text = _person.getNickname();
    _emailController.text = _person.getEmail();
  }

  @override
  Widget build(BuildContext context) {
    Widget _editPhoto() {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
        child: TextButton(
          onPressed: _onButtonPressed,
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(150, 50),
            shape: const StadiumBorder(),
          ),
          child: Text(
            'Alterar Foto',
            style: TextStyle(
              color: AppColors.primaryPurple,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      );
    }

    Widget _getButton() {
      return Padding(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: SizedBox(
          height: 50.0,
          child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _submit();
              }
            },
            child: const Text(
              'Alterar',
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
      appBar: TopAppBar(
        Key(DateTime.now().millisecondsSinceEpoch.toString()),
        'Alterar Perfil',
        List.empty(),
      ),
      bottomNavigationBar: const BottomAppBarEasyScrum(),
      body: Form(
        key: _formKey,
        //autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            __getImage(),
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
}
