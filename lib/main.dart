import 'package:ecommerce_app/controllers/login_provider.dart';
import 'package:ecommerce_app/controllers/payment_provider.dart';
import 'package:ecommerce_app/widgets/export.dart';
import 'package:flutter/material.dart';
import 'widgets/export_packages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  //create the box for the hive
  await Hive.openBox("cart_box");
  await Hive.openBox("fav_box");
  //create the box for the hive
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) {
      return MainScreenNotifier();
    }),
    ChangeNotifierProvider(create: (context) {
      return ProductNotifier();
    }),
    ChangeNotifierProvider(create: (context) {
      return CartNotifier();
    }),
    ChangeNotifierProvider(create: (context) {
      return FavoritesNotifier();
    }),
    ChangeNotifierProvider(create: (context) {
      return LoginNotifier();
    }),
    ChangeNotifierProvider(create: (context) {
      return PaymentNotifier();
    })
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(325, 825),
      //helps with text adaptibility
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Ecommerce App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: false,
          ),
          home: MainPage(),
        );
      },
    );
  }
}
