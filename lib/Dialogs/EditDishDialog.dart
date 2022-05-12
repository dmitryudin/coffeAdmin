import 'package:coffe_admin/Dialogs/AddPropertyDialog.dart';
import 'package:coffe_admin/MyWidgets/AddPicture.dart';
import 'package:coffe_admin/MyWidgets/MyPicture.dart';
import 'package:coffe_admin/controllers/DishObject.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditDishDialog extends StatelessWidget {
  String image = '';
  Dish dish = Dish();

  @override
  Widget build(BuildContext context) {
    List<Widget> propertiesWidget = [];
    for (Property property in dish.properties) {
      propertiesWidget
          .add(Row(children: [Text(property.name), Text(property.type)]));
    }
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        //title: Text("Редактирование меню"),
        appBar: AppBar(
          title: Text('Создание меню'),
        ),
        body: Container(
          height: height * 0.9,
          width: width * 0.96,
          child: ListView(
            children: [
              SizedBox(
                height: 25,
              ),
              AddPicture(this),
              Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: TextFormField(
                    validator: (value) {},
                    onChanged: (String value) {
                      dish.name = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Наименование',
                    ),
                  )),
              Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: TextFormField(
                    validator: (value) {},
                    onChanged: (String value) {
                      dish.value = double.parse(value);
                    },
                    decoration: InputDecoration(
                      labelText: 'Объем, мл',
                    ),
                  )),
              Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: TextFormField(
                    validator: (value) {},
                    onChanged: (String value) {
                      dish.price = double.parse(value);
                    },
                    decoration: InputDecoration(
                      labelText: 'Стоимость, руб',
                    ),
                  )),
              // Column(children: dish.),
              ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return (AddPropertyDialog(dish.properties));
                        });
                  },
                  child: Text('Добавить свойство'))
            ],
          ),
        ));
    // TODO: implement build
  }
}
