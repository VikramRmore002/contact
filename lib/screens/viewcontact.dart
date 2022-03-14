import 'package:flutter/material.dart';
import 'addcontact.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:url_launcher/url_launcher.dart';
import 'editcontact.dart';
import 'package:fireapp/model/contact.dart';
import 'package:fireapp/model/contact.dart';
import 'home.dart';



class viewContact extends StatefulWidget {
  final String id;
  const viewContact( this.id,   {Key key}) : super(key: key);

 // final  String id;
 // viewContact(this.id);

  @override
  _viewContactState createState() => _viewContactState(id);
}

class _viewContactState extends State<viewContact> {

  DatabaseReference _databaseReference = FirebaseDatabase.instance.reference();
  String id;
  _viewContactState(this.id);
  bool isLoading = true;
 Contact _contact;
  getContact(id)async{
    _databaseReference.child(id).onValue.listen((event) {
      setState(() {
       _contact = Contact.fromSnapshot(event.snapshot);
       isLoading = false;
      });
    });
  }
 @override
 void initState() {
    // TODO: implement initState
    super.initState();
    getContact(id);
  }
callAction(String number) async{
    String url ='tel:$number';
    if(await canLaunch(url)){
      await launch(url);
    }else{
      throw "could not call $number";
    }
}
  smsAction(String number) async{
    String url ='sms:$number';
    if(await canLaunch(url)){
      await launch(url);
    }else{
      throw "could not send  sms on this  $number";
    }
  }
  deleteContact(){
    showDialog(context: context, builder: (BuildContext context)
    {
      return AlertDialog(
        title: Text("Delete"),
        content: Text("Delete Contact"),
        actions:  <Widget>[
          TextButton(onPressed: () {
            Navigator.pop(context);
          }, child: const Text("Cancel",style: TextStyle(
              fontSize: 20.0,fontWeight: FontWeight.w500
          ),)),
          TextButton(onPressed: () async {
            Navigator.pop(context);
            await _databaseReference.child(id).remove();
            navigatetoLastScreen();
          }, child: const Text("ok",style: TextStyle(
              fontSize: 20.0,fontWeight: FontWeight.w500
          ),)),
        ],

      );
    });
    }



  navigatetoLastScreen(){
    Navigator.pop( context);
  }
  navigateToeditScreen(id){
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return editContact(id);
    }));
  }

@override
Widget build(BuildContext context) {
  // wrap screen in WillPopScreen widget
  return Scaffold(
    appBar: AppBar(
      title: Text("View Contact",style: TextStyle(
          fontSize: 25.0,fontWeight: FontWeight.w500
      ),),
    ),
    body: Container(
      child: isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : ListView(
        children: <Widget>[
          // header text container
          Container(
              height: 200.0,
            child: Container(
              width: 100.0,
              height: 100.0,
              decoration:  BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: _contact.photoUrl == "empty" ?
                    const AssetImage("images/logo.png") :
                    NetworkImage(_contact.photoUrl) as ImageProvider ,
                  )
              ),
            ),),
          //name
          Card(
            elevation: 2.0,
            child: Container(
                margin: EdgeInsets.all(20.0),
                width: double.maxFinite,
                child: Row(
                  children: <Widget>[
                    const Icon(Icons.perm_identity),
                    Container(
                      width: 10.0,
                    ),
                    Text(
                      "${_contact.firstName} ${_contact.lastName}",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ],
                )),
          ),
          // phone
          Card(
            elevation: 2.0,
            child: Container(
                margin: EdgeInsets.all(20.0),
                width: double.maxFinite,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.phone),
                    Container(
                      width: 10.0,
                    ),
                    Text(
                      _contact.phone,
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ],
                )),
          ),
          // email
          Card(
            elevation: 2.0,
            child: Container(
                margin: EdgeInsets.all(20.0),
                width: double.maxFinite,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.email),
                    Container(
                      width: 10.0,
                    ),
                    Text(
                      _contact.email,
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ],
                )),
          ),
          // address
          Card(
            elevation: 2.0,
            child: Container(
                margin: EdgeInsets.all(20.0),
                width: double.maxFinite,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.home),
                    Container(
                      width: 10.0,
                    ),
                    Text(
                      _contact.address,
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ],
                )),
          ),
          // call and sms
          Card(
            elevation: 2.0,
            child: Container(
                margin: EdgeInsets.all(20.0),
                width: double.maxFinite,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    IconButton(
                      iconSize: 30.0,
                      icon: Icon(Icons.phone),
                      color: Colors.red,
                      onPressed: () {
                        callAction(_contact.phone);
                      },
                    ),
                    IconButton(
                      iconSize: 30.0,
                      icon: Icon(Icons.message),
                      color: Colors.red,
                      onPressed: () {
                        smsAction(_contact.phone);
                      },
                    )
                  ],
                )),
          ),
          // edit and delete
          Card(
            elevation: 2.0,
            child: Container(
                margin: EdgeInsets.all(20.0),
                width: double.maxFinite,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    IconButton(
                      iconSize: 30.0,
                      icon: Icon(Icons.edit),
                      color: Colors.red,
                      onPressed: () {
                        navigateToeditScreen(id);
                      },
                    ),
                    IconButton(
                      iconSize: 30.0,
                      icon: Icon(Icons.delete),
                      color: Colors.red,
                      onPressed: () {
                        deleteContact();
                      },
                    )
                  ],
                )),
          )
        ],
      ),
    ),
  );
}
  }

