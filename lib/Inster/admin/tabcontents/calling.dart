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

void callcount(String docid){
         int inccall;
     FirebaseFirestore.instance.collection('orders').doc(docid).snapshots().listen((value) => (){ 
     inccall = value.data()['calls'];
     print(inccall);
   print("From call count==============================");
});
print(inccall); 

 //cod for call ++ to be implemented
   calling(docid, inccall);
  
 
}

  void calling(String did, int calinc){

 print("This is calling");   
      FirebaseFirestore.instance.collection('orders').doc(did).update({
        'trigger': true,
        //'calls': newcall,
      } );

      Future.delayed(Duration(microseconds: 300));
   
      FirebaseFirestore.instance.collection('orders').doc(did).update({
        'trigger': false,
      } );
   }

  void sendIdToDelivered(String docid , String callingdocid){
    print("This is docid from orders" + docid);
    print("This is docid from calling" + callingdocid);
   

    var ordata = FirebaseFirestore.instance.collection('orders').doc(docid).snapshots();
  ordata.listen((value) => () {

    bookedAt=    value.data()['timestamp'];
         calls  =   value.data()['calls'];
         deliveredAt  =   DateTime.now() as Timestamp ;
         token =    value.data()['token'] ;

        

  } );


   print("Fetched from orders");

           FirebaseFirestore.instance.collection('delivered').doc().set({
        'bookedAt' : bookedAt,
        'calls': calls,
        'deliveredAt': deliveredAt,
        'token': token
    });

    print("sent to delivered");
    
    
    // delete the order from orders and calling collection


    FirebaseFirestore.instance.collection('orders').doc(docid).update({
      'token' : 'ORDER DELIVERED'
    });

    print("Order status delivered updated");

 FirebaseFirestore.instance.collection('calling').doc(callingdocid).delete();
    
    print("calling deleted and wait started");

Future.delayed(const Duration(seconds: 10), () {
print("wait ended and orders deleted;");

    FirebaseFirestore.instance.collection('orders').doc(docid).delete();
});    
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
                    return new Container(
                      padding: EdgeInsets.fromLTRB(85, 0, 90, 0),
                         decoration:  BoxDecoration(
                        //color: Colors.redAccent,
                          ),
                      child: Container(
                        
                         
                        child: ListView(
                      children: snapshot.data.documents
                          .map((DocumentSnapshot document) {
                             
                        return new Container(
                          margin: EdgeInsets.only(top: 12),
                          decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(20),
                             border: Border.all(color: Colors.black26, width: 1)
                           ),
                          child: ListTile(
                          onLongPress: (){
                             FirebaseFirestore.instance.collection('calling').doc(document.id).get().then((value) async {
                              var docid = await value.data()['docid'];
                              // this docid is callingdocid
                             sendIdToDelivered(docid, document.id);
                            });
                            
                          },

                          leading : Text(document['token'], style: TextStyle(color: Colors.black, fontSize: 35),),
                        title: Row(
                          children: [
                            Text('Call'),

                            IconButton( iconSize: 33,  color: Colors.green, onPressed: ( ){
                            FirebaseFirestore.instance.collection('calling').doc(document.id).get().then((value) {
                              var docid = value.data()['docid'];

                              //callcount
                               callcount(docid);
                              // calling(docid, calnic); 
                            });
                            
                        }, icon: Icon(Icons.call)),
                          ],
                        )
                         // subtitle: Text(document['trigger'].toString()),
                          // trailing: new Image.network(document['qr'],
                          // ),
                          //trailing: Image.network(document['img']),
                        ),
                          
                           );
                      
                      
                      }).toList(),
                    ),
               
                      )      );
                }
              },
            ),


       ),
    );
  }
}