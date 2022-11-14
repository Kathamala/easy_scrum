// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:easy_scrum/models/item.dart';

class MultiSelectChip extends StatefulWidget {
  final List<Item> _list;
  final List<Item> _selectedChoices;

  final int? maxSelection;
  final Function(List<Item>)? onSelectionChanged;
  final Function(List<Item>)? onMaxSelected;

  const MultiSelectChip(
    this._list,
    this._selectedChoices, {
    Key? key,
    this.maxSelection,
    this.onSelectionChanged,
    this.onMaxSelected,
  }) : super(key: key);

  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  _buildChoiceList() {
    List<Widget> choices = [];
    for (var item in widget._list) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(item.getName()),
          selected: widget._selectedChoices.contains(item),
          onSelected: (selected) {
            if (widget._selectedChoices.length == (widget.maxSelection ?? -1) &&
                !widget._selectedChoices.contains(item)) {
              widget.onMaxSelected?.call(widget._selectedChoices);
            } else {
              setState(() {
                widget._selectedChoices.contains(item)
                    ? widget._selectedChoices.remove(item)
                    : widget._selectedChoices.add(item);
                widget.onSelectionChanged?.call(widget._selectedChoices);
              });
            }
          },
        ),
      ));
    }

    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}
