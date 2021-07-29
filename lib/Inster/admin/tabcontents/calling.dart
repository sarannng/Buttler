import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Calling extends StatefulWidget {
  Calling({Key key}) : super(key: key);

  @override
  _CallingState createState() => _CallingState();
}

class _CallingState extends State<Calling> {
 String ordersdocid;
  String bookedAt;
    int calls ;
    Timestamp deliveredAt;
    String token;
  void calling(String did){
      FirebaseFirestore.instance.collection('orders').doc(did).update({
        'trigger': true,
      } );

      Future.delayed(Duration(microseconds: 300));
   
      FirebaseFirestore.instance.collection('orders').doc(did).update({
        'trigger': false,
      } );
   }

  void sendIdToDelivered(String docid , String callingdocid){
    
   

    var ordata = FirebaseFirestore.instance.collection('orders').doc(docid).snapshots();
  ordata.listen((value) => () {
    setState(() async {
      
         bookedAt=  await value.data()['timestamp'];
         calls  = await value.data()['called'];
         deliveredAt  =   DateTime.now() as Timestamp ;
         token =  await value.data()['token'] ;

           FirebaseFirestore.instance.collection('delivered').doc().set({
        'bookedAt' : bookedAt,
        'calls': calls,
        'deliveredAt': deliveredAt,
        'token': token
    });
    
    
    // delete the order from orders and calling collection


    FirebaseFirestore.instance.collection('orders').doc(docid).update({
      'token' : 'ORDER DELIVERED'
    });

 FirebaseFirestore.instance.collection('calling').doc(callingdocid).delete();
    

    Future.delayed(Duration(seconds:30 ));


    FirebaseFirestore.instance.collection('orders').doc(docid).delete();

    
    });
  } );

  
   

  }

  

@override
  void initState() {



     super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Container(
         child:  StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('/calling').orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return new Text('Loading...');
                  default:  
                    return new Card(
                      color: Colors.redAccent,
                      child: ListView(
                      children: snapshot.data.documents
                          .map((DocumentSnapshot document) {
                            
                        return new ListTile(
                          onLongPress: (){
                             FirebaseFirestore.instance.collection('calling').doc(document.id).get().then((value) async {
                              var docid = await value.data()['docid'];
                              // this docid is callingdocid
                             sendIdToDelivered(document.id, docid);
                            });
                            
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
                    ),
                    );
                }
              },
            ),


       ),
    );
  }
}