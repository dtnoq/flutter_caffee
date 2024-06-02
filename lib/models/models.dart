class Product {
  final String id;
  final String name;
  final double price;
  int quantity;

  Product({required this.id, required this.name, required this.price, this.quantity = 1});
}

class Cart {
  List<Product> _products = [];

  List<Product> get products => _products;

  void addProduct(Product product) {
    _products.add(product);
  }

  void removeProduct(String productId) {
    _products.removeWhere((product) => product.id == productId);
  }

  void updateProductQuantity(String productId, int quantity) {
    for (var product in _products) {
      if (product.id == productId) {
        product.quantity = quantity;
        break;
      }
    }
  }

  double get totalPrice {
    return _products.fold(0, (total, product) => total + product.price * product.quantity);
  }
}
