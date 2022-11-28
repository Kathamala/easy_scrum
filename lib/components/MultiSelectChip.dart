// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:easy_scrum/models/item.dart';

class MultiSelectChip extends StatefulWidget {
  final List<Item> _list;
  final List<Item> _selectedChoicesDefault;

  final int? maxSelection;
  final Function(List<Item>)? onSelectionChanged;
  final Function(List<Item>)? onMaxSelected;

  const MultiSelectChip(
    this._list,
    this._selectedChoicesDefault, {
    Key? key,
    this.maxSelection,
    this.onSelectionChanged,
    this.onMaxSelected,
  }) : super(key: key);

  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  late List<Item> _selectedChoices;

  bool _check(Item item) {
    bool isPresent = false;
    for (var element in _selectedChoices) {
      if (element.getId() == item.getId()) {
        isPresent = true;
      }
    }
    return isPresent;
  }

  _buildChoiceList() {
    List<Widget> choices = [];
    for (var item in widget._list) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(item.getName()),
          selected: _check(item),
          onSelected: (selected) {
            if (_selectedChoices.length == (widget.maxSelection ?? -1) &&
                !_check(item)) {
              widget.onMaxSelected?.call(_selectedChoices);
            } else {
              setState(() {
                _check(item)
                    ? _selectedChoices.removeWhere((element) => element.getId() == item.getId())
                    : _selectedChoices.add(item);
                widget.onSelectionChanged?.call(_selectedChoices);
              });
            }
          },
        ),
      ));
    }

    return choices;
  }

  @override
  void initState() {
    super.initState();
    _selectedChoices = [...widget._selectedChoicesDefault];
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}
