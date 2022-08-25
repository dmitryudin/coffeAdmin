import 'package:coffe_admin/Dialogs/AddPropertyDialog.dart';
import 'package:coffe_admin/MyWidgets/AddPicture.dart';
import 'package:coffe_admin/MyWidgets/DropListWrapper.dart';
import 'package:coffe_admin/controllers/CoffeHouseObject.dart';
import 'package:coffe_admin/controllers/DishObject.dart';
import 'package:coffe_admin/utils/Network/RestController.dart';
import 'package:coffe_admin/utils/Security/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/Network/MultiPart.dart';

// TODO можно в будущем сделать категории подгружаемыми с интернета
List<String> caterories = [
  'Чёрный кофе',
  "Классика",
  "Не кофе",
  "Чай",
  "Смузи",
  "Авторские напитки",
  "COLD",
  "Милкшейки",
  'LIMONADES'
];

class EditCakeDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EditCakeDialogState();
  }
}

class EditCakeDialogState extends State<EditCakeDialog> {
  final _formKey = GlobalKey<FormState>();
  String image = '';
  bool isCancel = false;
  bool isImageUploaded = true;
  DishObject dishObject = DishObject();

  EditCakeDialogState() {
    dishObject.category = 'cake';
    dishObject.subcategory = caterories[0];
  }
  @override
  Widget build(BuildContext context) {
    AddPicture addPic = AddPicture(
        url: '',
        onFileLoaded: (path) {
          isImageUploaded = false;
          print('Worked' + path);
        },
        onFileUploaded: (url) {
          print('picture uploaded!');
          dishObject.picture = url;
          isImageUploaded = true;
        });
    List<Widget> propertiesWidget = [];
    List<Widget> volumesWidget = [];
    for (Option property in dishObject.options) {
      propertiesWidget.add(Row(children: [
        Expanded(
          child: Text(property.name),
          flex: 3,
        ),
        Text(property.price.toString()),
        IconButton(
            onPressed: () {
              dishObject.options.remove(property);
              setState(() {});
            },
            icon: Icon(Icons.close))
      ]));
    }
    for (Option option in dishObject.fieldSelection!.fields) {
      volumesWidget.add(Row(children: [
        Expanded(
          child: Text(option.name),
          flex: 3,
        ),
        Text(option.price.toString()),
        IconButton(
            onPressed: () {
              dishObject.fieldSelection!.fields.remove(option);
              setState(() {});
            },
            icon: Icon(Icons.close))
      ]));
    }
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      //title: Text("Редактирование меню"),
      appBar: AppBar(
        title: Text('Создание изделия'),
      ),
      body: ListView(shrinkWrap: true, children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          LimitedBox(
              maxWidth: width * 0.95,
              child: Container(
                  width: width * 0.95,
                  child: Form(
                      key: _formKey,
                      child: Column(children: [
                        SizedBox(
                          height: 25,
                        ),
                        Divider(color: Colors.black),
                        addPic,
                        Divider(color: Colors.black),
                        Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: TextFormField(
                              validator: (value) {
                                return Validator.isEmptyValid(value!);
                              },
                              onChanged: (String value) {
                                dishObject.name = value;
                              },
                              decoration: InputDecoration(
                                labelText: 'Наименование изделия',
                              ),
                            )),
                        Divider(color: Colors.white),
                        Text('Добавьте доступную массу'),
                        Row(children: [
                          Expanded(
                            child: Text('Масса, г'),
                            flex: 1,
                          ),
                          Text('Цена')
                        ]),
                        Column(children: volumesWidget),
                        ElevatedButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return (AddPriceOfVolumeDialog(this));
                                  });
                            },
                            child: Text('Добавить массу')),
                        Divider(color: Colors.black),
                        Row(children: [
                          Expanded(
                            child: Text('Название добавки'),
                            flex: 3,
                          ),
                          Text('Цена')
                        ]),
                        Column(children: propertiesWidget),
                        ElevatedButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return (AddPropertyDialog(this));
                                  });
                            },
                            child: Text('Добавить свойство')),
                        Divider(color: Colors.black),
                        TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          onChanged: (String value) {
                            dishObject.description = value;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.description),
                            labelText: 'Введите описание',
                          ),
                        ),
                        Divider(color: Colors.black),
                        ElevatedButton(
                            onPressed: () {
                              if (dishObject.fieldSelection.fields.isNotEmpty) {
                                if (_formKey.currentState!.validate()) {
                                  print('debug' + addPic.url);
                                  Provider.of<CoffeHouse>(context,
                                          listen: false)
                                      .createCoffe(dishObject);
                                  Provider.of<CoffeHouse>(context,
                                          listen: false)
                                      .getCoffes();
                                  Navigator.pop(context);

                                  //Navigator.pop(context);
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Добавьте хотя-бы обин доступынй объем!')),
                                );
                              }
                            },
                            child: Text('Сохранить')),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: ElevatedButton(
                            onPressed: () {
                              if (isImageUploaded) {
                                isCancel = true;
                                Navigator.pop(context);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Дождитесь окончания загрузки изображения на сервер')),
                                );
                              }
                            },
                            child: Text('Отмена'),
                          ),
                        ),
                      ]))))
        ])
      ]),
    );
    // TODO: implement build
  }

  @override
  void dispose() {
    if (isCancel) {
      RemoteFileManager().deleteFile(url: dishObject.picture);
    }
    print('dispose');
    super.dispose();
  }
}
