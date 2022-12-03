// ignore: file_names
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:easy_scrum/design/colors.dart';

class ErrorHandling {
  static Future getModalBottomSheet(BuildContext context, Response response) {
    return showModalBottomSheet(
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
                      fontWeight: FontWeight.bold,
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
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryPurple,
                          fixedSize: const Size(250, 60),
                          shape: const StadiumBorder()),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
