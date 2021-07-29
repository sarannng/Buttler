import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

class Orderstatus extends StatefulWidget {
  Orderstatus({Key key, this.orderdoc}) : super(key: key);

  final String orderdoc;

  @override
  _OrderstatusState createState() => _OrderstatusState();
}

class _OrderstatusState extends State<Orderstatus> {

String name;
String status = "We are preparing";
  
 Future<void> invokevibrate() async {
       if (await Vibration.hasCustomVibrationsSupport()) {
  for(int i=0; i<10; i++){
  print("in");
    Vibration.vibrate(duration: 200);
  await Future.delayed(Duration(milliseconds: 500));
  }
} else {
    Vibration.vibrate();
    await Future.delayed(Duration(milliseconds: 500));
    Vibration.vibrate();
}
    }

Future<void> fun() async {
  await Firebase.initializeApp();
   print('ot'); 
        FirebaseFirestore.instance.collection('orders').doc('${widget.orderdoc}').
        snapshots(includeMetadataChanges: true)
        .listen((event) {

          setState(() {
          name = event.data()['token'];
          });
           
        if(event.data()['trigger'] == true){
          setState(() {
            status = ' Order Ready';
          });
          invokevibrate();
        }
        print(event.data()['trigger']);
        });
  
}

@override
void initState()  { 
   //testing
     fun();
  super.initState();
  
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Container(
         child: Center(
           child: Text("$name"+ ": " + "$status " ),
         ),
       ),
    );
  }
}