import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:snacks/tiles/category_snacks_tile.dart';
import 'package:flutter/material.dart';

class MenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection("categories").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return CategorySnacksTile(snapshot.data.documents[index]);
                });
          } else {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.red),
              ),
            );
          }
        });
  }
}
