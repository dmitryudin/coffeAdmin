import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DropListWrapper extends StatefulWidget {
  late Function onSelect;
  List<String> items = [];
  DropListWrapper({required this.items, required this.onSelect});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DropListWrapperState(items, onSelect);
  }
}

class DropListWrapperState extends State<DropListWrapper> {
  String dropdownValue = '';
  late Function onSelect;
  List<String> items = [];
  DropListWrapperState(this.items, this.onSelect) : dropdownValue = items[0];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        //  width: width,
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
          onSelect(dropdownValue);
        });
      },
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
