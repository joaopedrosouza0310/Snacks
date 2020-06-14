import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:snacks/screens/login_screen.dart';
import 'package:snacks/stores/cart_store.dart';
import 'package:snacks/stores/user_store.dart';
import 'package:snacks/widgets/discount_card.dart';
import 'package:snacks/tiles/cart_tile.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartStore cartStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    cartStore = Provider.of<CartStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Carrinho",
            style: TextStyle(fontSize: 27),
          ),
          centerTitle: true,
          
        ),
        body: Observer(builder: (_) {
          if (cartStore.loading && Provider.of<UserStore>(context).isLoggedIn) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (!cartStore.userStore.isLoggedIn) {
            return Container(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(
                    Icons.remove_shopping_cart,
                    size: 80,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Faça o login para adicionar os produtos",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  RaisedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LoginScreen()));
                      },
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        "Entrar",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )),
                ],
              ),
            );
          } else if (cartStore.products == null ||
              cartStore.products.length == 0) {
            return Center(
              child: Text(
                "Nenhum produto no carrinho",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
                textAlign: TextAlign.center,
              ),
            );
          } else {
            return ListView(children: <Widget>[
              Column(
                children: cartStore.products.map((product) {
                  return CartTile(product);
                }).toList(),
              ),

              DiscountCard(),

              // ShipCard(),

              // CartPrice(() async {
              //   String orderId = await cartStore.finishOrder();

              //   if (orderId != null) {
              //     Navigator.of(context).pushReplacement(MaterialPageRoute(
              //         builder: (context) => OrderScreen(orderId)));
              //   }
            ]);
          }
        }) //bodyCartScreen(),
        );
  }
}
