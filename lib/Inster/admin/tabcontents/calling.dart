import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Calling extends StatefulWidget {
  Calling({Key key}) : super(key: key);

  @override
  _CallingState createState() => _CallingState();
}

class _CallingState extends State<Calling> {
 String ordersdocid;
  void calling(String did){
      FirebaseFirestore.instance.collection('orders').doc(did).update({
        'trigger': true,
      } );

      Future.delayed(Duration(microseconds: 300));
   
      FirebaseFirestore.instance.collection('orders').doc(did).update({
        'trigger': false,
      } );
   }

  void sendIdToDelivered(String docid){
    FirebaseFirestore.instance.collection('delivered').doc().set({
        docid: docid
    });

  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Container(
         child:  StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('/calling')
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
                            sendIdToDelivered(document.id);
                          },

                          title: Text(document['token'], style: TextStyle(color: Colors.black, fontSize: 40),),
                        trailing: IconButton(onPressed: ( ){
                            FirebaseFirestore.instance.collection('calling').doc(document.id).get().then((value) {
                              var docid = value.data()['docid'];
                              calling(docid); 
                            });
                            
                        }, icon: Icon(Icons.call)),
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