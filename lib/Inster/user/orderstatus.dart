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
  Color orderstatuscol = Colors.yellow.shade800;

  Future<void> invokevibrate() async {
    if (await Vibration.hasCustomVibrationsSupport()) {
      for (int i = 0; i < 10; i++) {
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
    FirebaseFirestore.instance
        .collection('orders')
        .doc('${widget.orderdoc}')
        .snapshots(includeMetadataChanges: true)
        .listen((event) {
      setState(() {
        name =    event.data()['token'];
      });

      if (event.data()['trigger'] == true) {
        setState(() {
          status = ' Order Ready';
          orderstatuscol = Colors.green;
        });
        invokevibrate();
      }
      print(event.data()['trigger']);
    });
  }

  @override
  void initState() {
    //testing
    fun();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
       padding: EdgeInsets.all(20),
               color: Color.fromRGBO(3, 80, 111, 1),        
               child: Container(
                
                     decoration: BoxDecoration(
                       color: Colors.white,
                   borderRadius: BorderRadius.circular(25)
                 ),
                 child: Column(
                   
                   crossAxisAlignment: CrossAxisAlignment.stretch,
                     
                    children: [
                      Expanded(child: Container(
                       
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                           children: [
Container(
  child: Column(
    children: [                           Text('Order Status', style: TextStyle(color: Colors.black45, fontSize: 33, fontWeight: FontWeight.bold),),
                         
                                      SizedBox(height: 19,),
                            Image.network(
              'https://cdn.pixabay.com/photo/2018/08/30/16/57/coffee-3642712_960_720.png',
              height: 200,
              width: 200,
            ), 
             Divider(color: Colors.black, thickness: 3,),
            
            ],


            
  ),
),
                         

                            
Center(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment:  CrossAxisAlignment.center,
          children: [
           
            
           
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Token:',
                style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 16)),
              
              Text('$name',  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 22))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Order status:  ',
              style: TextStyle(
                  // color: Colors.yellow.shade800,
                  // color: Colors.red.shade500,
                  color: orderstatuscol,
                     fontWeight: FontWeight.bold,
                  fontSize: 28),
            ),
            Text(
              '$status:  ',
              style: TextStyle(
                  // color: Colors.yellow.shade800,
                  // color: Colors.red.shade500,
                  color: orderstatuscol,
                     fontWeight: FontWeight.bold,
                  fontSize: 28),
            )
          ],
        ),
     
        ),
  


                          ],
                        ),
                      ))
                    ],),  
               ),

            ));
  }
}



