import 'package:ecommerce_app/controllers/login_provider.dart';
import 'package:ecommerce_app/pages/auth/login_page.dart';
import 'package:ecommerce_app/pages/notauthenticateduser_page.dart';
import 'package:ecommerce_app/pages/orders/orders.dart';
import 'package:ecommerce_app/utilities/appstyle.dart';
import 'package:ecommerce_app/widgets/export.dart';
import 'package:ecommerce_app/widgets/export_packages.dart';
import 'package:ecommerce_app/widgets/tiles_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icons_flutter/icons_flutter.dart';

import '../models/auth_response/profile_model.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    var authNotifier = context.watch<LoginNotifier>();
    return authNotifier.loggedIn
        ? Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xFFE2E2E2),
              elevation: 0,
              leading: const Icon(Icons.qr_code_scanner,
                  size: 18, color: Colors.black),
              actions: [
                GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: EdgeInsets.only(right: 16.w),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //use svg here
                        SvgPicture.asset("assets/images/usa.svg",
                            width: 15.w, height: 25.h),
                        SizedBox(width: 5.w),
                        Container(height: 15.h, width: 1.w, color: Colors.grey),
                        SizedBox(width: 5.w),
                        ReusableText(
                            text: "USA",
                            style: appStyle(
                                size: 16,
                                color: Colors.black,
                                fw: FontWeight.normal)),

                        SizedBox(width: 10.w),

                        const Padding(
                          padding: EdgeInsets.only(bottom: 4),
                          child: Icon(SimpleLineIcons.settings,
                              color: Colors.black, size: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 65.h,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE2E2E2),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(12.w, 10.h, 16.w, 16.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    height: 35.h,
                                    width: 35.w,
                                    child: const CircleAvatar(
                                      backgroundImage: AssetImage(
                                        "assets/images/user.jpeg",
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  FutureBuilder<ProfileRes>(
                                    future: authNotifier.getProfile(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                          child: CircularProgressIndicator
                                              .adaptive(),
                                        );
                                      } else if (snapshot.hasError) {
                                        return Center(
                                          child: ReusableText(
                                            text: "Error getting ",
                                            style: appStyle(
                                                size: 18,
                                                color: Colors.black,
                                                fw: FontWeight.w600),
                                          ),
                                        );
                                      } else {
                                        final profile = snapshot.data;
                                        return SizedBox(
                                          height: 36.h,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ReusableText(
                                                text: profile?.username ?? "",
                                                style: appStyle(
                                                    size: 10,
                                                    color: Colors.black,
                                                    fw: FontWeight.normal),
                                              ),
                                              ReusableText(
                                                text: profile?.email ?? "Not Available",
                                                style: appStyle(
                                                    size: 10,
                                                    color: Colors.black,
                                                    fw: FontWeight.normal),
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: const Icon(
                                    Feather.edit,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(children: [
                    SizedBox(height: 5.h),
                    Container(
                        height: 160.h,
                        color: Colors.grey.shade200,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TilesWidget(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return const ProcessOrders();
                                    }));
                                  },
                                  title: "My Orders",
                                  leading: MaterialCommunityIcons.truck_fast),
                              TilesWidget(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return const FavoritePage();
                                    }));
                                  },
                                  title: "My Favorites",
                                  leading:
                                      MaterialCommunityIcons.heart_outline),
                              TilesWidget(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return const CartPage();
                                    }));
                                  },
                                  title: "Cart",
                                  leading: FontAwesome.shopping_bag)
                            ])),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                        height: 105.h,
                        color: Colors.grey.shade200,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TilesWidget(
                                  onTap: () {},
                                  title: "Coupons",
                                  leading: MaterialCommunityIcons.tag_outline),
                              TilesWidget(
                                  onTap: () {},
                                  title: "My Store",
                                  leading: MaterialCommunityIcons.shopping)
                            ])),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                        height: 160.h,
                        color: Colors.grey.shade200,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TilesWidget(
                                  onTap: () {},
                                  title: "Shipping addresses",
                                  leading: SimpleLineIcons.location_pin),
                              TilesWidget(
                                  onTap: () {},
                                  title: "Settings",
                                  leading: AntDesign.setting),
                              TilesWidget(
                                  onTap: () {
                                    context.read<LoginNotifier>().logOut();
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return const LoginPage();
                                    }));
                                  },
                                  title: "Logout",
                                  leading: AntDesign.logout)
                            ])),
                  ])
                ],
              ),
            ),
          )
        : const NonAuthenticatedPage();
  }
}
