import 'dart:convert';
import 'package:http/http.dart' as http;

class Rating {
  double rate;
  int count;

  Rating({required this.rate, required this.count});

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: json['rate']?.toDouble() ?? 0.0,
      count: json['count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rate': rate,
      'count': count,
    };
  }
}

class Product {
  int id;
  String title;
  double price;
  String description;
  String category;
  String image;
  Rating rating;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      description: json['description'],
      category: json['category'],
      image: json['image'],
      rating: Rating.fromJson(json['rating']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'image': image,
      'rating': rating.toJson(),
    };
  }

  static Future<List<Product>> fetchData() async {
    var apiUrl = 'https://fakestoreapi.com/products';
    var response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      var body = response.body;
      var json = jsonDecode(body);

      print(json); // In ra dữ liệu JSON để kiểm tra

      var ls = json.map<Product>((e) {
        return Product.fromJson(e);
      }).toList();
      return ls;
    } else {
      throw Exception("Không có dữ liệu trả về");
    }
  }
}
