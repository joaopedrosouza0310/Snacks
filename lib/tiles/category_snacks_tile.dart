import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:snacks/data/product_data.dart';
import 'package:snacks/screens/product_screen.dart';
import 'package:snacks/themes/colors.dart';

class CategorySnacksTile extends StatelessWidget {
  final DocumentSnapshot doc;

  CategorySnacksTile(this.doc);

  getIngredients(DocumentSnapshot p) {
    String ingredients = "";
    for (int i = 0; i < p["ingredients"].length; i++) {
      ingredients += p["ingredients"][i];
      if (i < p["ingredients"].length - 1) ingredients += ", ";
    }
    return ingredients;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2,
        child: ExpansionTile(
          initiallyExpanded: true,
          // leading: CircleAvatar(
          //   radius: 25,
          //   backgroundColor: redColor,
          //   backgroundImage: NetworkImage(doc["icon"]),
          // ),

          title: Text(
            doc.documentID,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          children: <Widget>[
            FutureBuilder<QuerySnapshot>(
                future: Firestore.instance
                    .collection("categories")
                    .document(doc.documentID)
                    .collection("items")
                    .getDocuments(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.separated(
                      itemCount: snapshot.data.documents.length,
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),

                      itemBuilder: (context, index) {
                        var e = snapshot.data.documents[index];
                        return ListTile(
                          contentPadding: EdgeInsets.only(left: 8, right: 8),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (c) => ProductScreen(
                                        ProductData.fromDocument(e,
                                            categoryId: doc.documentID))));
                          },
                          leading: Container(
                            height: 80,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: NetworkImage(e["images"][0]),
                                    fit: BoxFit.cover)),
                          )

                          // CircleAvatar(
                          //   radius: 25,
                          //   backgroundImage: NetworkImage(e["images"][0]),
                          // )

                          ,
                          title: Text(
                            e["name"],
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          subtitle: e["ingredients"] != null
                              ? Text(getIngredients(e))
                              : Text(e["description"]),
                          trailing: Text(
                              "R\$ ${e["price"].toStringAsFixed(2).replaceAll(".", ",")}",
                              style: TextStyle(
                                fontSize: 20,
                                color: redColor,
                              )),
                        );
                      },

                      // children: snapshot.data.documents.map((e) {
                      //   // String ingredients = "";
                      //   // e["ingredients"].map((i) => ingredients += "$i, ").toList();

                      //   return Column(
                      //     children: <Widget>[
                      //       ListTile(
                      //         contentPadding:
                      //             EdgeInsets.only(left: 8, right: 8),
                      //         onTap: () {
                      //           Navigator.push(
                      //               context,
                      //               MaterialPageRoute(
                      //                   builder: (c) => ProductScreen(
                      //                       ProductData.fromDocument(e,
                      //                           categoryId: doc.documentID))));
                      //         },
                      //         leading: Container(
                      //           height: 80,
                      //           width: 100,
                      //           decoration: BoxDecoration(
                      //               borderRadius: BorderRadius.circular(10),
                      //               image: DecorationImage(
                      //                   image: NetworkImage(e["images"][0]),
                      //                   fit: BoxFit.cover)),
                      //         )

                      //         // CircleAvatar(
                      //         //   radius: 25,
                      //         //   backgroundImage: NetworkImage(e["images"][0]),
                      //         // )

                      //         ,
                      //         title: Text(
                      //           e["name"],
                      //           style: TextStyle(
                      //             fontSize: 20,
                      //           ),
                      //         ),
                      //         subtitle: e["ingredients"] != null
                      //             ? Text(getIngredients(e))
                      //             : Text(e["description"]),
                      //         trailing: Text(
                      //             "R\$ ${e["price"].toStringAsFixed(2).replaceAll(".", ",")}",
                      //             style: TextStyle(
                      //               fontSize: 20,
                      //               color: redColor,
                      //             )),
                      //       ),
                      //       Divider(
                      //         height: 2,
                      //         color: Colors.grey,
                      //       )
                      //     ],
                      //   );
                      // }).toList(),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.red),
                      ),
                    );
                  }
                })
          ],
        ));
  }
}
