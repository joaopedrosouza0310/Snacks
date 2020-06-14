import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DiscountCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final cartStore = Provider.of<CartStore>(context);
    return Card(
      child: ExpansionTile(
        leading: Icon(Icons.card_giftcard),
        trailing: Icon(Icons.add),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8),
            child: TextFormField(
              initialValue: "teste", //cartStore.couponCode ?? "",
              onFieldSubmitted: (text) {
                Firestore.instance
                    .collection("coupons")
                    .document(text)
                    .get()
                    .then((doc) {
                  if (doc.data != null) {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      backgroundColor: Theme.of(context).primaryColor,
                      content:
                          Text("Desconto de ${doc.data["percent"]}% aplicado"),
                    ));
                    //CartModel.of(context).setCoupon(text, doc.data["percent"]);
                  } else {
                    // CartModel.of(context).setCoupon(null, 0);
                    Scaffold.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.redAccent,
                      content: Text("Cupom não existe"),
                    ));
                  }
                });
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Digite seu cupom"),
            ),
          )
        ],
        title: Text(
          "Cupom de desconto",
          textAlign: TextAlign.start,
          style:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.grey[700]),
        ),
      ),
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    );
  }
}
