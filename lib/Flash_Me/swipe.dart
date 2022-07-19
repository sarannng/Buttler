import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Swipe extends StatefulWidget {
  Swipe({Key  key}) : super(key: key);

  @override
  State<Swipe> createState() => _SwipeState();
}



class _SwipeState extends State<Swipe> {
  @override



  String solution = "default";
  BuildContext scaffoldContext;
  int index = 0;
  String appbartitle = " ";
 

  @override
  void initState() {
    getSolution(0);
    super.initState();
    
  }
 
    void getSolution( int ind ){
            FirebaseFirestore.instance.collection("testcode").where("pk", isEqualTo: ind ).snapshots().listen((event) { 
        print(ind);
        setState(() {
        solution = event.docs.first.data()["data"];
        appbartitle = event.docs.first.data()["title"];
        });

  //index++;
       });
    }

    void onTapPressed(String display){
print("pressed");
      getSolution(index++);
       

      
      setState(() {
        solution = display;
      });
      
    }

 void onLongPressed(String display){
      setState(() {
        solution = display;
      });
    }

     void onDoubleTap(String display){
      setState(() {
        solution = display;
      });
    }

  
void createSnackBar(String message) {                                                                               
    var snackBar = SnackBar(content: Text(message), duration: Duration(milliseconds: 600),);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);                                                          
  }  

  Widget build(BuildContext context) {
 


    return new Scaffold(
      appBar: AppBar(centerTitle: true, title: Text(appbartitle, style: TextStyle(color: Colors.white, fontWeight :FontWeight.w400),)),

      body: Container(child: Column(
        children: [

        Expanded( 
          
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              // color: Colors.amber
            ),
          child: InkWell(
            onTap: () async {
              onTapPressed("This is on Tap");
              createSnackBar("Next Question");
              print("Taped");

              
    await  FirebaseFirestore.instance.collection('testcode').where('pk', isEqualTo: 0).get().then((value) => ( ){
        // setState(() async {
        // //solution = await value.docs.first.data()['data'];
        //   print(value.size);
        // }); 
        print(value.size);
      });
            },

            onLongPress: () {
              onLongPressed("This is long pressed");
            debugPrint("lg");
              createSnackBar("Added for review");
            },

            onDoubleTap: (){
              onDoubleTap("This is on double tapped");
              
              createSnackBar("Got the concept");
            },
             child: Container(
             margin: EdgeInsets.all(10),
             padding: EdgeInsets.all(10),
             decoration: BoxDecoration(
              color: Color.fromRGBO(100, 2, 5, 1) ,
              borderRadius: BorderRadius.circular(30)
             ),
           child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Center(child: Text(solution, style: TextStyle( color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400 ),) ),
          ],),
          ))),),


          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
            Container(
              decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(30)
             ),
              
              height: MediaQuery.of(context).size.width/10,
              width: MediaQuery.of(context).size.width/10,
            child: Center(child: Text("C++" ,  style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w400),),),),

             Container(
              decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(30)
             ),
              height: MediaQuery.of(context).size.width/10,
              width: MediaQuery.of(context).size.width/10,
            child: Center(child: Text("Python",style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w400),),),),

              Container(
                decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(30)
             ),
               
              height: MediaQuery.of(context).size.width/10,
              width: MediaQuery.of(context).size.width/10,
            child: Center(child: Text("Java" , style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w400),),),),


          ],)

          // Container(color: Colors.black,
          // child: Container(child: Text("test"),),)
        ],
      ),),
    );
  }
} 