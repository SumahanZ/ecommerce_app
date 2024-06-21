import 'package:ecommerce_app/controllers/payment_provider.dart';
import 'package:ecommerce_app/models/orders/orders_req.dart';
import 'package:ecommerce_app/pages/payments/paymentwebview.dart';
import 'package:ecommerce_app/services/cart_helper.dart';
import 'package:ecommerce_app/widgets/export_packages.dart';
import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/get_products.dart';
import '../services/payment_helper.dart';
import '../widgets/export.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late Future<List<Product>> _cartList;
  @override
  void initState() {
    super.initState();
    _cartList = CartHelper().getCart();
  }

  @override
  Widget build(BuildContext context) {
    final cartNotifier = context.watch<CartNotifier>();
    final paymentNotifier = context.watch<PaymentNotifier>();
    return paymentNotifier.paymentUrl.contains("https") ? const PaymentWebView() : Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40.h,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.close, color: Colors.black),
                ),
                Text(
                  "My Cart",
                  style: appStyle(
                      size: 36, color: Colors.black, fw: FontWeight.bold),
                ),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  height: 530.h,
                  child: FutureBuilder(
                      future: _cartList,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator.adaptive());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: ReusableText(
                                  text: "Failed to get cart data",
                                  style: appStyle(
                                      size: 18,
                                      color: Colors.black,
                                      fw: FontWeight.w600)));
                        } else {
                          final cart = snapshot.data!;
                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: cart.length,
                            itemBuilder: (context, index) {
                              final data = cart[index];
                              return GestureDetector(
                                onTap: () {
                                  context
                                      .read<CartNotifier>()
                                      .selectedProductCheckoutIndex = index;
                                  context
                                      .read<CartNotifier>()
                                      .checkOut
                                      .insert(0, data);
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(8.h),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12.r),
                                    child: Container(
                                      height: 100.h,
                                      width: 375.w,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey.shade500,
                                              spreadRadius: 5,
                                              blurRadius: 0.3,
                                              offset: const Offset(0, 1)),
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Stack(
                                                  clipBehavior: Clip.none,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(12.r),
                                                      child: Image.network(
                                                          data.cartItem
                                                              .imageUrl[0],
                                                          width: 70.w,
                                                          height: 70.h,
                                                          fit: BoxFit.fill),
                                                    ),
                                                    Positioned(
                                                      top: -4,
                                                      child: GestureDetector(
                                                        onTap: () {},
                                                        child: SizedBox(
                                                          height: 30.h,
                                                          width: 30.w,
                                                          child: Icon(
                                                              cartNotifier.selectedProductCheckoutIndex ==
                                                                      index
                                                                  ? Feather
                                                                      .check_square
                                                                  : Feather
                                                                      .square,
                                                              size: 20.r,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      bottom: -5,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          CartHelper()
                                                              //pass in data.id because if you do data.cartItem.id we are referring to the product id, but what we want to delete is based on the object id of the product in the products array, they get an auto generated ObjectId.
                                                              .deleteItemCart(
                                                                  data.id)
                                                              .then((response) {
                                                            if (response ==
                                                                true) {
                                                              Navigator.of(
                                                                      context)
                                                                  .pushReplacement(
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (context) {
                                                                    return MainPage();
                                                                  },
                                                                ),
                                                              );
                                                            } else {
                                                              debugPrint(
                                                                  "Failed to delete the item");
                                                            }
                                                          });
                                                          // context
                                                          //     .read<CartNotifier>()
                                                          //     .deleteItemFromCart(
                                                          //         data["key"]);
                                                        },
                                                        child: Container(
                                                          width: 40.w,
                                                          height: 30.h,
                                                          decoration:
                                                              const BoxDecoration(
                                                            color: Colors.black,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              topRight: Radius
                                                                  .circular(12),
                                                            ),
                                                          ),
                                                          child: Icon(
                                                              Icons.delete,
                                                              size: 20.r,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                  ]),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: 4.h, left: 20.w),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      data.cartItem.name,
                                                      style: appStyle(
                                                          size: 16,
                                                          color: Colors.black,
                                                          fw: FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      height: 5.h,
                                                    ),
                                                    Text(
                                                      data.cartItem.category,
                                                      style: appStyle(
                                                          size: 14,
                                                          color: Colors.grey,
                                                          fw: FontWeight.w600),
                                                    ),
                                                    SizedBox(
                                                      height: 2.h,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "\$${data.cartItem.price}",
                                                          style: appStyle(
                                                              size: 14,
                                                              color:
                                                                  Colors.black,
                                                              fw: FontWeight
                                                                  .w600),
                                                        ),
                                                      ],
                                                    ),
                                                    // Row(
                                                    //   children: [
                                                    //     Text(
                                                    //       "Size:",
                                                    //       style: appStyle(
                                                    //           size: 14,
                                                    //           color: Colors.grey,
                                                    //           fw: FontWeight
                                                    //               .w600),
                                                    //     ),
                                                    //     SizedBox(width: 6.w),
                                                    //     Text(
                                                    //       "${data["sizes"].join(", ")}",
                                                    //       style: appStyle(
                                                    //           size: 14,
                                                    //           color: Colors.grey,
                                                    //           fw: FontWeight
                                                    //               .w600),
                                                    //     ),
                                                    //   ],
                                                    // )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(8.0.r),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    // color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.r),
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          // context
                                                          //     .read<
                                                          //         CartNotifier>()
                                                          //     .decrement(
                                                          //         data["key"]);
                                                          // context
                                                          //     .read<
                                                          //         CartNotifier>()
                                                          //     .getCartData();
                                                        },
                                                        child: const Icon(
                                                            AntIcons
                                                                .minusSquareFilled,
                                                            size: 20,
                                                            color: Colors.grey),
                                                      ),
                                                      Text(
                                                        data.quantity
                                                            .toString(),
                                                        style: appStyle(
                                                            size: 14,
                                                            color: Colors.black,
                                                            fw: FontWeight
                                                                .w600),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          // context
                                                          //     .read<
                                                          //         CartNotifier>()
                                                          //     .increment(
                                                          //         data["key"]);
                                                          // context
                                                          //     .read<
                                                          //         CartNotifier>()
                                                          //     .getCartData();
                                                        },
                                                        child: Icon(
                                                            AntIcons
                                                                .plusSquareFilled,
                                                            size: 20.r,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      }),
                ),
              ],
            ),
            cartNotifier.checkOut.isNotEmpty
                ? Align(
                    alignment: Alignment.bottomCenter,
                    child: CheckoutButton(
                      label: "Proceed to Checkout",
                      onTap: () async {
                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        final userId = prefs.getString("userId") ?? "";
                        Order model = Order(userId: userId, cartItems: [
                          CartItem(
                              name: cartNotifier.checkOut[0].cartItem.name,
                              id: cartNotifier.checkOut[0].cartItem.id,
                              price: cartNotifier.checkOut[0].cartItem.price,
                              cartQuantity: 1),
                        ]);
                        PaymentHelper().payment(model).then(
                          (paymentUrl) {
                            print(paymentUrl);
                            paymentNotifier.paymentUrl = paymentUrl;
                            //every url has to contain https (cancel, success, anything)
                            //if it contains https we are gonna show the webview
                            //if it doesnt we dont show anything
                          },
                        );
                      },
                    ),
                  )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
