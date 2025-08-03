 import 'package:flutter/material.dart';

final products = [
    {
      "name": "Wireless Earbuds",
      "image": "assets/image/c.png", // Add this image to your assets
      "price": "499",
       "description": "Over-ear headphones with deep bass and noise cancellation.",
    },
    {
      "name": "Bluetooth Speaker",
      "image": "assets/image/b.png", // Add this image to your assets
      "price": "599",
      "description": "Portable Bluetooth speaker with high sound quality.",
    },
    {
      "name": "Bluetooth Speaker",
      "image": "assets/image/e.jpg", // Add this image to your assets
      "price": "499",
       "description": "Over-ear headphones with deep bass and noise cancellation.",
    },
    {
      "name": "Bluetooth Speaker",
      "image": "assets/image/f.png", // Add this image to your assets
      "price": "499",
        "description": "Over-ear headphones with deep bass and noise cancellation.",
    },
    {
      "name": "Bluetooth Speaker",
      "image": "assets/image/f.png", // Add this image to your assets
      "price": "499",
        "description": "Over-ear headphones with deep bass and noise cancellation.",
    },
  ];
  List<Map<String, String>> cartItems = [];
ValueNotifier<int> cartCount = ValueNotifier<int>(0);
