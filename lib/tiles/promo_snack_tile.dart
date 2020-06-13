import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:snacks/themes/colors.dart';
import 'package:snacks/themes/decorations.dart';

class PromoSnackTile extends StatelessWidget {
  final DocumentSnapshot doc;

  PromoSnackTile(this.doc);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: Firestore.instance
            .collection("categories")
            .document(doc["categoryId"])
            .collection("items")
            .document(doc["snackId"])
            .get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return InkWell(
              onTap: () {},
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(snapshot.data["images"][0]),
                          fit: BoxFit.cover),
                      boxShadow: [customBoxShadow()],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    width: 320,
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  ),
                  Positioned(
                    left: 0,
                    bottom: 0,
                    child: Container(
                      width: 320,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                        color: Colors.black.withOpacity(0.4),
                      ),
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            snapshot.data["name"],
                            style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            height: 30,
                            decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(
                                  "R\$ ${snapshot.data["price"].toStringAsFixed(2).replaceAll(".", ",")}",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: redColor,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.lineThrough),
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  size: 20,
                                  color: Colors.white,
                                ),
                                Text(
                                  "R\$ ${(snapshot.data["price"] - ((doc["percent"] / 100) * snapshot.data["price"])).toStringAsFixed(2).replaceAll(".", ",")}",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          } else {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 320,
                    height: 25,
                    child: Shimmer.fromColors(
                        child: Container(
                          color: Colors.white.withAlpha(50),
                          margin: EdgeInsets.symmetric(vertical: 4),
                        ),
                        baseColor: Colors.white,
                        highlightColor: Colors.grey),
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 80,
                        height: 25,
                        child: Shimmer.fromColors(
                            child: Container(
                              color: Colors.white.withAlpha(50),
                              margin: EdgeInsets.symmetric(vertical: 4),
                            ),
                            baseColor: Colors.white,
                            highlightColor: Colors.grey),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        width: 80,
                        height: 25,
                        child: Shimmer.fromColors(
                            child: Container(
                              color: Colors.white.withAlpha(50),
                              margin: EdgeInsets.symmetric(vertical: 4),
                            ),
                            baseColor: Colors.white,
                            highlightColor: Colors.grey),
                      ),
                    ],
                  )
                ],
              ),
            );
          }
        });
  }
}
