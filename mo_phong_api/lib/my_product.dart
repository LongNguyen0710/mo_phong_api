import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/product.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Product App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: My_Product(),
    );
  }
}

class My_Product extends StatelessWidget {
  const My_Product({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Danh sách sản phẩm"),
      ),
      body: FutureBuilder<List<Product>>(
        future: Product.fetchData(),
        builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data;
            return MyProduct(lsMyProduct: data!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class MyProduct extends StatelessWidget {
  MyProduct({Key? key, required this.lsMyProduct}) : super(key: key);
  final List<Product> lsMyProduct;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: lsMyProduct.length,
      itemBuilder: (context, index) {
        var product = lsMyProduct[index];
        return Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: CachedNetworkImage(
                  imageUrl: product.image,
                  placeholder: (context, imageUrl) => Container(
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text("Price: \$${product.price}"),
                    Text("Category: ${product.category}"),
                    Text(
                        "Rating: ${product.rating.rate} (${product.rating.count} reviews)"),
                    Text(
                      'Description: ${product.description}',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
