import 'package:ecommerce_app/controllers/login_provider.dart';
import 'package:ecommerce_app/pages/auth/registration_page.dart';
import 'package:ecommerce_app/widgets/export.dart';
import 'package:ecommerce_app/widgets/export_packages.dart';
import 'package:flutter/material.dart';

import '../../models/auth/login_model.dart';
import '../../widgets/custom_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool formValidation() {
    return _formKey.currentState?.validate() ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final loginNotifier = context.watch<LoginNotifier>();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 50.h,
        backgroundColor: Colors.black,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          decoration: const BoxDecoration(
            image: DecorationImage(
              opacity: 0.5,
              image: AssetImage("assets/images/bg.jpg"),
            ),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              ReusableText(
                text: "Welcome!",
                style: appStyle(
                    size: 30, color: Colors.white, fw: FontWeight.w600),
              ),
              ReusableText(
                text: "Fill in your details to login into your account",
                style: appStyle(
                    size: 12, color: Colors.white, fw: FontWeight.normal),
              ),
              SizedBox(height: 50.h),
              CustomTextField(
                keyboard: TextInputType.emailAddress,
                hintText: 'Email',
                controller: emailController,
                validator: (email) {
                  if (email!.isEmpty || !email.contains("@")) {
                    return "Please provide a valid email";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 15.h),
              CustomTextField(
                obscureText: loginNotifier.isObscure,
                suffixIcon: GestureDetector(
                  onTap: () {
                    loginNotifier.isObscure = !loginNotifier.isObscure;
                  },
                  child: Icon(!loginNotifier.isObscure
                      ? Icons.visibility
                      : Icons.visibility_off),
                ),
                hintText: 'Password',
                controller: passwordController,
                validator: (password) {
                  if (password!.isEmpty || password.length < 7) {
                    return "Password is too weak";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 15.h),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return const RegistrationPage();
                        },
                      ),
                    );
                  },
                  child: ReusableText(
                    text: "Register",
                    style: appStyle(
                        size: 12, color: Colors.white, fw: FontWeight.normal),
                  ),
                ),
              ),
              SizedBox(height: 40.h),
              GestureDetector(
                onTap: () {
                  if (formValidation()) {
                    // Proceed with login logic here
                    LoginModel model = LoginModel(
                        email: emailController.text,
                        password: passwordController.text);
                    context
                        .read<LoginNotifier>()
                        .userLogin(model)
                        .then((response) {
                      if (response == true) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return MainPage();
                            },
                          ),
                        );
                      } else {
                        debugPrint("Failed to login");
                      }
                    });
                  } else {
                    debugPrint("Form not validated");
                  }
                },
                child: Container(
                  height: 55.h,
                  width: 200.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: ReusableText(
                      text: "LOGIN",
                      style: appStyle(
                          size: 18, color: Colors.black, fw: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
