import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:product_api/models/product_model.dart';

late Size mq;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<Product> getProductApi() async {
    final response =
        await http.get(Uri.parse('https://dummyjson.com/products'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return Product.fromJson(data);
    } else {
      return Product.fromJson(data);
    }
  }

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
                  return ListView.builder(
                    itemCount: snapshot.data!.products.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Image.network(
                              snapshot.data!.products[index].thumbnail)
                        ],
                      );
                    },
                  );
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
