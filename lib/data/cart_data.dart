import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:snacks/data/product_data.dart';

class CartData {
  String cartId;

  String category;
  String productId;

  int quantity;
  List ingredients;

  ProductData productData;

  CartData();

  CartData.fromDocument(DocumentSnapshot doc) {
    cartId = doc.documentID;
    category = doc.data["category"];
    productId = doc.data["productId"];
    quantity = doc.data["quantity"];
    ingredients = doc.data["ingredients"];
  }

  Map<String, dynamic> toMap() {
    return {
      "category": category,
      "productId": productId,
      "quantity": quantity,
      "ingredients": ingredients,
      "product": productData.toResumedMap()
    };
  }
}
