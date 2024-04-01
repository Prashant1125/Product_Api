import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:product_api/models/product_model.dart';

class ProductDetail extends StatefulWidget {
  final Products product;
  const ProductDetail(this.product, {super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 32, 0, 37),
          centerTitle: true,
          title: const Text(
            'Product API',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        body: ListView(
          shrinkWrap: true,
          children: [
            CarouselSlider(
                items: widget.product.images
                    .map(
                      (e) => ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: CachedNetworkImage(
                          imageUrl: e.toString(),
                          height: 175,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  CircularProgressIndicator(
                                      value: downloadProgress.progress),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    )
                    .toList(),
                options: CarouselOptions(
                    autoPlay: true,
                    viewportFraction: 0.8,
                    enlargeCenterPage: true)),
          ],
        ));
  }
}
