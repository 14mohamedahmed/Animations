import 'package:animations/cart_animation/model/product_model.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen(this.prod, {this.addToCart, super.key});
  final ProductModel prod;
  final Function(String)? addToCart;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  String cartTag = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Container(
            color: const Color(0xFFEAEAEA),
            height: 250,
            child: Hero(
              tag: widget.prod.title.toString() + cartTag,
              child: Center(
                child: Image.asset(widget.prod.image),
              ),
            ),
          ),
          const SizedBox(height: 100),
          Center(
            child: SizedBox(
              height: 30,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    cartTag = "_cartTag";
                  });
                  widget.addToCart!("${widget.prod.title}$cartTag");
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: const Text(
                  "ADD TO CART",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
