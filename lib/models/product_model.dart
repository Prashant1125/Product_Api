class Product {
  Product({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });
  late final List<Products> products;
  late final int total;
  late final int skip;
  late final int limit;

  Product.fromJson(Map<String, dynamic> json) {
    products =
        List.from(json['products']).map((e) => Products.fromJson(e)).toList();
    total = json['total'];
    skip = json['skip'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['products'] = products.map((e) => e.toJson()).toList();
    data['total'] = total;
    data['skip'] = skip;
    data['limit'] = limit;
    return data;
  }
}

class Products {
  Products({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    // required this.rating,
    required this.stock,
    required this.brand,
    required this.category,
    required this.thumbnail,
    required this.images,
  });
  late final int id;
  late final String title;
  late final String description;
  late final int price;
  late final double discountPercentage;
  // late final double? rating;
  late final int stock;
  late final String brand;
  late final String category;
  late final String thumbnail;
  late final List<String> images;

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    discountPercentage = json['discountPercentage'];
    // rating = json['rating'];
    stock = json['stock'];
    brand = json['brand'];
    category = json['category'];
    thumbnail = json['thumbnail'];
    images = List.castFrom<dynamic, String>(json['images']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['price'] = price;
    data['discountPercentage'] = discountPercentage;
    // data['rating'] = rating;
    data['stock'] = stock;
    data['brand'] = brand;
    data['category'] = category;
    data['thumbnail'] = thumbnail;
    data['images'] = images;
    return data;
  }
}
