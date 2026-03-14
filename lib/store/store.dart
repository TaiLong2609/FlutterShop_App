import 'package:flutter/widgets.dart';

import '../models/product.dart';

class Store extends ChangeNotifier {
  Store({List<Product>? initialProducts})
    : _products = List<Product>.from(initialProducts ?? products);

  final List<Product> _products;
  final List<Product> _cart = <Product>[];

  List<Product> get productsList => List<Product>.unmodifiable(_products);
  List<Product> get cartList => List<Product>.unmodifiable(_cart);

  double get cartTotal =>
      _cart.fold<double>(0, (total, product) => total + product.price);

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }

  void updateProductAt(int index, Product updated) {
    if (index < 0 || index >= _products.length) return;

    final old = _products[index];
    _products[index] = updated;

    for (var i = 0; i < _cart.length; i++) {
      if (identical(_cart[i], old)) {
        _cart[i] = updated;
      }
    }

    notifyListeners();
  }

  void removeProductAt(int index) {
    if (index < 0 || index >= _products.length) return;

    final removed = _products.removeAt(index);
    _cart.removeWhere((p) => identical(p, removed));
    notifyListeners();
  }

  void addToCart(Product product) {
    _cart.add(product);
    notifyListeners();
  }

  void removeFromCartAt(int index) {
    if (index < 0 || index >= _cart.length) return;
    _cart.removeAt(index);
    notifyListeners();
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }
}

class StoreScope extends InheritedNotifier<Store> {
  const StoreScope({super.key, required Store store, required super.child})
    : super(notifier: store);

  static Store of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<StoreScope>();
    assert(scope != null, 'StoreScope not found in widget tree');
    return scope!.notifier!;
  }
}
