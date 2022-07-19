import 'package:flutter/material.dart';
import 'package:yourchat/Flash_Me/listpage.dart';
 
class HomePage extends StatefulWidget {
  HomePage({Key  key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:  AppBar(  centerTitle: true,  actions: [], title:  Text("Flash Me"),  ),
      drawer: Drawer(
      child: Center(
        child: Column(  
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('This is the Drawer'),
            // ElevatedButton(
            //   //onPressed: _closeDrawer,
            //   child: const Text('Close Drawer'),
            // ),
          ],
        ),
      ),
    ),
    body: Container(child: Column(
      children: [

        // Row 1 start 
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //Card 1 begin
           Container(
            height: MediaQuery.of(context).size.height/4,
            width: MediaQuery.of(context).size.height/4,
            decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(41),
                gradient: LinearGradient(colors: [Colors.red, Colors.red.shade300])
              ),
            child:Container(
              //color: Colors.green ,
              //shadowColor: Colors.black45,
              child: InkWell(
                onLongPress: () {
                  print("test");
                },
                onTap:  () {
                  Navigator.push<void>(
    context,
    MaterialPageRoute<void>(
      builder: (BuildContext context) =>  HomePage() ,
    ),
  );
                },
                child: Container(
                  
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                         Text("Arrays", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 27),),
                         
                        ],
                      ), 
                      

                        SizedBox(height: 8,),

                        Text("12", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 20),)
                    ],
                  ),
 
                ), 
              )
            ),
          ), 


            // Card 1 end
            // Card 2 begin
       
          Container(
            height: MediaQuery.of(context).size.height/4,
            width: MediaQuery.of(context).size.height/4,
            decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(41),
                gradient: LinearGradient(colors: [Colors.green, Colors.greenAccent])
              ),
            child:Container(
              //color: Colors.green ,
              //shadowColor: Colors.black45,
              child: InkWell(
                onTap:  () {
                  Navigator.push<void>(
    context,
    MaterialPageRoute<void>(
      builder: (BuildContext context) =>  ListPage() ,
    ),
  );
                },
                child: Container(
                  
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                         Text("Arrays", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 27),),
                         
                        ],
                      ), 
                      

                        SizedBox(height: 8,),

                        Text("12", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 20),)
                    ],
                  ),
 
                ), 
              )
            ),
          ), 


        ],)
      ,
        // Row 1 end

        SizedBox(height: 40,),
        // Row 2 start
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //Card 1 begin
           Container(
            height: MediaQuery.of(context).size.height/4,
            width: MediaQuery.of(context).size.height/4,
            decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(41),
                gradient: LinearGradient(colors: [Colors.purple, Colors.purpleAccent])
              ),
            child:Container(
              //color: Colors.green ,
              //shadowColor: Colors.black45,
              child: InkWell(
                onTap:  () {
  //                 Navigator.push<void>(
  //   context,
  //   MaterialPageRoute<void>(
  //     builder: (BuildContext context) =>  MyHomePage(title: "title") ,
  //   ),
  // );
                },
                child: Container(
                  
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                         Text("Arrays", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 27),),
                         
                        ],
                      ), 
                      

                        SizedBox(height: 8,),

                        Text("12", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 20),)
                    ],
                  ),
 
                ), 
              )
            ),
          ), 


            // Card 1 end
            // Card 2 begin
       
          Container(
            height: MediaQuery.of(context).size.height/4,
            width: MediaQuery.of(context).size.height/4,
            decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(41),
                gradient: LinearGradient(colors: [Colors.orange, Colors.yellow.shade500])
              ),
            child:Container(
              //color: Colors.green ,
              //shadowColor: Colors.black45,
              child: InkWell(
                onTap:  () {
  //                 Navigator.push<void>(
  //   context,
  //   MaterialPageRoute<void>(
  //     builder: (BuildContext context) =>  MyHomePage(title: "title") ,
  //   ),
  // );
                },
                child: Container(
                  
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                         Text("Arrays", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 27),),
                         
                        ],
                      ), 
                      

                        SizedBox(height: 8,),

                        Text("12", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 20),)
                    ],
                  ),
 
                ), 
              )
            ),
          ), 


        ],)
      

        //Row 2 end
      
      ],
    ),),
    );
  }
}