import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class BannerSlider extends StatelessWidget {
  const BannerSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> bannerImages = [
      'assets/banner/b.png',
      'assets/banner/a.png',
      'assets/banner/c.png',
    ];

    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height * 0.6,
            viewportFraction: 1.0,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
          ),
          items: bannerImages.map((path) {
            return Builder(
              builder: (BuildContext context) {
                return Image.asset(
                  path,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Text('Image not found!',
                          style: TextStyle(color: Colors.red)),
                    );
                  },
                );
              },
            );
          }).toList(),
        ),

        // Overlay content
       
      ],
    );
  }
}
