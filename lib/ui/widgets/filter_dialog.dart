import 'package:flutter/material.dart';

class FilterDialog extends StatefulWidget {
  const FilterDialog({super.key});

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  bool _isVegetarian = false;
  bool _isVegan = false;
  bool _isGlutenFree = false;
  bool _isLactoseFree = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Filter'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CheckboxListTile(
            title: const Text('Vegetarian'),
            value: _isVegetarian,
            onChanged: (value) {
              setState(() {
                _isVegetarian = value!;
              });
            },
          ),
          CheckboxListTile(
            title: const Text('Vegan'),
            value: _isVegan,
            onChanged: (value) {
              setState(() {
                _isVegan = value!;
              });
            },
          ),
          CheckboxListTile(
            title: const Text('Gluten Free'),
            value: _isGlutenFree,
            onChanged: (value) {
              setState(() {
                _isGlutenFree = value!;
              });
            },
          ),
          CheckboxListTile(
            title: const Text('Lactose Free'),
            value: _isLactoseFree,
            onChanged: (value) {
              setState(() {
                _isLactoseFree = value!;
              });
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Apply'),
        ),
      ],
    );
  }
}
