import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snacks/screens/home_screen.dart';
import 'package:snacks/stores/cart_store.dart';
import 'package:snacks/stores/user_store.dart';
import 'package:snacks/themes/colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<UserStore>(create: (_) => UserStore()),
        ProxyProvider<UserStore, CartStore>(
          update: (_, user, __) => CartStore(user),
        )
      ],
      child: MaterialApp(
        title: 'Snacks',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
          primaryColor: redColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
