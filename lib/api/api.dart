import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

Future<Product> getProductApi() async {
  final response = await http.get(Uri.parse('https://dummyjson.com/products'));
  var data = jsonDecode(response.body.toString());
  if (response.statusCode == 200) {
    return Product.fromJson(data);
  } else {
    return Product.fromJson(data);
  }
}
