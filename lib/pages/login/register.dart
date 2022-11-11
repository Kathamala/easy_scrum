// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:easy_scrum/colors.dart';
//import 'package:easy_scrum/pages/home.dart';
//import 'package:easy_scrum/pages/login/login.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void register() {
    print("Registered!");
    print(usernameController.text);
    print(emailController.text);
    print(passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(60, 150, 60, 60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Easy ",
                    style: TextStyle(
                        color: AppColors.primaryPurple,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Scrum",
                    style: TextStyle(
                        color: AppColors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(height: 80),
              Container(
                height: size.height / 1.8,
                padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Cadastro",
                      style: TextStyle(
                          color: AppColors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Form(
                        key: _formKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              TextFormField(
                                decoration: const InputDecoration(
                                  labelText: "Usuário",
                                  errorMaxLines: 2,
                                  labelStyle: TextStyle(
                                      color: Colors.black, fontSize: 10),
                                ),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 15),
                                controller: usernameController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Insira o nome do seu usuário.";
                                  } else if (value.length < 3) {
                                    return "O nome de usuário deve conter ao menos 3 caracteres.";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                decoration: const InputDecoration(
                                  labelText: "Email",
                                  labelStyle: TextStyle(
                                      color: Colors.black, fontSize: 10),
                                ),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 15),
                                controller: emailController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Insira o seu email.";
                                  } else if (!RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(value)) {
                                    return "Email inválido.";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                obscureText: true,
                                decoration: const InputDecoration(
                                  labelText: "Senha",
                                  errorMaxLines: 2,
                                  labelStyle: TextStyle(
                                      color: Colors.black, fontSize: 10),
                                ),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 15),
                                controller: passwordController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Insira a senha.";
                                  } else if (value.length < 3) {
                                    return "A senha deve conter ao menos 3 caracteres.";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                obscureText: true,
                                decoration: const InputDecoration(
                                  labelText: "Confirmar Senha",
                                  errorMaxLines: 2,
                                  labelStyle: TextStyle(
                                      color: Colors.black, fontSize: 10),
                                ),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 15),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Confirme sua senha.";
                                  } else if (value != passwordController.text) {
                                    return "Senha de confirmação diferente.";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ])),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) {
                            register();
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    height:
                                        MediaQuery.of(context).size.height / 2,
                                    color: Colors.white,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 40),
                                            child: Text(
                                              'Cadastro realizado com sucesso!',
                                              style: TextStyle(
                                                  color:
                                                      AppColors.primaryPurple,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Icon(
                                            Icons.task_alt,
                                            color: AppColors.success,
                                            size: 90,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 60),
                                            child: ElevatedButton(
                                                child: const Text('Login',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20)),
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        AppColors.primaryPurple,
                                                    fixedSize: Size(250, 60),
                                                    shape: StadiumBorder()),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  Navigator.pop(context);
                                                }),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryPurple,
                            fixedSize: Size(250, 60),
                            shape: StadiumBorder()),
                        child: const Text(
                          "Cadastrar",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )),
                  ],
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(70),
                      topRight: Radius.circular(70),
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  color: AppColors.secondaryGrey,
                  boxShadow: [
                    BoxShadow(color: AppColors.secondaryGrey, spreadRadius: 3),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
