import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  String id;
  String name;
  String email;
  String address;
  String cellphone;

  UserData({this.name, this.email, this.address, this.cellphone});

  UserData.fromDocument(DocumentSnapshot doc) {
    id = doc.documentID;
    name = doc.data['name'];
    email = doc.data['email'];
    address = doc.data['address'];
    cellphone = doc.data['cellphone'];
  }

  Map<String, dynamic> toMap() {
    return {
      "name": this.name,
      "email": this.email,
      "address": this.address,
      "cellphone": this.cellphone
    };
  }
}
