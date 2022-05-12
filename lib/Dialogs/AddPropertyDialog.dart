import 'package:coffe_admin/controllers/DishObject.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Map typeOfField = {
  'Описание': 'description',
  'Выбор': 'selector',
  'Счетчик': 'counter',
  'Числовой тип': 'double'
};

Map logicValue = {
  'Выбрано': 'true',
  'Не выбрано': 'false',
};

class AddPropertyDialog extends StatefulWidget {
  List<Property> props = [];

  AddPropertyDialog(this.props);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddPropertyDialogState(props);
  }
}

class AddPropertyDialogState extends State<AddPropertyDialog> {
  late Widget initialValueWidget;
  List<Property> props = [];
  String dropdownValue = 'Описание';
  String dropdownLogicValue = 'Выбрано';
  Property property = Property();
  AddPropertyDialogState(this.props);
  @override
  Widget build(BuildContext context) {
    // initialValueWidget = Column();
    double width = MediaQuery.of(context).size.width;
    switch (property.type) {
      case 'description':
        initialValueWidget = Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              onChanged: (String value) {
                property.initialValue = value;
              },
              decoration: InputDecoration(
                labelText: 'Введите описание',
              ),
            ));

        break;
      case 'selector':
        initialValueWidget = DropdownButton<String>(
          value: dropdownLogicValue,
          icon: const Icon(Icons.arrow_downward),
          elevation: 16,
          style: const TextStyle(color: Colors.deepPurple),
          underline: Container(
            width: width,
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (String? newValue) {
            setState(() {
              dropdownLogicValue = newValue!;
              property.type = logicValue[dropdownLogicValue];
            });
          },
          items: <String>['Выбрано', 'Не выбрано']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        );
        break;
      default:
        initialValueWidget = Column();
    }
    // TODO: implement build
    return AlertDialog(
        title: Text('Добавить свойство'),
        content: Container(
          width: width * 0.96,
          child: Column(
            children: [
              Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: TextFormField(
                    validator: (value) {},
                    onChanged: (String value) {
                      property.name = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Наименование',
                    ),
                  )),
              DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  width: width,
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                    property.type = typeOfField[dropdownValue];
                  });
                },
                items: <String>['Описание', 'Выбор', 'Счетчик', 'Числовой тип']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              initialValueWidget,
            ],
          ),
        ));
  }
}
