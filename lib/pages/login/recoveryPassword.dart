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
  TextEditingController emailController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  int recoveryState = 0;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void sendCode() {
    print("Code sent!");
  }

  void validateCode(){
    print("Code validated!");
  }

  void changePassword(){
    print("Password changed!");
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }  

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(60),
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
              height: size.height / 2,
              padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Recuperação de senha",
                    style: TextStyle(
                        color: AppColors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    codePrompt ? "Digite o código que você recebeu por email" : "Enviaremos um código para o seu email, para recuperar sua senha.",
                    style: TextStyle(
                        color: AppColors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.normal),
                  ),                  
                  Form(
                      key: _formKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            switch(recoveryState){
                              case 0:
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    labelText: "Código",
                                    labelStyle: TextStyle(
                                        color: Colors.black, fontSize: 10),
                                  ),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 15),
                                  controller: codelController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Insira o código.";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),                                
                                break;
                              case 1:
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
                                    } else {
                                      return null;
                                    }
                                  },
                                ),                              
                                break;
                              case 2:
                                TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: "Nova senha",
                                    labelStyle: TextStyle(
                                        color: Colors.black, fontSize: 10),
                                  ),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 15),
                                  controller: passwordController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Insira a sua nova senha.";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),                              
                                break;                                
                            }
                          ])),
                  SizedBox(
                    height: 20,
                  ),
                  codePrompt ? 
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          switch(recoveryState){
                            case 0:
                              sendCode();
                              break;
                            case 1:
                              validateCode();
                              break;
                            case 2:
                              changePassword();
                              break;                            
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          primary: AppColors.primaryPurple,
                          fixedSize: Size(250, 60),
                          shape: StadiumBorder()),
                      child: const Text(
                        switch(recoveryState){
                          case 0:
                            "Enviar código"
                            break;
                          case 1:
                            "Validar código"
                            break;
                          case 2:
                            "Trocar senha"
                            break;
                        },
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )),                  
                  SizedBox(
                    height: 10,
                  ),
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
    );
  }
}
