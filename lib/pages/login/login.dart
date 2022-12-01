// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'dart:convert';

import 'package:easy_scrum/service/people.dart';
import 'package:http/http.dart' as http;
import 'package:easy_scrum/design/colors.dart';
import 'package:easy_scrum/models/person.dart';
import 'package:easy_scrum/pages/home.dart';
import 'package:easy_scrum/pages/login/recoveryPassword.dart';
import 'package:easy_scrum/pages/login/register.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> login() async {
    var response = await http.get(PeopleService.login(
        usernameController.text, passwordController.text, 1, 0));

    if (response.statusCode == 200) {
      Person p = Person.fromJson(json.decode(response.body));
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => HomePage(loggedUser: p)));
    } else {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: MediaQuery.of(context).size.height / 2,
              color: Colors.white,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Text(
                        json.decode(response.body)["message"],
                        style: TextStyle(
                            color: AppColors.primaryPurple,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Icon(
                      Icons.error_outline,
                      color: AppColors.error,
                      size: 90,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 60),
                      child: ElevatedButton(
                          child: const Text('OK',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20)),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryPurple,
                              fixedSize: Size(250, 60),
                              shape: StadiumBorder()),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                    ),
                  ],
                ),
              ),
            );
          });
    }
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
                height: 500,
                padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Login",
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
                                  errorStyle: TextStyle(
                                    fontSize: 10.0,
                                  ),
                                  errorMaxLines: 1,
                                  labelText: "Usuário",
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
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                obscureText: true,
                                decoration: const InputDecoration(
                                  errorStyle: TextStyle(
                                    fontSize: 10.0,
                                  ),
                                  errorMaxLines: 1,
                                  labelText: "Senha",
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
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ])),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          child: Text("Esqueceu sua senha?",
                              style: TextStyle(
                                  color: AppColors.black, fontSize: 10)),
                          onPressed: () {
                            print("Alterar senha!");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RecoveryPasswordPage()));
                          },
                        ),
                      ],
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              login();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryPurple,
                              fixedSize: Size(250, 60),
                              shape: StadiumBorder()),
                          child: const Text(
                            "Entrar",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Não tem conta?",
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 10,
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              print("Cadastrar!");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RegisterPage()));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryPurple,
                            ),
                            child: const Text(
                              "Cadastre-se",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            )),
                      ],
                    )
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
