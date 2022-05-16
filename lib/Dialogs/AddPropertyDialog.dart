import 'package:coffe_admin/Dialogs/EditDishDialog.dart';
import 'package:coffe_admin/controllers/DishObject.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddPropertyDialog extends StatefulWidget {
  EditDishDialogState baseClass;

  AddPropertyDialog(this.baseClass);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddPropertyDialogState(baseClass);
  }
}

class AddPropertyDialogState extends State<AddPropertyDialog> {
  EditDishDialogState baseClass;
  Property property = Property();
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
                    baseClass.coffe.properties.add(property);
                    baseClass.coffe.properties =
                        baseClass.coffe.properties.toSet().toList();
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
  EditDishDialogState baseClass;

  AddPriceOfVolumeDialog(this.baseClass);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddPriceOfVolumeDialogState(baseClass);
  }
}

class AddPriceOfVolumeDialogState extends State<AddPriceOfVolumeDialog> {
  EditDishDialogState baseClass;
  Volume tempVolume = Volume();
  AddPriceOfVolumeDialogState(this.baseClass);
  @override
  Widget build(BuildContext context) {
    // initialValueWidget = Column();
    double width = MediaQuery.of(context).size.width;

    // TODO: implement build
    return AlertDialog(
        title: Text('Добавить объём'),
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
                      tempVolume.volume = double.parse(value);
                    },
                    decoration: InputDecoration(
                      labelText: 'Объем, мл',
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
                      tempVolume.price = double.parse(value);
                    },
                    decoration: InputDecoration(
                      labelText: 'Цена, руб',
                    ),
                  )),
              ElevatedButton(
                  onPressed: () {
                    baseClass.coffe.priceOfVolume.add(tempVolume);
                    baseClass.coffe.priceOfVolume =
                        baseClass.coffe.priceOfVolume.toSet().toList();
                    baseClass.setState(() {});
                    Navigator.pop(context);
                  },
                  child: Text('Добавить'))
            ],
          ),
        ));
  }
}
