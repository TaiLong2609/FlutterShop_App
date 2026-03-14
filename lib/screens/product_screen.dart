import 'package:flutter/material.dart';

import 'package:demo/models/product.dart';
import 'package:demo/store/store.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  String _formatVnd(double value) {
    final intValue = value.round();
    final s = intValue.toString();
    final buffer = StringBuffer();
    for (var i = 0; i < s.length; i++) {
      final indexFromEnd = s.length - i;
      buffer.write(s[i]);
      if (indexFromEnd > 1 && indexFromEnd % 3 == 1) {
        buffer.write('.');
      }
    }
    return '${buffer.toString()} VND';
  }

  Future<void> _showProductDialog(
    BuildContext context, {
    Product? initial,
    required void Function(Product product) onSave,
  }) async {
    final nameController = TextEditingController(text: initial?.name ?? '');
    final priceController = TextEditingController(
      text: initial == null ? '' : initial.price.toStringAsFixed(0),
    );
    final descController = TextEditingController(
      text: initial?.description ?? '',
    );

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(initial == null ? 'Thêm sản phẩm' : 'Sửa sản phẩm'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Tên sản phẩm'),
                  textInputAction: TextInputAction.next,
                ),
                TextField(
                  controller: priceController,
                  decoration: const InputDecoration(labelText: 'Giá (VND)'),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                ),
                TextField(
                  controller: descController,
                  decoration: const InputDecoration(labelText: 'Mô tả'),
                  textInputAction: TextInputAction.done,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Hủy'),
            ),
            ElevatedButton(
              onPressed: () {
                final name = nameController.text.trim();
                final priceText = priceController.text.trim();
                final price = double.tryParse(priceText);

                if (name.isEmpty || price == null) {
                  return;
                }

                onSave(
                  Product(
                    name: name,
                    price: price,
                    description: descController.text.trim(),
                  ),
                );
                Navigator.pop(dialogContext);
              },
              child: const Text('Lưu'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final store = StoreScope.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Danh sách sản phẩm")),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showProductDialog(
            context,
            onSave: (product) => store.addProduct(product),
          );
        },
        child: const Icon(Icons.add),
      ),

      body: AnimatedBuilder(
        animation: store,
        builder: (context, _) {
          final items = store.productsList;

          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final product = items[index];
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.shopping_bag),
                  title: Text(product.name),
                  subtitle: Text(_formatVnd(product.price)),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        tooltip: 'Thêm vào giỏ hàng',
                        onPressed: () {
                          store.addToCart(product);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Đã thêm vào giỏ hàng'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        },
                        icon: const Icon(Icons.add_shopping_cart),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          _showProductDialog(
                            context,
                            initial: product,
                            onSave: (updated) =>
                                store.updateProductAt(index, updated),
                          );
                        },
                        child: const Text("Sửa"),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        tooltip: 'Xóa',
                        onPressed: () {
                          store.removeProductAt(index);
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
