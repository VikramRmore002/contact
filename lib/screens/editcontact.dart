import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:fireapp/model/contact.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';


class editContact extends StatefulWidget {
  final String id;
   const editContact(this.id, {Key key,}) : super(key: key);
  @override
  _editContactState createState() => _editContactState(id);
}
class _editContactState extends State<editContact> {
  String id;
  _editContactState(this.id);

  String  _firstName ="";
  String  _lastName  ="";
  String  _phone     ="";
  String  _email     ="";
  String  _address   ="";
   String  _photoUrl  ;
    Contact contact ;

  //textEditing controoller

  final TextEditingController _fnController = TextEditingController();
  final TextEditingController _lnController = TextEditingController();
  final TextEditingController _phController = TextEditingController();
  final TextEditingController _emController = TextEditingController();
  final TextEditingController _adController = TextEditingController();

  bool isLoading = true;

  // Db/Firebase helper
  final DatabaseReference _databaseReference =FirebaseDatabase.instance.reference();

  @override
  void initState() {
    super.initState();
    //getContact by firebase
    getContact(id);
  }

  getContact (id)async{
  // late  Contact contact;

    _databaseReference.child(id).onValue.listen((event) {
      contact = Contact.fromSnapshot(event.snapshot);
      _fnController.text = contact.firstName;
      _lnController.text = contact.lastName;
      _phController.text = contact.phone;
      _emController.text = contact.email;
      _adController.text = contact.address;

  setState(() {
    _firstName   =  contact.firstName;
    _lastName   =  contact.lastName;
    _phone   =  contact.phone;
    _email   =  contact.email;
    _address   =   contact.address;
    _photoUrl   =  contact.photoUrl;
    isLoading = false;

  });
    });
  }

  ImagePicker imagePicker = ImagePicker();
  String fileName;
  UploadTask task;
  String imageUrl;
  File file;
  Future pickImage() async {
    var image = await imagePicker.pickImage(source: ImageSource.gallery,maxHeight: 200.0,maxWidth: 200.0);
    if (image != null) {

        file = File(image?.path );


      fileName = basename(file.path);
      uploadImage( file , fileName);
    }
  }
  // Future  pickImage() async {
  //   File file =((await ImagePicker().pickImage(
  //       source: ImageSource.gallery,maxHeight: 200.0,maxWidth: 200.0
  //   ) )) as File;
  //
  //
  //   String fileName = basename( file.path);
  //
  //
  //   print(  "efeuifgecbiifuwq78trq87rcbir7tr87 ${file.path}");
  //   uploadImage(file,fileName);
  // }

  // final fileName = basename(file.path);
  //
  // Future selectFile() async {
  //   final result = await FilePicker.platform.pickFiles(allowMultiple: false);
  //
  //   if (result == null) return;
  //   final path = result.files.single.path;
  //
  //   setState(() => file = File(path));
  // }


  // File file = (await ImagePicker().pickImage(
    //     source: ImageSource.gallery,maxHeight: 200.0,maxWidth: 200.0
    // ) );
    // String fileName = basename( file.path);
   // uploadImage(file,imageFile);

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
  navigatetoLastScreen( BuildContext context){
    Navigator.pop( context);}
//update contact
    UpdateContact(BuildContext context ) async{
      if( _firstName.isNotEmpty &&
          _lastName.isNotEmpty &&
          _phone.isNotEmpty &&
          _email.isNotEmpty&&
          _address.isNotEmpty
      ){
        Contact.withId(id, _firstName, _lastName, _phone, _email, _address, _photoUrl);
        await _databaseReference.child(id).set(contact.toJson());
        navigatetoLastScreen(context);
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

  @override
  Widget build(BuildContext context) {
    final fileName = basename(file.path);
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Contact"),
      ),
      body: Container(
        child: isLoading
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : Padding(
          padding: EdgeInsets.all(20.0),
          child: ListView(
            children: <Widget>[
              //image view
              Container(
                  margin: EdgeInsets.only(top: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      pickImage();
                    },
                    child: Center(
                      child: Container(
                          width: 100.0,
                          height: 100.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: _photoUrl == "empty"
                                    ? const AssetImage("assets/logo.png")
                                    : NetworkImage(_photoUrl) as ImageProvider,
                              ))),
                    ),
                  )),
              //
              Container(
                margin: EdgeInsets.only(top: 20.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _firstName = value;
                    });
                  },
                  controller: _fnController,
                  decoration: InputDecoration(
                    labelText: 'First Name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                ),
              ),
              //
              Container(
                margin: EdgeInsets.only(top: 20.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _lastName = value;
                    });
                  },
                  controller: _lnController,
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                ),
              ),
              //
              Container(
                margin: EdgeInsets.only(top: 20.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _phone = value;
                    });
                  },
                  controller: _phController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Phone',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                ),
              ),
              //
              Container(
                margin: EdgeInsets.only(top: 20.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _email = value;
                    });
                  },
                  controller: _emController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                ),
              ),
              //
              Container(
                margin: EdgeInsets.only(top: 20.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _address = value;
                    });
                  },
                  controller: _adController,
                  decoration: InputDecoration(
                    labelText: 'Address',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                ),
              ),
              // update button
              Container(
                padding: const EdgeInsets.only(top: 20.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:MaterialStateProperty.all<Color>(Colors.deepPurple),

                  ),
                  onPressed:() {
                    UpdateContact(context);
                  },
                  child: const Text(" Update",style: TextStyle(
                    fontWeight:FontWeight.w500,
                    fontSize: 20.0,
                  ),),


                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path;

    setState(() => file = File(path));
  }
  Future uploadFile() async {
    if (file == null) return;

    final fileName = basename(file.path);
    final destination = 'files/$fileName';

    // task = FirebaseApi.uploadFile(destination, file);
    // setState(() {});

    // if (task == null) return;

    final snapshot = await task.whenComplete(() {});
    var urlDownload = await snapshot.ref.getDownloadURL();
    setState(() {
      urlDownload = _photoUrl;
    });

    //print('Download-Link: $urlDownload');
  }

}
