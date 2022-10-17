// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:easy_scrum/colors.dart';
import 'package:easy_scrum/pages/home.dart';
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

  void login() {
    print("Log in!");
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height,
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Text(
                "Easy",
                style: TextStyle(
                  color: AppColors.primaryPurple,
                ),
              ),
              Text(
                "Scrum",
                style: TextStyle(color: AppColors.black),
              )
            ],
          ),
          SizedBox(height: 30),
          Container(
            child: Column(
              children: [
                Text("Login"),
                Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: "Usuário",
                              labelStyle:
                                  TextStyle(color: Colors.blue, fontSize: 25),
                            ),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.blue, fontSize: 25),
                            controller: usernameController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Insira o nome do seu usuário.";
                              } else {
                                return null;
                              }
                            },
                          ),
                          TextFormField(
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: "Senha",
                              labelStyle:
                                  TextStyle(color: Colors.blue, fontSize: 25),
                            ),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.blue, fontSize: 25),
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
                TextButton(
                  child: Text("Esqueceu sua senha?"),
                  onPressed: () {
                    print("Alterar senha!");
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        login();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.primaryPurple,
                    ),
                    child: const Text(
                      "Entrar",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    )),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text("Não tem conta?"),
                    ElevatedButton(
                        onPressed: () {
                          print("Cadastrar!");
                        },
                        style: ElevatedButton.styleFrom(
                          primary: AppColors.primaryPurple,
                        ),
                        child: const Text(
                          "Cadastre-se",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        )),
                  ],
                )
              ],
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.white,
              boxShadow: [
                BoxShadow(color: AppColors.secondaryGrey, spreadRadius: 3),
              ],
            ),
          )
        ],
      ),
    );
  }
}
