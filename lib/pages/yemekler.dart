import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';

class Foods extends StatefulWidget {
  const Foods({Key? key}) : super(key: key);

  @override
  State<Foods> createState() => _FoodsState();
}

class _FoodsState extends State<Foods> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yemekler"),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Container(
            color: Colors.white,
            width: double.infinity,
            alignment: Alignment.center,
            child: Column(
              children: [
                All(
                  image: Image.network(
                    ("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-sMlK-MPs79ebYawDF-n7eAqDYw6l0T0Qnw&usqp=CAU"),
                    fit: BoxFit.cover,
                  ),
                  name: "Pizza",
                  tarif:
                      "Malzemeler:\n 5 su bardağı un,\n 1 paket instant maya (ya da yarım paket yaş maya),\n"
                      " 1 yemek kaşığı toz şeker,\n Yarım yemek kaşığı tuz,\n 4 yemek kaşığı zeytinyağı,\n 2 su bardağı ılık su,\n"
                      " Sosu İçin;\n 2 su bardağı domates sosu,\n2 yemek kaşığı zeytinyağı,\n1 çay kaşığı kuru fesleğen,\n1 çay kaşığı kekik,\nÜzeri İçin;\nMozzarella peyniri,\n"
                      "Kaşar peyniri,\nSucuk, Sosis, \nDomates kurusu, \nMantar,\nMısır",
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}

class All extends StatelessWidget {
  const All({
    Key? key,
    required Image image,
    required String name,
    required String tarif,
  })  : _image = image,
        _name = name,
        _tarif = tarif,
        super(key: key);

  final String _name;
  final String _tarif;
  final Image _image;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Stack(children: [
              Container(
                width: 370,
                height: 150,
                child: _image,
              ),
            ]),
          ),
          SizedBox(height: 10),
          Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
              ),
              width: 350,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text(
                    textAlign: TextAlign.start,
                    _name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  SizedBox(height: 5),
                  ExpandableText(
                    _tarif,
                    expandText: 'Daha Fazla...',
                    collapseText: 'Daha Az',
                    maxLines: 5,
                    textAlign: TextAlign.start,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              )),
        ],
      )
    ]);
  }
}
