import 'package:flutter/material.dart';

import 'package:demo/store/store.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

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

  @override
  Widget build(BuildContext context) {
    final store = StoreScope.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Giỏ hàng")),

      body: AnimatedBuilder(
        animation: store,
        builder: (context, _) {
          final cart = store.cartList;
          final total = store.cartTotal;

          return ListView(
            children: [
              for (var i = 0; i < cart.length; i++)
                ListTile(
                  leading: const Icon(Icons.shopping_bag),
                  title: Text(cart[i].name),
                  subtitle: Text(_formatVnd(cart[i].price)),
                  trailing: IconButton(
                    tooltip: 'Xóa',
                    onPressed: () {
                      store.removeFromCartAt(i);
                    },
                    icon: const Icon(Icons.delete),
                  ),
                ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'Tổng tiền: ${_formatVnd(total)}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: cart.isEmpty
                          ? null
                          : () async {
                              await showDialog<void>(
                                context: context,
                                barrierDismissible: false,
                                builder: (dialogContext) {
                                  return AlertDialog(
                                    title: const Text('Thanh toán'),
                                    content: const Text(
                                      'Thanh toán thành công',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(dialogContext),
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );

                              if (!context.mounted) return;
                              store.clearCart();
                            },
                      child: const Text("Thanh toán"),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
