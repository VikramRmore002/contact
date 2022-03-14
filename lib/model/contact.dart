import 'package:firebase_database/firebase_database.dart';

class Contact{
 String  _id;
 String  _firstName;
 String  _lastName;
 String  _phone;
 String  _email;
 String  _address;
 String  _photoUrl;



  Contact( this._firstName,this._lastName,this._phone,this._email,this._address,this._photoUrl);


  Contact.withId(this._id,this._firstName,this._lastName,this._phone,this._email,this._address,this._photoUrl );

  //getter

  String get id        =>  _id;
  String get firstName =>  _firstName;
  String get lastName  =>  _lastName;
  String get phone     =>  _phone;
  String get email     =>  _email;
  String get address   =>  _address;
  String get photoUrl  =>  _photoUrl;

  // setters

  set firstName( String firstName){
  _firstName = firstName;
 }
  set lasttName( String lasttName){
  _lastName = lasttName;
 }
  set phone( String phone){
  _phone = phone;
 }
 set email( String email){
  _email = email;
 }
  set address( String address){
  _address = address;
 }
  set photoUrl( String photoUrl){
  _photoUrl = photoUrl;
 }

 Contact.fromSnapshot(DataSnapshot snapshot){
  _id = snapshot.key;
  _firstName = snapshot.value["firstname"];
  _lastName = snapshot.value["lastname"];
  _phone = snapshot.value["phone"];
  _email = snapshot.value["email"];
  _address = snapshot.value["address"];
  _photoUrl = snapshot.value["photoUrl"];

 }
 Map< String , dynamic >toJson( ){
    return {
      "firstname" : _firstName,
      "lastname" : _lastName,
      "phone" : _phone,
     "email" : _email,
      "address" : _address,
      "photoUrl" : _photoUrl,
    };
 }




}