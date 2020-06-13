import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:snacks/screens/cart_screen.dart';
import 'package:snacks/stores/cart_store.dart';
import 'package:snacks/stores/user_store.dart';
import 'package:snacks/themes/colors.dart';
import 'package:snacks/widgets/custom_drawer.dart';
import 'package:snacks/widgets/menu_widget.dart';
import 'package:snacks/widgets/promo_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserStore userStore;
  CartStore cartStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    userStore = Provider.of<UserStore>(context);
    cartStore = Provider.of<CartStore>(context);
  }

//  @override
//   void initState() {
//
//     super.initState();
//
//     Firestore.instance
//         .collection("categories")
//         .document("Sucos")
//         .collection("items")
//         .document("UW1QQF6dSEAMCV9rjL5M")
//         .get()
//         .then((v) {
//       for (int i = 0; i < 4; i++) {
//         Firestore.instance
//             .collection("categories")
//             .document("Sucos")
//             .collection("items")
//             .add({
//           "description": v["description"],
//           "images": v["images"],
//           "ingredients": v["ingredients"],
//           "name": v["name"],
//           "price": v["price"]
//         });
//       }
//     });
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: redColor,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Snacks",
          style: TextStyle(
            fontSize: 27,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          Observer(builder: (_) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => CartScreen()));
              },
              child: Row(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Icon(
                        Icons.shopping_cart,
                        size: 40,
                        color: Colors.white,
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            "${cartStore.products.length}",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          height: 22,
                          width: 22,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: yellowColor,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  )
                ],
              ),
            );
          }),
        ],
      ),
      //-=-=-=-=-=-=-==-=-=-=-=-=-=
      drawer: CustomDrawer(),
      //-=-=-=-=-=-=-==-=-=-=-=-=-=
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          //Banners -------------------------------------------------------
          Container(
            height: 200,
            child: FutureBuilder<DocumentSnapshot>(
                future: Firestore.instance
                    .collection("banners")
                    .document("info")
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Carousel(
                      dotBgColor: Colors.transparent,
                      dotColor: redColor,
                      autoplayDuration: Duration(seconds: 5),
                      dotSpacing: 15,
                      dotSize: 6,
                      autoplay: true,
                      images: snapshot.data["images"].map((url) {
                        return Image.network(
                          url,
                          fit: BoxFit.cover,
                        );
                      }).toList(),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.red),
                      ),
                    );
                  }
                }),
          ),
          //Promoções ------------------------------------------------------------------
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              "Promoções do dia",
              style: TextStyle(
                fontSize: 30,
                color: redColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          PromoWidget(),
          //Cardápio ------------------------------------------------------------------
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              "Cardápio",
              style: TextStyle(
                fontSize: 30,
                color: redColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: MenuWidget(),
          )
        ],
      ),
    );
  }
}
