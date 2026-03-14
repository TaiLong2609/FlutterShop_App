class Product {
  final String name;
  final double price;
  final String description;

  Product({
    required this.name,
    required this.price,
    required this.description,
  });
}

List<Product> products = [
  Product(
    name: "Áo thun",
    price: 200000,
    description: "Áo thun cotton thoải mái",
  ),
  Product(
    name: "Quần jean",
    price: 400000,
    description: "Quần jean thời trang",
  ),
  Product(
    name: "Giày thể thao",
    price: 600000,
    description: "Giày chạy bộ",
  ),
];