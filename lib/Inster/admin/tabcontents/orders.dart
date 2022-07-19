import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
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
        'token': token,
        'timestamp' : DateTime.now()
    });


  }
@override
void initState() { 
 Firebase.initializeApp();
  super.initState();
  
}
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Container(
         child:  StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('/orders').orderBy('timestamp', descending: true )
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return new Text('Loading...');
                  default:  
                    return new Container(
                      padding: EdgeInsets.all(10),
                      child: ListView(
                      children: snapshot.data.documents
                          .map((DocumentSnapshot document) {
                            
                        return new  Container(
                                                    margin: EdgeInsets.only(top: 12),

                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(20),
                             border: Border.all(color: Colors.black26, width: 1)
                           ),
                          child: ListTile(
                          
                          onLongPress: (){
                            sendIdToCalling(document.id,document['token']);
                          },

                          leading: Text(document['token'], style: TextStyle(color: Colors.black, fontSize: 40),),
                         title: Text(document['timestamp'].toString()),
                           subtitle: Row(children: [
                             Text('User Id ' +document['text']),
                           ],),

                           trailing:   Text(document['calls'].toString(), style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 28),)
                           ,
                          // trailing: new Image.network(document['qr'],
                          // ),
                          //trailing: Image.network(document['img']),
                        ),
                        );
                      
                      
                      }).toList(),
                    ) 
             ,
                    );   }
              },
            ),


       ),
    );
  }
}