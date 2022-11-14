// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:easy_scrum/design/colors.dart';

class TopAppBar extends StatelessWidget with PreferredSizeWidget {
  final String _title;
  final List<Widget> _actions;

  const TopAppBar(Key? key, this._title, this._actions) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        _title,
        style: TextStyle(
          color: AppColors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: AppColors.white,
      centerTitle: true,
      actions: _actions,
    );
  }
}
