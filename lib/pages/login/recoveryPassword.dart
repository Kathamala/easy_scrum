// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'dart:convert';
import 'dart:math';

import 'package:easy_scrum/design/colors.dart';
import 'package:easy_scrum/service/people.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RecoveryPasswordPage extends StatefulWidget {
  const RecoveryPasswordPage({Key? key}) : super(key: key);

  @override
  State<RecoveryPasswordPage> createState() => _RecoveryPasswordPageState();
}

class _RecoveryPasswordPageState extends State<RecoveryPasswordPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  int recoveryState = 0;
  int code = 0;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool codePrompt = false;

  Future<bool> sendCode() async {
    Random random = Random();
    int _randomNumber1 = random.nextInt(8) + 1;
    int _randomNumber2 = random.nextInt(8) + 1;
    int _randomNumber3 = random.nextInt(8) + 1;
    int _randomNumber4 = random.nextInt(8) + 1;

    code = (_randomNumber1 * 1000) +
        (_randomNumber2 * 100) +
        (_randomNumber3 * 10) +
        _randomNumber4;

    var response = await http
        .post(PeopleService.sendCode(emailController.text, code.toString()));

    if (response.statusCode == 200) {
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
                    Center(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 40, left: 20, right: 20),
                        child: Text(
                          "Code: " + code.toString(),
                          style: TextStyle(
                              color: AppColors.primaryPurple,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Icon(
                      Icons.email_outlined,
                      color: AppColors.success,
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
      return true;
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
                    Center(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 40, left: 20, right: 20),
                        child: Text(
                          json.decode(response.body)["message"],
                          style: TextStyle(
                              color: AppColors.primaryPurple,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
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
      return false;
    }
  }

  Future<bool> changePassword() async {
    var response = await http.post(PeopleService.passwordChange(
        emailController.text, passwordController.text));

    if (response.statusCode == 200) {
      return true;
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
                    Center(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 40, left: 20, right: 20),
                        child: Text(
                          json.decode(response.body)["message"],
                          style: TextStyle(
                              color: AppColors.primaryPurple,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
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
      return false;
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
                height: size.height / 2,
                padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            "Recuperação de senha",
                            style: TextStyle(
                                color: AppColors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Text(
                            recoveryState == 0
                                ? "Enviaremos um código para o seu email, para recuperar sua senha."
                                : recoveryState == 1
                                    ? "Digite o código que você recebeu por email"
                                    : "Insira a nova senha.",
                            style: TextStyle(
                                color: AppColors.black,
                                fontSize: 10,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        SizedBox(height: 50),
                        Form(
                            key: _formKey,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  if (recoveryState == 0)
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
                                  if (recoveryState == 1)
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
                                      controller: codeController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Insira o código.";
                                        }
                                        if (value != code.toString()) {
                                          return "Código inválido.";
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                  if (recoveryState == 2)
                                    Column(
                                      children: [
                                        TextFormField(
                                          decoration: const InputDecoration(
                                            labelText: "Nova senha",
                                            labelStyle: TextStyle(
                                                color: Colors.black,
                                                fontSize: 10),
                                          ),
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 15),
                                          controller: passwordController,
                                          obscureText: true,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Insira a sua nova senha.";
                                            } else if (value.length < 3) {
                                              return "A senha deve conter ao menos 3 caracteres.";
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                        SizedBox(height: 20),
                                        TextFormField(
                                          decoration: const InputDecoration(
                                            labelText: "Confirmar nova senha",
                                            labelStyle: TextStyle(
                                                color: Colors.black,
                                                fontSize: 10),
                                          ),
                                          obscureText: true,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 15),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Confirme sua senha.";
                                            } else if (value !=
                                                passwordController.text) {
                                              return "Senha de confirmação diferente.";
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                ])),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              switch (recoveryState) {
                                case 0:
                                  sendCode();
                                  break;
                                case 2:
                                  bool result = await changePassword();

                                  if (result) {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                2,
                                            color: Colors.white,
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 40),
                                                    child: Text(
                                                      'Senha alterada com sucesso!',
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .primaryPurple,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.task_alt,
                                                    color: AppColors.success,
                                                    size: 90,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 60),
                                                    child: ElevatedButton(
                                                        child: const Text(
                                                            'Login',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 20)),
                                                        style: ElevatedButton.styleFrom(
                                                            backgroundColor:
                                                                AppColors
                                                                    .primaryPurple,
                                                            fixedSize:
                                                                Size(250, 60),
                                                            shape:
                                                                StadiumBorder()),
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                          Navigator.pop(
                                                              context);
                                                        }),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  }
                                  break;
                              }

                              setState(() {
                                recoveryState++;
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryPurple,
                              fixedSize: Size(250, 60),
                              shape: StadiumBorder()),
                          child: Text(
                            (recoveryState == 0
                                ? "Enviar código"
                                : (recoveryState == 1
                                    ? "Validar código"
                                    : "Trocar senha")),
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )),
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
      ),
    );
  }
}
