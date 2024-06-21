import 'package:ecommerce_app/pages/auth/login_page.dart';
import 'package:ecommerce_app/widgets/export.dart';
import 'package:ecommerce_app/widgets/export_packages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icons_flutter/icons_flutter.dart';

class NonAuthenticatedPage extends StatelessWidget {
  const NonAuthenticatedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE2E2E2),
        elevation: 0,
        leading:
            const Icon(Icons.qr_code_scanner, size: 18, color: Colors.black),
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
              height: 750.h,
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
                            ReusableText(
                              text: "Hello, Please Login into Your Account",
                              style: appStyle(
                                  size: 10,
                                  color: Colors.grey.shade600,
                                  fw: FontWeight.normal),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                              return LoginPage();
                            }));
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 2),
                            width: 50.w,
                            height: 30.h,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Center(
                              child: ReusableText(
                                text: "Login",
                                style: appStyle(
                                    size: 10,
                                    color: Colors.grey,
                                    fw: FontWeight.normal),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
