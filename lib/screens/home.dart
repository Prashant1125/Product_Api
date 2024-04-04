import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:product_api/models/product_model.dart';
import 'package:product_api/screens/detail.dart';
import '../api/api.dart';
import '../style/textstyle.dart';

late Size mq;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 32, 0, 37),
        centerTitle: true,
        title: const Text(
          'Product API',
          style: TextStyle(color: Colors.grey),
        ),
        leading: const Icon(
          Icons.home,
          color: Colors.grey,
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(3.0),
            child: CircleAvatar(
              child: Icon(
                Icons.person,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<Product>(
              future: getProductApi(),
              builder: (context, AsyncSnapshot<Product> snapshot) {
                if (snapshot.hasData) {
                  return GridView.builder(
                    itemCount: snapshot.data!.products.length,
                    itemBuilder: (context, index) {
                      var product = snapshot.data!.products[index];

                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetail(product),
                              ));
                        },
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                color: const Color.fromARGB(255, 192, 247, 237),
                                elevation: 10,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: CachedNetworkImage(
                                          imageUrl: product.thumbnail,
                                          fit: BoxFit.cover,
                                          height: 150,
                                          width: mq.width * 0.8,
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              Center(
                                            child: CircularProgressIndicator(
                                                value:
                                                    downloadProgress.progress),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                ' ₹ ${product.price}00',
                                                style: pricestyle,
                                              ),
                                              SizedBox(
                                                width: mq.width * .020,
                                              ),
                                              Text(
                                                'Discount ${product.discountPercentage} %',
                                                style: discountstyle,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                product.title.length > 20
                                                    ? '${product.title.substring(0, 20)}...'
                                                    : product.title,
                                                style: titlestyle.copyWith(
                                                  fontSize: 15,
                                                ),
                                              ),
                                              RatingBar.builder(
                                                itemSize: 20,
                                                initialRating: product.rating!,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                itemPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 1.0),
                                                itemBuilder: (context, _) =>
                                                    const Icon(Icons.star,
                                                        color: Color.fromARGB(
                                                            255, 0, 63, 2)),
                                                onRatingUpdate: (rating) {},
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisSpacing: 0,
                            childAspectRatio: 1.3),
                  );
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
