import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  String name;
  String email;
  String address;
  String cellphone;

  UserData({this.name, this.email, this.address, this.cellphone});

  UserData.fromDocument(DocumentSnapshot doc) {
    name = doc.data['name'];
    email = doc.data['email'];
    address = doc.data['address'];
    cellphone = doc.data['cellphone'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['address'] = this.address;
    data['cellphone'] = this.cellphone;
    return data;
  }
}
