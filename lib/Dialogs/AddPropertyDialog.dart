import 'package:coffe_admin/Dialogs/EditDishDialog.dart';
import 'package:coffe_admin/controllers/DishObject.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddPropertyDialog extends StatefulWidget {
  var baseClass;

  AddPropertyDialog(this.baseClass);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddPropertyDialogState(baseClass);
  }
}

class AddPropertyDialogState extends State<AddPropertyDialog> {
  var baseClass;
  Option property = Option();
  AddPropertyDialogState(this.baseClass);
  @override
  Widget build(BuildContext context) {
    // initialValueWidget = Column();
    double width = MediaQuery.of(context).size.width;
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
              Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      //FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
                      TextInputFormatter.withFunction((oldValue, newValue) {
                        try {
                          final text = newValue.text;
                          if (text.isNotEmpty) double.parse(text);
                          return newValue;
                        } catch (e) {}
                        return oldValue;
                      })
                    ],
                    validator: (value) {},
                    onChanged: (String value) {
                      property.price = double.parse(value);
                    },
                    decoration: InputDecoration(
                      labelText: 'Цена',
                    ),
                  )),
              ElevatedButton(
                  onPressed: () {
                    baseClass.dishObject.options.add(property);
                    baseClass.dishObject.options =
                        baseClass.dishObject.options.toSet().toList();
                    baseClass.setState(() {});
                    Navigator.pop(context);
                    ;
                  },
                  child: Text('Добавить свойство'))
            ],
          ),
        ));
  }
}

class AddPriceOfVolumeDialog extends StatefulWidget {
  var baseClass;

  AddPriceOfVolumeDialog(this.baseClass);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddPriceOfVolumeDialogState(baseClass);
  }
}

class AddPriceOfVolumeDialogState extends State<AddPriceOfVolumeDialog> {
  var baseClass;
  Option option = Option();
  AddPriceOfVolumeDialogState(this.baseClass);
  @override
  Widget build(BuildContext context) {
    // initialValueWidget = Column();
    double width = MediaQuery.of(context).size.width;

    // TODO: implement build
    return AlertDialog(
        title: Text('Добавить объём/массу'),
        content: Container(
          width: width * 0.96,
          child: Column(
            children: [
              Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      TextInputFormatter.withFunction((oldValue, newValue) {
                        try {
                          final text = newValue.text;
                          if (text.isNotEmpty) double.parse(text);
                          return newValue;
                        } catch (e) {}
                        return oldValue;
                      })
                    ],
                    validator: (value) {},
                    onChanged: (String value) {
                      option.name = (value);
                    },
                    decoration: InputDecoration(
                      labelText: 'Объем, мл (Масса, г)',
                    ),
                  )),
              Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      //FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
                      TextInputFormatter.withFunction((oldValue, newValue) {
                        try {
                          final text = newValue.text;
                          if (text.isNotEmpty) double.parse(text);
                          return newValue;
                        } catch (e) {}
                        return oldValue;
                      })
                    ],
                    validator: (value) {},
                    onChanged: (String value) {
                      option.price = double.parse(value);
                    },
                    decoration: InputDecoration(
                      labelText: 'Цена, руб',
                    ),
                  )),
              ElevatedButton(
                  onPressed: () {
                    baseClass.dishObject.fieldSelection!.fields.add(option);

                    baseClass.setState(() {});
                    Navigator.pop(context);
                  },
                  child: Text('Добавить'))
            ],
          ),
        ));
  }
}
