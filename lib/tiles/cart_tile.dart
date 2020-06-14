import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snacks/data/cart_data.dart';
import 'package:snacks/data/product_data.dart';
import 'package:snacks/stores/cart_store.dart';
import 'package:snacks/themes/colors.dart';

class CartTile extends StatelessWidget {
  final CartData cartData;

  CartTile(this.cartData);

  @override
  Widget build(BuildContext context) {
    //final cartStore = Provider.of<CartStore>(context);

    Widget _buildContent() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(5),
            width: 80,
            height: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                  image: NetworkImage(cartData.productData.images[0]),
                  fit: BoxFit.cover),
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    cartData.ingredients != null
                        ? "Ingr. selecionados: ${cartData.ingredients}"
                        : "Descrição: ${cartData.productData.description}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15),
                  ),
                  Text(
                    "R\$ ${cartData.productData.price.toStringAsFixed(2)}",
                    style: TextStyle(
                        color: redColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.remove_circle,
                            size: 22, color: Theme.of(context).primaryColor),
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
                        icon: Icon(
                          Icons.add_circle,
                          color: Colors.green,
                          size: 22,
                        ),
                        onPressed: () {
                          //CartModel.of(context).incProduct(cartProduct);
                        },
                      ),
                      FlatButton(
                        padding: EdgeInsets.all(0),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.delete,
                              color: redColor,
                              size: 20,
                            ),
                            SizedBox(width: 5),
                            Text(
                              "Remover",
                              style: TextStyle(fontSize: 15),
                            )
                          ],
                        ),
                        textColor: Colors.grey,
                        onPressed: () {
                          Provider.of<CartStore>(context, listen: false)
                              .removeCartItem(cartData);
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
