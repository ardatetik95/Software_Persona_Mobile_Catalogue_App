import 'package:flutter/material.dart';
import '../models/product_mode.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  final Set<String> cart;

  const ProductDetailScreen({super.key, required this.product, required this.cart});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text("Back", style: TextStyle(color: Colors.black)),
        leadingWidth: 25,
        backgroundColor: Colors.blue[400],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
          children: [
            Hero(tag: widget.product.id, 
            child: Image(image:  NetworkImage(widget.product.image), height: 350, width: double.infinity, fit: BoxFit.contain,)),
            SizedBox(height: 16),
          
            SizedBox(height: 2),
          
                Padding(padding: EdgeInsets.all(16), 
                child: Column(children: [Text(widget.product.title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                SizedBox(height: 10),
                Text(widget.product.description, style: TextStyle(fontSize: 16),),
                SizedBox(height: 10),
                Text("\$${widget.product.price}", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          
                SizedBox(height: 14),
          
                ElevatedButton(onPressed: () {
                  setState(() {
                    widget.cart.add(widget.product.id.toString());
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Added to cart!"),
                    backgroundColor: Colors.blue[400],
                    behavior: SnackBarBehavior.floating,
                    margin: EdgeInsets.only(bottom: 80, left: 20, right: 20),)
                  );
                }, style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue[400],
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                ), child: Text("Add to Cart"),
                ),
                ],
                ),
                )
                ],
                ),
        ),
    ),
    );
  }
}