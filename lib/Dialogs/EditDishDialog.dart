import 'package:coffe_admin/Dialogs/AddPropertyDialog.dart';
import 'package:coffe_admin/MyWidgets/AddPicture.dart';
import 'package:coffe_admin/MyWidgets/DropListWrapper.dart';
import 'package:coffe_admin/controllers/CoffeHouseObject.dart';
import 'package:coffe_admin/controllers/DishObject.dart';
import 'package:coffe_admin/utils/Network/RestController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

class EditDishDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EditDishDialogState();
  }
}

class EditDishDialogState extends State<EditDishDialog> {
  String image = '';
  Coffe coffe = Coffe();

  EditDishDialogState() {
    coffe.category = caterories[0];
  }
  @override
  Widget build(BuildContext context) {
    AddPicture addPic = AddPicture(
        url: '',
        onFileLoaded: (path) {
          print('Worked' + path);
        },
        onFileUploaded: (url) {
          print('picture uploaded!');
          coffe.picture = url;
        });
    List<Widget> propertiesWidget = [];
    List<Widget> volumesWidget = [];
    for (Property property in coffe.properties) {
      propertiesWidget.add(Row(children: [
        Expanded(
          child: Text(property.name),
          flex: 3,
        ),
        Text(property.price.toString()),
        IconButton(
            onPressed: () {
              coffe.properties.remove(property);
              setState(() {});
            },
            icon: Icon(Icons.close))
      ]));
    }
    for (Volume volume in coffe.priceOfVolume) {
      volumesWidget.add(Row(children: [
        Expanded(
          child: Text(volume.volume.toString()),
          flex: 3,
        ),
        Text(volume.price.toString()),
        IconButton(
            onPressed: () {
              coffe.priceOfVolume.remove(volume);
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
        title: Text('Создание напитка'),
      ),
      body: ListView(shrinkWrap: true, children: [
        Container(
            width: width * 0.8,
            child: Column(mainAxisSize: MainAxisSize.max, children: [
              SizedBox(
                height: 25,
              ),
              Divider(color: Colors.black),
              addPic,
              Divider(color: Colors.black),
              Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: TextFormField(
                    validator: (value) {},
                    onChanged: (String value) {
                      coffe.name = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Наименование напитка',
                    ),
                  )),
              Divider(color: Colors.black),
              Text('Выберите категорию напитка:'),
              DropListWrapper(
                  items: caterories,
                  onSelect: (value) {
                    coffe.category = value;
                    print('value' + '$value');
                  }),
              Divider(color: Colors.black),
              Text('Добавьте доступные объёмы'),
              Row(children: [
                Expanded(
                  child: Text('Объем'),
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
                  child: Text('Добавить объём')),
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
              ElevatedButton(
                  onPressed: () {
                    print('debug' + addPic.url);
                    Provider.of<CoffeHouse>(context, listen: false)
                        .createCoffe(coffe);

                    Navigator.pop(context);
                  },
                  child: Text('Сохранить')),
            ]))
      ]),
    );
    // TODO: implement build
  }
}
