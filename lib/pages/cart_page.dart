import 'package:flutter/material.dart';
import 'package:coffeui/models/models.dart';

class CartPage extends StatefulWidget {
  final Cart cart;

  CartPage({required this.cart});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void _showOrderConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Xác nhận đặt hàng'),
          content: Text('Bạn có chắc chắn muốn đặt hàng không?'),
          actions: <Widget>[
            TextButton(
              child: Text('Hủy'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Xác nhận'),
              onPressed: () {
                // Xử lý logic đặt hàng ở đây
                Navigator.of(context).pop();
                _showOrderSuccess();
              },
            ),
          ],
        );
      },
    );
  }

  void _showOrderSuccess() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Đặt hàng thành công'),
          content: Text('Cảm ơn bạn đã đặt hàng!'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Quay lại trang trước
              },
            ),
          ],
        );
      },
    );
  }

  void _editProductQuantity(Product product) {
    TextEditingController _quantityController = TextEditingController(text: product.quantity.toString());
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sửa số lượng'),
          content: TextField(
            controller: _quantityController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: "Nhập số lượng mới"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Hủy'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Lưu'),
              onPressed: () {
                setState(() {
                  widget.cart.updateProductQuantity(product.id, int.parse(_quantityController.text));
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Giỏ hàng của bạn'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: widget.cart.products.length,
              itemBuilder: (context, index) {
                final product = widget.cart.products[index];
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text('Số lượng: ${product.quantity}',style: TextStyle(fontSize: 20)),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          _editProductQuantity(product);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            widget.cart.removeProduct(product.id);
                          });
                        },
                      ),
                      Text('${product.price * product.quantity} VND',style: TextStyle(fontSize: 20)),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Tổng cộng: ${widget.cart.totalPrice} VND',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: _showOrderConfirmation,
                  child: Text('Đặt hàng'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
