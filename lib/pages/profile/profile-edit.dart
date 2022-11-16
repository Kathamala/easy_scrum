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

  String username = 'Davi';
  String email = 'davicesar@gmail.com';

  void profile() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const ProfileEditPage()));
  }

  @override
  Widget build(BuildContext context) {
    final editPhoto = Padding(
      padding: const EdgeInsets.fromLTRB(8, 15, 8, 25),
      child: TextButton(
          onPressed: _onButtonPressed,
          style: ElevatedButton.styleFrom(
              fixedSize: const Size(150, 50), shape: const StadiumBorder()),
          child: const Text(
            "Editar foto",
            style: TextStyle(
                color: Colors.purple,
                fontSize: 14,
                fontWeight: FontWeight.bold),
          )),
    );

    final buildUsername = TextFormField(
      initialValue: username,
      decoration: const InputDecoration(
        labelText: 'Username',
        labelStyle: TextStyle(
          color: Colors.black,
        ),
        border: OutlineInputBorder(),
      ),
      maxLength: 30,
    );

    final buildEmail = TextFormField(
      initialValue: email,
      decoration: const InputDecoration(
        labelText: 'Email',
        border: OutlineInputBorder(),
      ),
      maxLength: 30,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const Text("Edit profile",
            style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.check),
            color: AppColors.primaryPurple,
            tooltip: 'Editar perfil',
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()));
            },
          ),
        ],
      ),
      bottomNavigationBar: const BottomAppBarEasyScrum(),
      body: Form(
        key: formKey,
        //autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _image != null
                ? Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover, image: FileImage(_image!)),
                      // child:Image.file(_image!,
                      //   width: 150,
                      //   height: 150,
                      //   fit: BoxFit.cover,
                    ))
                : Container(
                    height: 150,
                    width: 150,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/images/gabi.png")),
                      // child:Image.file(_image!,
                      //   width: 150,
                      //   height: 150,
                      //   fit: BoxFit.cover,
                    )),
            const SizedBox(height: 16),
            editPhoto,
            const SizedBox(height: 16),
            buildUsername,
            const SizedBox(height: 16),
            buildEmail,
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
