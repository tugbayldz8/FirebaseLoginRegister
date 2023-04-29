import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../service/notificationn.dart';
import '../service/status_service.dart';

class StatusListPage extends StatefulWidget {
  @override
  _StatusListPageState createState() => _StatusListPageState();
}

class _StatusListPageState extends State<StatusListPage> {
  StatusService _statusService = StatusService();
  ScrollController _scrollController = ScrollController();
  final _service = FirebaseNotificationService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _service.connectNotgication();
  }

//   FirebaseMessaging messaging = FirebaseMessaging.instance;
//
// // Bir kaynak üzerinde bir öğe silindiğinde çağrılan işlev
//   void deleteItem(String itemId) {
//     // Veri tabanından öğe silme işlemi gerçekleştirilir
//     FirebaseFirestore.instance.collection('items').doc(itemId).delete();
//
//     // Silme işleminden sonra push bildirimi göndermek için FCM kullanılır
//     messaging.getToken().then((token) {
//       print('Token: $token');
//
//       Map<String, dynamic> message = {
//         'notification': {
//           'title': 'Bir öğe silindi',
//           'body': 'Bir öğe silindi.'
//         },
//         'token': token,
//         'data': {
//           'click_action': 'FLUTTER_NOTIFICATION_CLICK',
//           'screen': 'item_list'
//         }
//       };
//
//       // Push bildirimi gönderilir
//       messaging.sendAll(
//       <RemoteMessage>[
//       RemoteMessage(
//       notification: RemoteNotification(
//       title: message['notification']['title'],
//       body: message['notification']['body'],
//       ),
//       data: message['data'],
//       to: message['to'],
//           ),
//         },
//       );
//     });
//   }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return StreamBuilder<QuerySnapshot>(
      stream: _statusService.getStatus(),
      builder: (context, snaphot) {
        return !snaphot.hasData
            ? CircularProgressIndicator()
            : Scaffold(
                appBar: AppBar(
                  title: Text('Tarifler'),
                ),
                body: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 500,
                      child: ListView.builder(
                          itemCount: snaphot.data!.docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot mypost = snaphot.data!.docs[index];

                            //veri silmek için
                            Future<void> _showChoiseDialog(
                                BuildContext context) {
                              return showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                        title: Text(
                                          "Silmek istediğinize emin misiniz?",
                                          textAlign: TextAlign.center,
                                        ),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8.0))),
                                        content: Container(
                                            height: 30,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                GestureDetector(
                                                  onTap: () {
                                                    _statusService.removeStatus(
                                                        mypost.id);
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    "Evet",
                                                    style: TextStyle(
                                                        color: Colors.blue,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    "Vazgeç",
                                                    style: TextStyle(
                                                        color: Colors.blue,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            )));
                                  });
                            }

                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  _showChoiseDialog(context);
                                },
                                child: Container(
                                  height: size.height * .3,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.blue, width: 2),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Scrollbar(
                                    controller: _scrollController,
                                    thickness: 12,
                                    isAlwaysShown: true,
                                    child: SingleChildScrollView(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Center(
                                                child: CircleAvatar(
                                              backgroundImage:
                                                  NetworkImage(mypost['image']),
                                              radius: size.height * 0.08,
                                            )),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Yemek Adı:\t',
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontSize: 22,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    "${mypost['name']}",
                                                    style: TextStyle(
                                                        fontSize: 22,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ]),
                                            SizedBox(height: 5),
                                            Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Malzemeler:\t',
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontSize: 22,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    "${mypost['tarif']}",
                                                    style: TextStyle(
                                                        fontSize: 22,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ]),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              );
      },
    );
  }
}
