import 'package:animations/cart_animation/controller/home_controller.dart';
import 'package:animations/cart_animation/model/product_model.dart';
import 'package:animations/cart_animation/pridut_details_screen.dart';
import 'package:animations/cart_animation/product_item.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController controller = HomeController();
  double cartHeight = 75;
  bool displayFullCart = false;
  List<ProductModel> cartProducts = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFEAEAEA),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return GestureDetector(
              onTap: () {
                displayFullCart = false;
                setState(() {});
              },
              child: SizedBox(
                height: constraints.maxHeight,
                child: Stack(
                  children: [
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 250),
                      child: Container(
                        height: !displayFullCart
                            ? constraints.maxHeight - cartHeight
                            : constraints.maxHeight * .4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft:
                                Radius.circular(!displayFullCart ? 25 : 0),
                            bottomRight:
                                Radius.circular(!displayFullCart ? 25 : 0),
                          ),
                          color: Colors.white,
                        ),
                        child: GridView.builder(
                          itemCount: controller.products.length,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.75,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemBuilder: (context, index) {
                            return ProductItem(
                              controller.products[index],
                              press: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    reverseTransitionDuration:
                                        const Duration(seconds: 1),
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        FadeTransition(
                                      opacity: animation,
                                      child: ProductDetailsScreen(
                                        controller.products[index],
                                        addToCart: (String heroTag) {
                                          if (cartProducts.contains(
                                              controller.products[index])) {
                                            int i = cartProducts.indexOf(
                                                controller.products[index]);
                                            cartProducts[i].quantity++;
                                          } else {
                                            cartProducts.add(
                                                controller.products[index]);
                                          }

                                          setState(() {});
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 250),
                      bottom: 0,
                      left: 0,
                      right: 0,
                      height: !displayFullCart
                          ? cartHeight
                          : constraints.maxHeight * .6,
                      child: GestureDetector(
                        onVerticalDragUpdate: (details) {
                          if (details.primaryDelta! < -0.7) {
                            displayFullCart = true;
                          } else if (details.primaryDelta! > 4) {
                            displayFullCart = false;
                          }
                          setState(() {});
                        },
                        child: Container(
                          color: const Color(0xFFEAEAEA),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              _ShoopingCart(cartProducts),
                              Expanded(
                                child: _CartList(cartProducts),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ShoopingCart extends StatelessWidget {
  const _ShoopingCart(this.cartProducts);
  final List<ProductModel> cartProducts;

  @override
  Widget build(BuildContext context) {
    int totalQuantity =
        cartProducts.fold(0, (sum, product) => sum + product.quantity);

    return SizedBox(
      height: 40,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            right: 0,
            left: 0,
            height: 0,
            child: Hero(
              tag: cartProducts.isNotEmpty
                  ? "${cartProducts.last.title}_cartTag"
                  : "",
              child: cartProducts.isNotEmpty
                  ? Image.asset(cartProducts.last.image)
                  : const SizedBox.shrink(),
            ),
          ),
          const Positioned(
            right: 0,
            top: 0,
            left: 0,
            child: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Icon(
                Icons.shopping_cart_outlined,
                size: 30,
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            left: 30,
            child: Visibility(
              visible: cartProducts.isNotEmpty,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green,
                ),
                width: 20,
                height: 20,
                child: Center(
                  child: Text(
                    totalQuantity.toString(),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CartList extends StatelessWidget {
  const _CartList(this.products);
  final List<ProductModel> products;
  @override
  Widget build(BuildContext context) {
    return products.isEmpty
        ? const  Text("No products avalible in cart")
        : ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final item = products[index];
              return ListTile(
                leading: Image.asset(item.image),
                title: Text("${item.title}     x${item.quantity}"),
                trailing: Text(
                  "${item.price * item.quantity}\$",
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              );
            },
          );
  }
}
