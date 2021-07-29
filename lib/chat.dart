import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
  
}

class _ChatState extends State<Chat> {
  final text= TextEditingController();
  void senddata() {
    Firestore.instance
        .collection('books')
        .document()
        .setData({'title': 'title', 'author': '${text.text}',
           
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/s.jpg'), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: <Widget>[
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection('books').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError)
                    return new Text('Error: ${snapshot.error}');
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return new Text('Loading...');
                    default:
                      // return new ListView(
                      //   children: snapshot.data.documents
                      //       .map((DocumentSnapshot document) {
                      //     return new ListTile(
                      //       title: Container(
                      //         padding: EdgeInsets.all(5),
                              
                              
                               
                      //         decoration: BoxDecoration(
                      //             color: Color.fromRGBO(255, 209, 201, 1),
                      //             borderRadius: BorderRadius.circular(20)),
                      //         child: 
                              
                      //         Container(
                      //           width: 66,
                      //           child: Text(
                      //             document['author'],
                      //             textAlign: TextAlign.right,
                      //             style: TextStyle(fontWeight: FontWeight.w400),
                      //           ),
                      //         ),



                              
                      //       ),
                      //       subtitle: new Text(
                      //         '11:11',
                      //         textAlign: TextAlign.right,
                      //       ),
                      //     );
                      //   }).toList(),
                      // );
                 
                  return ListView.builder(
                    itemCount: snapshot.data.documents.length,
                     itemBuilder: (context, int  index){
                    return  ListTile(
                      title:
                         Container(
                         
                              padding: EdgeInsets.all(5),    
                              
                              
                               
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(255, 209, 201, 1),
                                  borderRadius: BorderRadius.circular(20)),
                              child: 
                              
                              Container(
                                  
                                child: Text(
                                  snapshot.data.documents[index].data()['author'],
                                  textAlign: TextAlign.right,
                                  style: TextStyle(fontWeight: FontWeight.w400 , ),
                                ),
                              ),



                              
                            ),
                    );
                  });
                 
                 
                  }
                },
              ),
            ),

            // Expanded(
            //   flex: 2,
            //    child: Center(
            //      child: RaisedButton(onPressed: (){
            //      senddata();
            //    }),
            //    )
            //     ),

            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(23),
                color: Colors.white,
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          
                          cursorColor: Colors.black26 ,
                          controller: text,
                          
                          decoration: InputDecoration(
                            border: InputBorder.none,
                                  hintText: 'Type here...',  
                             disabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      RawMaterialButton(
                        onPressed: () {
                           print(DateTime.now().toLocal().hour );
                           print( DateTime.now().toLocal().minute  );
                          senddata();},
                        elevation: 2.0,
                        fillColor: Colors.red,
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                          size: 20.0,
                        ),
                        padding: EdgeInsets.all(15.0),
                        shape: CircleBorder(),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
