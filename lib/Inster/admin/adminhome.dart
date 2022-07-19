import 'package:flutter/material.dart';
import 'package:yourchat/Inster/admin/orderqr.dart';
 import 'package:yourchat/Inster/admin/tabcontents/calling.dart';
import 'package:yourchat/Inster/admin/tabcontents/orders.dart';
import 'package:yourchat/Inster/admin/tabcontents/pickedup.dart';
 
class AdminHome extends StatefulWidget {
  AdminHome({Key key}) : super(key: key);

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
   return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: (){
              Navigator.push<void>(
    context,
    MaterialPageRoute<void>(
      builder: (BuildContext context) =>   HomeScreen(),
    ),
  );
            }, icon: Icon(Icons.qr_code_2))
          ],
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
              Tab(
                child: Column(
                  children: <Widget>[
                    Icon(Icons.new_releases),
                    Text('New order')
                  ],
                ),
              ),
              Tab(
                child: Column(
                  children: <Widget>[
                    Icon(Icons.speaker),
                    Text('Calling')
                  ],
                ),
              ),
              Tab(
                child: Column(
                  children: <Widget>[Icon(Icons.done_all), Text('Delivered')],
                ),
              ),
            ],
          ),
          title: Text('Buttler Admin Module '),
        ),
        body: TabBarView(
          children: [
            Orders(),
            Calling(),
            Pickup(),
          ],
        ),
      ),
    );
  }
}

