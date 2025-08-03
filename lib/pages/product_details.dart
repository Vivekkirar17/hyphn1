import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hyphn/pages/global_variable.dart';
import 'package:hyphn/main_scafflod.dart';

class ProductDetailsPage extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetailsPage({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  final TextEditingController reviewController = TextEditingController();
  double rating = 3.0;

  Future<void> submitReview() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("You must be logged in to submit a review.")),
      );
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('reviews').add({
        'productId': widget.product['id'],
        'userId': user.uid,
        'userName': user.email ?? 'Anonymous',
        'comment': reviewController.text,
        'rating': rating,
        'timestamp': Timestamp.now(),
      });

      reviewController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Review submitted successfully.")),
      );
    } catch (e) {
      print("Review submission failed: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Review failed: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return MainScaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              product['image'] ?? '',
              width: double.infinity,
              height: 280,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.image_not_supported, size: 100),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product['name'] ?? '',
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text("₹ ${product['price'] ?? ''}",
                      style: const TextStyle(fontSize: 20, color: Colors.green)),
                  const SizedBox(height: 16),
                  Text(product['description'] ?? 'No description available.',
                      style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 24),
                  Center(
                    child: SizedBox(
                      width: 220,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          cartItems.add({
                            "name": product['name'].toString(),
                            "image": product['image'].toString(),
                            "price": product['price'].toString(),
                            "description": product['description'].toString(),
                          });

                          cartCount.value = cartItems.length;

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("${product['name']} added to cart")),
                          );
                        },
                        icon: const Icon(Icons.add_shopping_cart),
                        label: const Text("Add to Cart", style: TextStyle(fontSize: 18)),
                        style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(14)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Divider(),
                  const Text("Reviews", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('reviews')
                        .where('productId', isEqualTo: product['id'])
                        .orderBy('timestamp', descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Text("Error loading reviews");
                      }
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final reviews = snapshot.data!.docs;
                      if (reviews.isEmpty) {
                        return const Text("No reviews yet. Be the first!");
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: reviews.length,
                        itemBuilder: (context, index) {
                          final review = reviews[index].data() as Map<String, dynamic>;
                          return ListTile(
                            title: Text(review['userName'] ?? 'User'),
                            subtitle: Text(review['comment']),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: List.generate(5, (i) {
                                return Icon(
                                  i < (review['rating'] ?? 0) ? Icons.star : Icons.star_border,
                                  color: Colors.amber,
                                  size: 18,
                                );
                              }),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text("Write a Review", style: TextStyle(fontSize: 18)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: reviewController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      hintText: "Write your review here...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Text("Rating: "),
                      Slider(
                        value: rating,
                        onChanged: (newRating) {
                          setState(() {
                            rating = newRating;
                          });
                        },
                        divisions: 4,
                        label: rating.toString(),
                        min: 1,
                        max: 5,
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: submitReview,
                    child: const Text("Submit Review"),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
