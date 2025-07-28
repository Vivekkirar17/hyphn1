import 'package:flutter/material.dart';
import 'package:hyphn/pages/global_variable.dart';
import 'cart_page.dart';

class ProductDetailsPage extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductDetailsPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product['name'] ?? 'Product Details'),
      actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) =>  CartPage()),
            ),
          ),
        ],),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              product['image'] ?? '',
              height: 250,
              width: 300,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['name'] ?? '',
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "₹ ${product['price'] ?? ''}",
                    style: const TextStyle(fontSize: 20, color: Colors.green),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    product['description'] ?? '',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        // Convert product to Map<String, String> and add
                        cartItems.add({
                          "name": product['name'].toString(),
                          "image": product['image'].toString(),
                          "price": product['price'].toString(),
                          "description": product['description'].toString(),
                        });

                        // Update cart count
                        cartCount.value = cartItems.length;

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("${product['name']} added to cart")),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: const Text("Add to Cart", style: TextStyle(fontSize: 18)),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
