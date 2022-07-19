import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:vibration/vibration.dart';
import 'package:yourchat/Inster/user/userhome.dart';
 
class HomeScreen extends StatefulWidget {
    HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final text1 = TextEditingController();
  String qr = "";
  @override
  Widget build(BuildContext context) {
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
      var now = new DateTime.now();
                                            var formatter =
                                                new DateFormat('dd-MM-yyyy');
                                            String ordertime =
                                                DateFormat('kk:mm:a')
                                                    .format(now);
                                            String orderdate =
                                                formatter.format(now);
                                            print(ordertime);
                                            print(orderdate);
      Firestore.instance.collection('/orders').document(docID).setData({
        'text': token(),
        'token': text1.text,
        'timestamp': '$ordertime' ,
        'calls': 0,
        'trigger': false
      });
    }

    Future<void>  vibration() async {
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
                Text("QR Generator",
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
                  "Enter the ",
                  style: GoogleFonts.poppins(
                      fontSize: 15, color: Color.fromRGBO(255, 227, 216, 1)),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "TokenId",
                  style: GoogleFonts.poppins(
                      fontSize: 15, color: Color.fromRGBO(187, 187, 187, 1)),
                )
              ],
            ),

            SizedBox(
              height: 10,
            ),
            //1st textfield

            Container(
              padding: EdgeInsets.fromLTRB(40, 5, 40, 5),
              child: TextField(
                controller: text1,
                style: GoogleFonts.poppins(
                    fontSize: 20, color: Color.fromRGBO(255, 227, 216, 0.8)),
                decoration: InputDecoration(
                    fillColor: Color.fromRGBO(255, 227, 216, 0.5),
                    focusColor: Color.fromRGBO(255, 227, 216, 0.5),
                    hintText: "TokenId",
                    hintStyle: GoogleFonts.poppins(
                        fontSize: 20,
                        color: Color.fromRGBO(255, 227, 216, 0.5))),
              ),
            ),

            SizedBox(
              height: 10,
            ),

            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
              child: InkWell(
                onTap: () async {
                  updateqr();
                  generateQR();
                  //  setState(() {
                  //     qr = text1.text;
                  //  });
                  //   print(text1.text);
                  //   print(text1.value);
                },
                child: new Container(
                  //width: 100.0,

                  height: 40.0,
                  decoration: new BoxDecoration(
                    color: Color.fromRGBO(255, 227, 216, 1),
                    //   border: new Border.all(color: Colors.white, width: 2.0),
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                  child: new Center(
                    child: Text(
                      "Create",
                      style: GoogleFonts.poppins(
                          fontSize: 20, color: Color.fromRGBO(10, 4, 60, 1)),
                    ),
                  ),
                ),
              ),
            ),

//             RaisedButton(
//                 onPressed: (){
// Navigator.push<void>(
//     context,
//     MaterialPageRoute<void>(
//       builder: (BuildContext context) =>   UserHome(),
//      )  );   }            ),

            Container(
              color: Colors.white,
              child: Container(
                padding: EdgeInsets.all(10),
                child: QrImage(
                  data: qr,
                  version: QrVersions.auto,
                  size: 200,
                  gapless: false,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
