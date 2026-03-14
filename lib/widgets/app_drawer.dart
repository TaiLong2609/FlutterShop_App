import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.blue),
            child: const Text(
              "Menu cửa hàng",
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),

          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Trang chủ"),
            onTap: () {
              Navigator.pushNamed(context, '/');
            },
          ),

          ListTile(
            leading: const Icon(Icons.store),
            title: const Text("Sản phẩm"),
            onTap: () {
              Navigator.pushNamed(context, '/products');
            },
          ),

          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text("Giỏ hàng"),
            onTap: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
        ],
      ),
    );
  }
}
