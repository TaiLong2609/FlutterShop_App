import 'package:flutter/material.dart';

import 'package:demo/screens/home_screen.dart';
import 'package:demo/screens/product_screen.dart';
import 'package:demo/screens/cart_screen.dart';
import 'package:demo/store/store.dart';

final Store _store = Store();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreScope(
      store: _store,
      child: MaterialApp(
        title: 'Cửa hàng Flutter',
        debugShowCheckedModeBanner: false,

        theme: ThemeData(primarySwatch: Colors.blue),

        // Màn hình mặc định
        initialRoute: '/',

        // Các route
        routes: {
          '/': (context) => const HomeScreen(),
          '/products': (context) => const ProductScreen(),
          '/cart': (context) => const CartScreen(),
        },
      ),
    );
  }
}
