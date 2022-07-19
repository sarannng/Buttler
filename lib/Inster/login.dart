import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vibration/vibration.dart';
import 'package:yourchat/Flash_Me/home.dart';
import 'package:yourchat/Flash_Me/swipe.dart';
import 'package:yourchat/Inster/admin/adminhome.dart';

import 'user/userhome.dart';
   
class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
 // this code has nothing to do with login functionality its here for calling testing purpose- code start
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

// Future<void> fun() async {
//   await Firebase.initializeApp();
//    print('ot'); 
//         FirebaseFirestore.instance.collection('orders').doc('Bb6zBHcv8tnFFFg310wv').
//         snapshots(includeMetadataChanges: true)
//         .listen((event) {
//         if(event.data()['trigger'] == true){
//           invokevibrate();
//         }
//         print(event.data()['trigger']);
//         });
  
// }

 // this code has nothing to do with login functionality its here for calling testing purpose- code ends

@override
void initState()  { 
   //testing the calling functionality- for testing remove comments from below fun() function call.
    // fun();
  super.initState();
  
}


  @override
  Widget build(BuildContext context) {

   


     

    return Scaffold(
        body: Container(
          //  color: Color.fromRGBO( 232, 80, 91 , 1),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                
                colors: [
                  Colors.red[900],
                  Colors.red[800],
                  Colors.red[400],
                ],
              ),
            ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Buttler", style: GoogleFonts.poppins(fontSize: 48, color: Color.fromRGBO(243,236,194, 1), fontWeight:FontWeight.w500))
                ,Icon(Icons.touch_app, color:  Color.fromRGBO(20,177,171, 1),)
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Queue", style: GoogleFonts.poppins(fontSize: 15, color: Color.fromRGBO(255,227,216, 1)),),
                SizedBox(width: 5,),
                Text("organizer", style: GoogleFonts.poppins(fontSize: 15, color: Color.fromRGBO(187,187,187, 1)),)



             
              ],
            ),

SizedBox(height: 10,),
  //1st textfield 

    Container(
      padding: EdgeInsets.fromLTRB(40, 5, 40, 5),
      child: 
            TextField(
              style: GoogleFonts.poppins(fontSize: 20, color: Color.fromRGBO(255,227,216, 0.8)),
              decoration: InputDecoration(
                fillColor: Color.fromRGBO(255,227,216, 0.5),
                focusColor: Color.fromRGBO(255,227,216, 0.5),
                hintText: "Username",
                hintStyle: GoogleFonts.poppins(fontSize: 20, color: Color.fromRGBO(255,227,216, 0.5))
              ),
            ),),


SizedBox(height: 10,),

              Container(
      padding: EdgeInsets.fromLTRB(40, 5, 40, 5),
      child: 
            TextField
            (
               style: GoogleFonts.poppins(fontSize: 20, color: Color.fromRGBO(255,227,216, 0.8)),
              obscureText: true,
              decoration: InputDecoration(
                hintText: "password",
                
                hintStyle: GoogleFonts.poppins(fontSize: 20, color: Color.fromRGBO(255,227,216, 0.5))
              ),
            ),),

      
SizedBox(height: 10,),


 
Container(
  padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
  child: InkWell(
  
  onTap: () async {
  print("hellp");
   //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AdminHome()));
 Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Swipe() ));
    //invokevibrate();
    //fun();
 
  },
  child: new Container(
    //width: 100.0, 
   
    height: 40.0,
    decoration: new BoxDecoration(
      color: Color.fromRGBO(255,227,216, 1),
   //   border: new Border.all(color: Colors.white, width: 2.0),
      borderRadius: new BorderRadius.circular(10.0),
    ),
    child: new Center(child: Text("Admin", style:GoogleFonts.poppins(fontSize: 20, color: Color.fromRGBO(10,4,60, 1)) ,),),
  ),
),
   
),    




  Center(
    child: Text("OR", style: GoogleFonts.poppins(fontSize: 25, color: Color.fromRGBO(243,236,194, 1), fontWeight:FontWeight.w500)),
  ),




Container(
  padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
  child: InkWell(
  
  onTap: () async {
  print("hellp");
   Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => UserHome()));
    //invokevibrate();
    //fun();
 
  },
  child: new Container(
    //width: 100.0, 
   
    height: 40.0,
    decoration: new BoxDecoration(
      color: Color.fromRGBO(255,227,216, 1),
   //   border: new Border.all(color: Colors.white, width: 2.0),
      borderRadius: new BorderRadius.circular(10.0),
    ),
    child: new Center(child: Text("User", style:GoogleFonts.poppins(fontSize: 20, color: Color.fromRGBO(10,4,60, 1)) ,),),
  ),
),
   
),    



            ],
          )
 ,
        ),
    
    );
  }
}