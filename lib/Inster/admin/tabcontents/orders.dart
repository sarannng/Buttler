import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  Orders({Key key}) : super(key: key);

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<TextEditingController> flexContainer1 = new List(); 

int flexc1 = 0;
  int flexc2;

  void sendIdToCalling(String docid, String token){
    FirebaseFirestore.instance.collection('calling').doc().set({
        'docid': docid,
        'token': token
    });


  }

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Container(
         child:  StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('/orders')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return new Text('Loading...');
                  default:  
                    return new ListView(
                      children: snapshot.data.documents
                          .map((DocumentSnapshot document) {
                            
                        return new ListTile(
                          onLongPress: (){
                            sendIdToCalling(document.id,document['token']);
                          },

                          title: Text(document['token'], style: TextStyle(color: Colors.black, fontSize: 40),),
                         // subtitle: Text(document['trigger'].toString()),
                          // trailing: new Image.network(document['qr'],
                          // ),
                          //trailing: Image.network(document['img']),
                        );
                      
                      
                      }).toList(),
                    );
                }
              },
            ),


       ),
    );
  }
}