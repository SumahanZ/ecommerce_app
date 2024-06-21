import 'package:ecommerce_app/models/orders/orders_res.dart';
import 'package:ecommerce_app/services/cart_helper.dart';
import 'package:ecommerce_app/widgets/export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_flutter/icons_flutter.dart';

class ProcessOrders extends StatefulWidget {
  const ProcessOrders({super.key});

  @override
  State<ProcessOrders> createState() => _ProcessOrdersState();
}

class _ProcessOrdersState extends State<ProcessOrders> {
  late Future<List<PaidOrders>> _orders;

  @override
  void initState() {
    super.initState();
    _orders = CartHelper().getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40.h,
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black,
          height: 825.h,
          width: 325.w,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReusableText(
                    text: "My Orders",
                    style: appStyle(
                        size: 36, color: Colors.white, fw: FontWeight.bold)),
                const SizedBox(height: 5),
                Container(
                  width: 325.w,
                  height: 650.h,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  child: FutureBuilder<List<PaidOrders>>(
                    future: _orders,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                            child: CircularProgressIndicator.adaptive());
                      } else if (snapshot.hasError) {
                        return ReusableText(
                            text: "Error ${snapshot.error}",
                            style: appStyle(
                                size: 18,
                                color: Colors.black,
                                fw: FontWeight.bold));
                      } else {
                        final products = snapshot.data!;
                        return ListView.builder(
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            final order = products[index];
                            return Container(
                              margin: const EdgeInsets.all(8),
                              padding: const EdgeInsets.all(8),
                              height: 90.h,
                              decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Image.network(
                                                order.productId.imageUrl[0]),
                                          )),
                                      SizedBox(width: 5.w),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ReusableText(
                                            text: order.productId.name,
                                            style: appStyle(
                                                size: 12,
                                                color: Colors.black,
                                                fw: FontWeight.bold),
                                          ),

                                          SizedBox(height: 5.h),

                                          ///the smaller our widget becomes the small the text becomes
                                          //so we dont get overflow error
                                          SizedBox(
                                            width: 325 * 0.55,
                                            //fitted box resizes the text to the size of the widget
                                            child: FittedBox(
                                              child: ReusableText(
                                                text: order.productId.title,
                                                style: appStyle(
                                                    size: 12,
                                                    color: Colors.grey.shade700,
                                                    fw: FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 5.h),
                                          ReusableText(
                                            text: "\$ ${order.productId.price}",
                                            style: appStyle(
                                                size: 12,
                                                color: Colors.grey.shade600,
                                                fw: FontWeight.w600),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 25,
                                        ),
                                        decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: ReusableText(
                                          text:
                                              order.paymentStatus.toUpperCase(),
                                          style: appStyle(
                                              size: 10,
                                              color: Colors.white,
                                              fw: FontWeight.w600),
                                        ),
                                      ),
                                      SizedBox(height: 8.h),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 5,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.black12,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Row(
                                          children: [
                                            const Icon(
                                                MaterialCommunityIcons
                                                    .truck_fast,
                                                size: 14),
                                            SizedBox(width: 4.h),
                                            ReusableText(
                                              text: order.deliveryStatus
                                                  .toUpperCase(),
                                              style: appStyle(
                                                  size: 10,
                                                  color: Colors.black,
                                                  fw: FontWeight.normal),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
