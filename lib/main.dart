import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_project/providers/cart.dart';
import 'package:provider_project/providers/products.dart';
import 'package:provider_project/screens/cart_screen.dart';
import 'package:provider_project/screens/product_detail_screen.dart';
import 'package:provider_project/screens/products_overview_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
         ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.purple, accentColor: Colors.deepOrange),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (c) => ProductDetailScreen(),
          CartScreen.routeName: (c) =>CartScreen(),
        },
      ),
    );
  }
}