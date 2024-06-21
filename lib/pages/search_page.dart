import 'package:ecommerce_app/utilities/appstyle.dart';
import 'package:ecommerce_app/widgets/export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/sneaker_model.dart';
import '../services/sneaker_helper.dart';
import '../widgets/custom_field.dart';
import '../widgets/export_packages.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductNotifier>();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        elevation: 0,
        toolbarHeight: 100.h,
        title: CustomField(
          prefixIcon: GestureDetector(
              onTap: () {},
              child: const Icon(Icons.camera_alt, color: Colors.black)),
          suffixIcon: GestureDetector(
              onTap: () {
                //we need to call setState so it can rebuild controller.text.isEmpty
                // ? Container(
                //     height: 600.h,
                //     padding: EdgeInsets.all(20.h),
                //     margin: EdgeInsets.only(right: 50.w),
                //     child: Image.asset("assets/images/Pose23.png"))
                // : FutureBuilder<List<Sneaker>>
                //because of this ternary if we dont rebuild it, then the FutureBuilder wont run 
                setState(() {});
              },
              child: const Icon(Icons.search, color: Colors.black)),
          hintText: 'Search for a product',
          controller: controller,
          onEditingComplete: () {
            setState(() {});
          },
        ),
      ),
      body: controller.text.isEmpty
          ? Container(
              height: 600.h,
              padding: EdgeInsets.all(20.h),
              margin: EdgeInsets.only(right: 50.w),
              child: Image.asset("assets/images/Pose23.png"))
          : FutureBuilder<List<Sneaker>>(
              future: SneakerHelper().searchSneakers(queryString: controller.text),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator.adaptive());
                } else if (snapshot.hasError) {
                  return Center(
                      child: ReusableText(
                          text: "Error Retrieving data",
                          style: appStyle(
                              size: 20,
                              color: Colors.black,
                              fw: FontWeight.bold)));
                } else if (snapshot.data!.isEmpty) {
                  return Center(
                      child: ReusableText(
                          text: "Product not found",
                          style: appStyle(
                              size: 20,
                              color: Colors.black,
                              fw: FontWeight.bold)));
                } else {
                  final sneaker = snapshot.data!;
                  return ListView.builder(
                    itemCount: sneaker.length,
                    itemBuilder: (context, index) {
                      final data = snapshot.data![index];
                      return GestureDetector(
                        onTap: () {
                          productProvider.setShoeSizes = data.sizes;
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return ProductDetailPage(sneaker: data);
                              },
                            ),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.all(8.h),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.r),
                            child: Container(
                              height: 100.h,
                              width: 325.w,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade600,
                                        spreadRadius: 5,
                                        blurRadius: 0.3,
                                        offset: const Offset(0, 1)),
                                  ]),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(12.h),
                                    child: Image.network(
                                      data.imageUrl[0],
                                      fit: BoxFit.cover,
                                      width: 70.w,
                                      height: 70.h,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 12.h, left: 20.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ReusableText(
                                          text: sneaker[index].name,
                                          style: appStyle(
                                              size: 16,
                                              color: Colors.black,
                                              fw: FontWeight.w600),
                                        ),
                                        const SizedBox(height: 5),
                                        ReusableText(
                                          text: sneaker[index].category,
                                          style: appStyle(
                                              size: 13,
                                              color: Colors.grey.shade600,
                                              fw: FontWeight.w600),
                                        ),
                                        const SizedBox(height: 5),
                                        ReusableText(
                                          text: "\$ ${sneaker[index].price}",
                                          style: appStyle(
                                              size: 13,
                                              color: Colors.grey.shade600,
                                              fw: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
    );
  }
}
