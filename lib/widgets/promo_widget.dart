import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:snacks/tiles/promo_snack_tile.dart';

class PromoWidget extends StatefulWidget {
  @override
  _PromoWidgetState createState() => _PromoWidgetState();
}

class _PromoWidgetState extends State<PromoWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      child: FutureBuilder<QuerySnapshot>(
          future: Firestore.instance.collection("promotions").getDocuments(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return PromoSnackTile(snapshot.data.documents[index]);
                },
                itemCount: snapshot.data.documents.length,
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.red),
                ),
              );
            }
          }),
    );
  }
}










