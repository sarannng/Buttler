import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:yourchat/Flash_Me/swipe.dart';
 

class ListPage extends StatefulWidget {
  ListPage({Key  key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Title"),),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, 
          children: [

           Row(mainAxisAlignment: MainAxisAlignment.end, children: [ Container(
            margin: EdgeInsets.fromLTRB(0, 5, 5, 5),
            child: Badge(
              child: 
              
              InkWell(onTap: () {
  
               Navigator.push<void>(
    context,
    MaterialPageRoute<void>(
      builder: (BuildContext context) =>  Swipe(),
    ),
  );
               },),
                  padding: EdgeInsets.all(4), 
              toAnimate: false,
              shape: BadgeShape.square,
              badgeColor: Colors.red,
              borderRadius: BorderRadius.circular(8),
              badgeContent: Text('Swpie Mode', style: TextStyle(color: Colors.white, fontSize: 16)),
    ), )],),
 
           Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text("Array 75", style: TextStyle(color: Colors.black87 , fontSize: 25, fontWeight: FontWeight.w500),)],),

               Expanded(child:    ListView.builder(
  // Let the ListView know how many items it needs to build.
  itemCount: 3,
  // Provide a builder function. This is where the magic happens.
  // Convert each item into a widget based on the type of item it is.
  itemBuilder: (context, index) {
    //final item = items[index];

    return  Container(
//     margin: EdgeInsets.fromLTRB(60, 10, 60, 0), 
       margin: EdgeInsets.fromLTRB(5, 10, 5, 0), 

      decoration: BoxDecoration(color: Colors.black   , borderRadius: BorderRadius.circular(10)),
     padding: EdgeInsets.all(1),
     
      child: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),

        child: ListTile(
      title: Text("Letter combinations of a phone number", style: TextStyle(color: Colors.blueAccent , fontSize: 16, fontWeight: FontWeight.w500),),
      leading:    
             
              Container(
                  
                child:  Badge(
                  padding: EdgeInsets.all(4), 
              toAnimate: false,
              shape: BadgeShape.square,
              badgeColor: Colors.green,
              borderRadius: BorderRadius.circular(8),
              badgeContent: Text('BADGE', style: TextStyle(color: Colors.white, fontSize: 10)),
    ), ),


             subtitle: Text("Recurrsion") ,
             trailing: Icon(Icons.accessibility_sharp),
          ),
             
      
      ),
    );
  },
),)
        
        ],),
      ),
    );
  }
}