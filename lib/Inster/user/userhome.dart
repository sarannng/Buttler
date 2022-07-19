import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:vibration/vibration.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:yourchat/Inster/user/orderstatus.dart';

class UserHome extends StatefulWidget {
  UserHome({Key key}) : super(key: key);

  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  final text1 = TextEditingController();
  String qr = "";
  @override
  Widget build(BuildContext context) {
    Future<void> openScanner() async {
      
      String cameraScanResult = await scanner.scan();

      print(cameraScanResult);

      if (cameraScanResult != null) {
        Navigator.push<void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) =>
                Orderstatus(orderdoc: cameraScanResult),
          ),
        );
      }
    }

    String token() {
      var rndnumber = "";
      var rnd = new Random();
      for (var i = 0; i < 6; i++) {
        rndnumber += rnd.nextInt(9).toString();
      }
      return rndnumber;
    }

    void generateQR() {
      var docID =
          Firestore.instance.collection('/orders').document().documentID;

      setState(() {
        qr = docID;
      });
      Firestore.instance.collection('/orders').document(docID).setData({
        'text': text1.text,
        'token': token(),
        'timestamp': DateTime.now(),
        'calls': 0,
        'trigger': false
      });
    }

    Future<void> vibration() async {
      if (await Vibration.hasCustomVibrationsSupport()) {
        for (int i = 0; i < 10; i++) {
          print("in");
          Vibration.vibrate(duration: 100);
          await Future.delayed(Duration(milliseconds: 150));
        }
      } else {
        Vibration.vibrate();
        await Future.delayed(Duration(milliseconds: 500));
        Vibration.vibrate();
      }
    }

    void updateqr() {
      setState(() {
        qr = text1.text;
      });
    }

    @override
    void initState() {
      updateqr();
      super.initState();
    }

    return Scaffold(
      body: Container(
        color: Color.fromRGBO(3, 80, 111, 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Fancy *ss",
                    style: GoogleFonts.poppins(
                        fontSize: 48,
                        color: Color.fromRGBO(255, 227, 216, 1),
                        fontWeight: FontWeight.w500))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Restaurant",
                  style: GoogleFonts.poppins(
                      fontSize: 15, color: Color.fromRGBO(255, 227, 216, 1)),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "and fine dining",
                  style: GoogleFonts.poppins(
                      fontSize: 15, color: Color.fromRGBO(187, 187, 187, 1)),
                )
              ],
            ),
           
           SizedBox(height: 39,),
            Container(
              //padding: EdgeInsets.fromLTRB(50, 20, 50, 20),
              decoration: BoxDecoration(
                shape: BoxShape.circle
              ),
              child: InkWell(
                onTap: () async {
                  var status = await Permission.camera.status;
      if (status.isDenied ||
          status.isRestricted ||
          status.isLimited ||
          status.isUndetermined) {
        Permission.camera.request();
      }
    if(status.isGranted){
      
                  openScanner();
    }

                },
                child: new Container(
                  //width: 100.0,
padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
                  height: MediaQuery.of(context).size.width/5,
                  decoration: new BoxDecoration(
                  // shape:  BoxShape.circle,
                    color: Color.fromRGBO(255, 227, 216, 1),
                    //   border: new Border.all(color: Colors.white, width: 2.0),
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                  child: Container(
                     child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Open Scanner",
                          style: GoogleFonts.poppins(
                              fontSize: 20,
                              color: Color.fromRGBO(10, 4, 60, 1)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
