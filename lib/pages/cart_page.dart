import 'package:flutter/material.dart';
import 'checkout_page.dart';
import 'global_variable.dart';
import 'package:hyphn/main_scafflod.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double getTotal() {
    return cartItems.fold(0, (sum, item) {
      return sum + (double.tryParse(item['price'] ?? '0') ?? 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      
      body: cartItems.isEmpty
          ? const Center(child: Text("🛒 Your cart is empty"))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return Card(
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          leading: Image.asset(
                            item['image'] ?? '',
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(item['name'] ?? ''),
                          subtitle: Text("₹ ${item['price'] ?? ''}"),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                cartItems.removeAt(index);
                                cartCount.value = cartItems.length;
                              });

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("${item['name']} removed")),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total: ₹ ${getTotal().toStringAsFixed(2)}",
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const CheckoutPage()),
                          );
                        },
                        child: const Text("Checkout"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
