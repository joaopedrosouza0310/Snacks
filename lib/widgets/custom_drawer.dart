import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:snacks/screens/login_screen.dart';
import 'package:snacks/stores/cart_store.dart';
import 'package:snacks/stores/user_store.dart';
import 'package:snacks/themes/colors.dart';
import 'package:snacks/screens/cart_screen.dart';
import 'package:snacks/tiles/drawer_tile.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    final userStore = Provider.of<UserStore>(context);
    final cartStore = Provider.of<CartStore>(context);

    Widget _buildDrawerBack() => Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [redColor, yellowColor],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
        );

    return Drawer(
      child: Stack(
        children: <Widget>[
          _buildDrawerBack(),
          ListView(
            padding: EdgeInsets.only(top: 30, left: 16, right: 16),
            children: <Widget>[
              Container(
                height: 180,
                child: Image.asset("assets/logo.png"),
              ),
              SizedBox(
                height: 20,
              ),
              Observer(builder: (_) {
                return Text(
                    userStore.userData != null
                        ? "Olá, ${userStore.userData.name}"
                        : "Olá! Faça login para aproveitar nossos produtos",
                    style: TextStyle(fontSize: 25, color: Colors.white));
              }),
              SizedBox(
                height: 10,
              ),
              Observer(builder: (_) {
                return GestureDetector(
                  child: Text(
                    userStore.isLoggedIn ? "Sair >" : "Entre ou cadastre-se >",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    if (!userStore.isLoggedIn) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LoginScreen()));
                    } else {
                      userStore.signOut();
                      cartStore.userStore.user = null;
                      Navigator.of(context).pop();
                    }
                  },
                );
              }),
              Divider(
                thickness: 2,
              ),
              DrawerTile(
                iconLeading: Icons.playlist_add_check,
                onTap: () {},
                title: "Pedidos",
                iconTrailing: Icons.arrow_forward_ios,
              ),
              Divider(),
              DrawerTile(
                iconLeading: Icons.shopping_cart,
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => CartScreen()));
                },
                title: "Carrinho",
                iconTrailing: Icons.arrow_forward_ios,
              ),
              Divider(),
              DrawerTile(
                iconLeading: Icons.contact_phone,
                onTap: () {},
                title: "Contatos Snacks",
                iconTrailing: Icons.arrow_forward_ios,
              ),
            ],
          )
        ],
      ),
    );
  }
}
