import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:product_api/models/product_model.dart';
import 'package:product_api/style/textstyle.dart';

import 'home.dart';

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
        leading: const BackButton(
          color: Colors.grey,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
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
                              (context, url, downloadProgress) => Center(
                            child: CircularProgressIndicator(
                                value: downloadProgress.progress),
                          ),
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
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.product.title,
              style: titlestyle.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  fontFamily: 'Cursive',
                  color: const Color.fromARGB(255, 109, 135, 184)),
            ),
            Text(
              'Hurry up ${widget.product.stock} Items are Left',
              style: discountstyle.copyWith(
                  fontSize: 17, color: Colors.red, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  ' ₹ ${widget.product.price}00 ',
                  style: pricestyle,
                ),
                RatingBar.builder(
                  itemSize: 20,
                  initialRating: widget.product.rating!,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                  itemBuilder: (context, _) => const Icon(Icons.star,
                      color: Color.fromARGB(255, 0, 63, 2)),
                  onRatingUpdate: (rating) {},
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Discount ${widget.product.discountPercentage} %',
              style: discountstyle,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Description - ${widget.product.description}',
              style: titlestyle,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Brand - ${widget.product.brand}',
              style: titlestyle,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Category - ${widget.product.category}',
              style: titlestyle,
            ),
          ],
        ),
      ),
      bottomSheet: Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Card(
              elevation: 10,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10)),
                width: mq.width * .45,
                height: 30,
                child: MaterialButton(
                  onPressed: () {},
                  child: const Text('Add To Cart'),
                ),
              ),
            ),
            Card(
              elevation: 10,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10)),
                width: mq.width * .45,
                height: 30,
                child: MaterialButton(
                  onPressed: () {},
                  child: const Text('Buy Now'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
