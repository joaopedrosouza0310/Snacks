import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {
  String id;
  String name;
  String description;
  double price;
  List images;
  List ingredients;

  String categoryId;

  ProductData.fromDocument(DocumentSnapshot doc, {this.categoryId}) {
    id = doc.documentID;
    name = doc.data["name"];
    description = doc.data["description"];
    price = doc.data["price"] + 0.0;
    images = doc.data["images"];
    doc.data["ingredients"] != null
        ? ingredients = doc.data["ingredients"]
        : ingredients = [];
  }

  Map<String, dynamic> toResumedMap() {
    return {"name": name, "price": price, "description": description};
  }
}
