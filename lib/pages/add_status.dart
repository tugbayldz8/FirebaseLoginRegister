import 'dart:io';

import 'package:firebase_ogin/pages/status_list.dart';
import 'package:firebase_ogin/service/status_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class AddStatusPage extends StatefulWidget {
  @override
  _AddStatusPageState createState() => _AddStatusPageState();
}

class _AddStatusPageState extends State<AddStatusPage> {
  // TextEditingController statusController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController tarifController = TextEditingController();

  StatusService _statusService = StatusService();

  final ImagePicker _pickerImage = ImagePicker();
  dynamic _pickImage;
  var profileImage;

  Widget imagePlace() {
    double height = MediaQuery.of(context).size.height;
    if (profileImage != null) {
      return CircleAvatar(
          backgroundImage: FileImage(File(profileImage!.path)),
          radius: height * 0.08);
    } else {
      if (_pickImage != null) {
        return CircleAvatar(
          backgroundImage: NetworkImage(_pickImage),
          radius: height * 0.08,
        );
      } else
        return CircleAvatar(
          backgroundImage: AssetImage("assets/images/bb.jpg"),
          radius: height * 0.08,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Tarif Ekle"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 350,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Yemek Adı:  '),
                  Expanded(
                      child: TextField(
                    controller: nameController,
                  )),
                ],
              ),
            ),
            Container(
              width: 350,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Yemek Tarifi:  '),
                  Expanded(
                    child: Container(
                      height: 300,
                      child: SingleChildScrollView(
                        child: TextField(
                          controller: tarifController,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Resim Seçin',
                          style: TextStyle(fontSize: 20),
                        ),
                        InkWell(
                            onTap: () => _onImageButtonPress(ImageSource.camera,
                                context: context),
                            child: Icon(
                              Icons.camera_alt,
                              size: 30,
                              color: Colors.blue,
                            )),
                        SizedBox(width: 10),
                        InkWell(
                            onTap: () => _onImageButtonPress(
                                ImageSource.gallery,
                                context: context),
                            child: Icon(
                              Icons.image,
                              size: 30,
                              color: Colors.blue,
                            ))
                      ],
                    ),
                    SizedBox(height: 10),
                    Center(child: imagePlace()),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 25),
              child: InkWell(
                onTap: () {
                  _statusService
                      .addStatus(tarifController.text, profileImage,
                          nameController.text ?? '')
                      .then((value) {
                    Fluttertoast.showToast(
                        msg: "Durum eklendi!",
                        timeInSecForIosWeb: 2,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.grey[600],
                        textColor: Colors.white,
                        fontSize: 14);
                  });
                  // _statusService.addStatus(
                  //   tarifController.text,
                  //   profileImage,
                  //   nameController.text,
                  // );
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StatusListPage()));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 2),
                      //color: colorPrimaryShade,
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Center(
                        child: Text(
                      "Ekle",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                      ),
                    )),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  void _onImageButtonPress(ImageSource source,
      {required BuildContext context}) async {
    try {
      final pickedFile = await _pickerImage.pickImage(source: source);
      setState(() {
        profileImage = pickedFile!;
        print("dosyaya geldim");
        if (profileImage != null) {}
      });
      print('aaa');
    } catch (e) {
      setState(() {
        print("Image Error: ");
      });
    }
  }
}
