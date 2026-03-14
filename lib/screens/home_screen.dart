import 'package:flutter/material.dart';

import 'package:demo/widgets/app_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cửa hàng Flutter")),

      drawer: const AppDrawer(),

      body: const Center(
        child: Text("Chào mừng đến cửa hàng", style: TextStyle(fontSize: 22)),
      ),
    );
  }
}
