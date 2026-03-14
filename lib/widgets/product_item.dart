import 'package:flutter/material.dart';
import '../models/product.dart';
import '../store/store.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final store = StoreScope.of(context);

    return Card(
      child: ListTile(
        leading: const Icon(Icons.shopping_bag),
        title: Text(product.name),
        subtitle: Text("${product.price} VND"),
        trailing: ElevatedButton(
          onPressed: () {
            store.addToCart(product);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Đã thêm vào giỏ hàng'),
                duration: Duration(seconds: 1),
              ),
            );
          },
          child: const Text("Thêm"),
        ),
      ),
    );
  }
}