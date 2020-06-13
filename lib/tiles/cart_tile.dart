import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:snacks/data/cart_data.dart';
import 'package:snacks/data/product_data.dart';
import 'package:snacks/themes/colors.dart';

class CartTile extends StatelessWidget {
  final CartData cartData;

  CartTile(this.cartData);

  @override
  Widget build(BuildContext context) {
    //print("recarregou todo a árvore");
    Widget _buildContent() {
      //CartModel.of(context).updatePrices();

      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 100,
            height: 100,
            child: Image.network(
              cartData.productData.images[0],
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    cartData.productData.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  Text(
                    cartData.ingredients != null
                        ? "Ingredientes: ${cartData.ingredients}"
                        : "Descrição: ${cartData.productData.description}",
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
                  ),
                  Text(
                    "R\$ ${cartData.productData.price.toStringAsFixed(2)}",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.remove_circle,
                            color: Theme.of(context).primaryColor),
                        onPressed: cartData.quantity > 1
                            ? () {
                                //CartModel.of(context).decProduct(cartProduct);
                              }
                            : null,
                      ),
                      Text(
                        cartData.quantity.toString(),
                        style: TextStyle(fontSize: 20),
                      ),
                      IconButton(
                        icon: Icon(Icons.add_circle,
                            color: Theme.of(context).primaryColor),
                        onPressed: () {
                          //CartModel.of(context).incProduct(cartProduct);
                        },
                      ),
                      FlatButton(
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Remover",
                              style: TextStyle(fontSize: 20),
                            ),
                            Icon(
                              Icons.delete,
                              color: redColor,
                            )
                          ],
                        ),
                        textColor: Colors.grey,
                        onPressed: () {
                          //CartModel.of(context).removeCartItem(cartProduct);
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      );
    }

    return Card(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: cartData.productData == null
          ? FutureBuilder<DocumentSnapshot>(
              future: Firestore.instance
                  .collection("categories")
                  .document(cartData.category)
                  .collection("items")
                  .document(cartData.productId)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  cartData.productData =
                      ProductData.fromDocument(snapshot.data);
                  return _buildContent();
                } else {
                  return Container(
                    height: 70,
                    child: CircularProgressIndicator(),
                    alignment: Alignment.center,
                  );
                }
              },
            )
          : _buildContent(),
    );
  }
}
