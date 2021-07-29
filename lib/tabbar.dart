
import 'package:flutter/material.dart';
import 'package:yourchat/chat.dart';

class Tabbar extends StatefulWidget {
  @override
  _TabbarState createState() => _TabbarState();
}

class _TabbarState extends State<Tabbar> {
  @override
 Widget build(BuildContext context) {
     return MaterialApp(
      home: DefaultTabController(
                          length: 3,
        child: Scaffold(
          appBar: AppBar(
            
            flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.red[900],
                Colors.red[800],
                Colors.red[400],
              ],
            ),
          ),
        ),
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.chat), text: 'Chat',),
                Tab(icon: Icon(Icons.timeline) ,text: 'Timeline',),
                Tab(icon: Icon(Icons.photo_album), text: 'Gallery',),
              ],
            ), 
            title: Text('Sana & Sarang'),
            centerTitle: true,
          ),
          body: TabBarView(
            children: [
              Icon(Icons.directions_car), 
             // Chat(),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
            ],
          ),
        ),
      ),
    );
  }
}


