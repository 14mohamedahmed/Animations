import 'package:animations/cart_animation/model/product_model.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  const ProductItem(this.prod, {this.press, super.key});
  final ProductModel prod;
  final Function()? press;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFEAEAEA),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: prod.title.toString(),
              child: Center(
                child: SizedBox(
                  height: 150,
                  child: Image.asset(prod.image),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  prod.title,
                  style: const TextStyle(
                    color: Color(0xFF3F3D3D),
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
                Text(
                  "${prod.price}\$",
                  style: const TextStyle(
                    color: Color(0xFF3F3D3D),
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
