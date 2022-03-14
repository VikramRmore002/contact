import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fireapp/model/contact.dart';
import 'package:flutter/rendering.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'editcontact.dart';
import 'package:file_picker/file_picker.dart';


class addContact extends StatefulWidget {
  const addContact({Key key}) : super(key: key);

  @override
  _addContactState createState() => _addContactState();
}

class _addContactState extends State<addContact> {

  final DatabaseReference _databaseReference = FirebaseDatabase.instance.reference();
   String  _firstName ="";
   String  _lastName  ="";
   String  _phone     ="";
   String  _email     ="";
   String  _address   ="";
   String  _photoUrl  ="empty";

 saveContact( BuildContext context ) async {
   if( _firstName.isNotEmpty &&
   _lastName.isNotEmpty &&
   _phone.isNotEmpty &&
   _email.isNotEmpty&&
   _address.isNotEmpty &&
   _photoUrl.isNotEmpty
   ){
     Contact contact =Contact(_firstName, _lastName, _phone,_email, _address, _photoUrl);

     await _databaseReference.push().set(contact.toJson());
     navigateToLastScreen(context);
   }else{
     showDialog(context: context, builder: (BuildContext context){
       return AlertDialog(
         title: const Text("field required"),
         content: const Text(" all fields are required"),
         actions: <Widget>[
           TextButton(onPressed: (){
             Navigator.pop(context);
           }, child: const Text("close"))
         ],
       );
     });
   }

 }
  navigateToLastScreen(context){
    Navigator.pop(context);
  }

  ImagePicker imagePicker = ImagePicker();
  File file;
  String imageUrl;
  String fileName;

  Future pickImage() async {
    var image = await imagePicker.pickImage(source: ImageSource.gallery,maxHeight: 200.0,maxWidth: 200.0);
    if (image != null) {
      setState(() {
        file = File(image.path);

      });
      fileName = basename(file.path);
      uploadImage( file , fileName);
    }
  }
  // uploadProfileImage( ) async {
  //   Reference reference = FirebaseStorage.instance
  //       .ref()
  //       .child(basename(file.path));
  //   UploadTask uploadTask = reference.putFile(file);
  //   TaskSnapshot snapshot = await uploadTask;
  //   uploadTask.whenComplete(() async {
  //     //  String url;
  //     //   await uploadTask.whenComplete(() async {
  //     //     url = await uploadTask.snapshot.ref.getDownloadURL();
  //     //   });
  //     imageUrl = await snapshot.ref.getDownloadURL();
  //     print("gnhrnjrstjntrj ===${imageUrl}");
  //     setState(() {
  //       imageUrl = _photoUrl;
  //     });
  //
  //     print("ndunf wfnuhefgwcefuy${_photoUrl}");
  //   });
  // }


  // Future  pickImage() async {
  //
  //   File file =((await ImagePicker().pickImage(
  //       source: ImageSource.gallery,maxHeight: 200.0,maxWidth: 200.0
  //   ) )) as File;
  // String fileName = basename( file.path);
  //   uploadImage(file,fileName);
  // }
  void uploadImage( File file,String fileName) async{

    Reference storageReference = FirebaseStorage.instance.ref().child(fileName);
  UploadTask uploadTask = storageReference.putFile(file);
  uploadTask.whenComplete(() async {
    await uploadTask.whenComplete(() async {
      imageUrl = await uploadTask.snapshot.ref.getDownloadURL();
      setState(() {
        _photoUrl =imageUrl;
        print(    " jeweleries gewfgweufygewyfgecjy config weightage      $_photoUrl");
      });
    });
     });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text(" add contact ",style: TextStyle(
        fontSize: 25.0,fontWeight: FontWeight.w500
    ),
    ),
    ),
    body:Container(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children:<Widget> [
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: GestureDetector(
                onTap: (){pickImage();},
                child: Center(
                  child: Container(
                    width: 100.0,
                    height: 100.0,
                    decoration:  BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: _photoUrl == "empty" ?
                        const AssetImage("images/logo.png") :
                        NetworkImage(_photoUrl) as ImageProvider ,
                      )
                    ),
                  ),
                ),
              ),
            ),
            //"First Name"
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: TextField(
                onChanged: (value){
                  setState(() {
                    _firstName = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: "First Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  )
                ),
              ),
            ),
            //last name
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: TextField(
                onChanged: (value){
                  setState(() {
                    _lastName = value;
                  });
                },
                decoration: InputDecoration(
                    labelText: "Last Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )
                ),
              ),
            ),
            //phone
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: TextField(
                keyboardType: TextInputType.number,
                onChanged: (value){
                  setState(() {
                    _phone = value;
                  });
                },
                decoration: InputDecoration(
                    labelText: "Phone Number",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )
                ),
              ),
            ),
            //email
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: TextField(
                onChanged: (value){
                  setState(() {
                    _email = value;
                  });
                },
                decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )
                ),
              ),
            ),
            //Address
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: TextField(
                onChanged: (value){
                  setState(() {
                    _address = value;
                  });
                },
                decoration: InputDecoration(
                    labelText: "Address",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:MaterialStateProperty.all<Color>(Colors.deepPurple),

                ),
                onPressed:() {
                    saveContact(context);
                  },
                child: const Text(" Save",style: TextStyle(
                  fontWeight:FontWeight.w500,
                  fontSize: 20.0,
                ),),


              ),
            )
          ],
        ),
      ),
    ) ,

    );
  }
  // File file;
  // Future selectFile() async {
  //   final result = await FilePicker.platform.pickFiles(allowMultiple: false);
  //
  //   if (result == null) return;
  //   final path = result.files.single.path;
  //   //String fileName = basename(file.path);
  //   setState(() => file = File(path));
  // }

}
