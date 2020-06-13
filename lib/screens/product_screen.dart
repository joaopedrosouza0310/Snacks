import 'dart:ui';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snacks/data/cart_data.dart';
import 'package:snacks/data/product_data.dart';
import 'package:snacks/screens/cart_screen.dart';
import 'package:snacks/screens/login_screen.dart';
import 'package:snacks/stores/cart_store.dart';
import 'package:snacks/stores/user_store.dart';
import 'package:snacks/themes/colors.dart';

class ProductScreen extends StatefulWidget {
  final ProductData product;
  ProductScreen(this.product);

  @override
  _ProductScreenState createState() => _ProductScreenState(product);
}

class _ProductScreenState extends State<ProductScreen> {
  ProductData product;
  List ingredientes;
  int quantidade = 1;
  _ProductScreenState(this.product) {
    ingredientes = List.of(product.ingredients);
  }

  buildIngredients() {
    if (product.ingredients.length > 0) {
      return ListView(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        children: <Widget>[
          SizedBox(
            height: 6,
          ),
          RichText(
            text: TextSpan(
              text: "Ingredientes",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                    text:
                        " (Clique nos ingredientes para escolher os que deseja)",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.black87)),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Wrap(
            spacing: 10,
            children: product.ingredients.map((i) {
              return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (ingredientes.contains(i)) {
                        ingredientes.remove(i);
                      } else {
                        ingredientes.add(i);
                      }
                    });
                  },
                  child: Chip(
                    backgroundColor:
                        ingredientes.contains(i) ? yellowColor : Colors.grey,
                    label: Text(i,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                  ));
            }).toList(),
          )
        ],
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    UserStore userStore = Provider.of<UserStore>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          product.name,
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
        backgroundColor: redColor,
      ),
      body: ListView(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        children: <Widget>[
          //Imagens do produto
          Container(
            height: 230,
            child: Carousel(
              dotBgColor: Colors.transparent,
              dotColor: redColor,
              autoplayDuration: Duration(seconds: 10),
              dotSpacing: 15,
              dotSize: 6,
              autoplay: true,
              images: product.images.map((url) {
                return Image.network(
                  url,
                  fit: BoxFit.cover,
                );
              }).toList(),
            ),
          ),
          //----------------------------------
          ListView(
            padding: EdgeInsets.all(16),
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            children: <Widget>[
              Text(
                product.name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 34),
              ),
              Text(
                "Apenas R\$${product.price.toStringAsFixed(2).replaceAll(".", ",")}",
                style: TextStyle(
                    color: redColor, fontWeight: FontWeight.bold, fontSize: 25),
              ),
              //-----------------------------------
              buildIngredients(),
              SizedBox(
                height: 10,
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                      icon: Icon(
                        Icons.remove_circle,
                        color: Colors.red,
                        size: 30,
                      ),
                      onPressed: () {
                        setState(() {
                          if (quantidade > 1) {
                            quantidade--;
                          }
                        });
                      }),
                  Text(
                    "$quantidade",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.add_circle,
                        color: Colors.green,
                        size: 30,
                      ),
                      onPressed: () {
                        setState(() {
                          quantidade++;
                        });
                      })
                ],
              ),
              SizedBox(
                height: 10,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SizedBox(
                  height: 55,
                  child: FlatButton(
                      color: redColor,
                      textColor: Colors.white,
                      disabledColor: Colors.grey,
                      onPressed: ingredientes.length > 0 ||
                              product.ingredients.length <= 0
                          ? () {
                              if (userStore.isLoggedIn) {
                                CartData c = CartData();
                                c.productId = product.id;
                                c.category = product.categoryId;
                                if (ingredientes != null ||
                                    ingredientes.length > 0) {
                                  c.ingredients = ingredientes;
                                }
                                c.quantity = quantidade;
                                c.productData = product;

                                final cartStore = Provider.of<CartStore>(
                                    context,
                                    listen: false);

                                cartStore.addCartItem(c);

                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => CartScreen()));
                              } else {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                              }
                            }
                          : null,
                      child: Text(
                        userStore.isLoggedIn
                            ? "Adicionar ao carrinho"
                            : "Faça login para comprar",
                        style: TextStyle(fontSize: 23),
                      )),
                ),
              ),
              //---------------------------------------------
              SizedBox(
                height: 20,
              ),
              Text(
                "Descrição",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.black),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                product.description,
                style: TextStyle(fontSize: 20),
              ),
            ],
          )
        ],
      ),
    );
  }
}
