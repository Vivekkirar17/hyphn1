import 'package:flutter/material.dart';
import 'global_variable.dart'; // Make sure to import the file with cartItems

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cart")),
      body: cartItems.isEmpty
          ? Center(child: Text("Your cart is empty"))
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    leading: Image.asset(
                      item['image'] ?? '',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(item['name'] ?? ''),
                    subtitle: Text(item['price'] ?? ''),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        cartItems.removeAt(index);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("${item['name']} removed")),
                        );
                        // Force UI update
                        (context as Element).markNeedsBuild();
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
