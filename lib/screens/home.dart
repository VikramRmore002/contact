import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'addcontact.dart';
import 'viewcontact.dart';
import '../model/contact.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.reference();







  navigateToAddScreen(){
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return  addContact();
    }));
  }

  navigateToviewScreen(String id){
    Navigator.push(context, MaterialPageRoute(builder: (context){

      return  viewContact( id );
      // TODO:add id
    }));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("homepage ",style: TextStyle(
            fontSize: 25.0,fontWeight: FontWeight.w500
        ),
        ),
      ),
      body: Container(
        child: FirebaseAnimatedList(
          query: _databaseReference,
          itemBuilder: (
              BuildContext context ,
              DataSnapshot snapshot ,
              Animation <double>animation,
              int index
              ){
            return GestureDetector(
              onTap: (){navigateToviewScreen(snapshot.key);},
              child: Card(
                color: Colors.white,
                elevation: 2.0,
                child: Container(
                  margin: EdgeInsets.all(10.0),
                  child: Row(
                    children:<Widget> [
                      Container(
                        width: 50.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage( image: snapshot.value["photoUrl"] != "empty" ?
                          NetworkImage(snapshot.value["photoUrl"] ) :
                          const AssetImage("images/logo.png")
                              as ImageProvider)
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget> [ 
                            Text("${snapshot.value["firstname"]} ${snapshot.value["lastname"]}",style: const TextStyle(
                              fontSize: 20.0,fontWeight: FontWeight.w500
                            ),),
                            Text("${snapshot.value["email"]}")
                          ],
                        ),
                        
                      ),
                    ],
                  ),
                ),
            ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToAddScreen,
        child: const Icon(Icons.person_add),
      ),
    );
  }
}
