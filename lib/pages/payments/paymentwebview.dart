import 'package:ecommerce_app/controllers/payment_provider.dart';
import 'package:ecommerce_app/pages/payments/failed.dart';
import 'package:ecommerce_app/pages/payments/successful.dart';
import 'package:ecommerce_app/widgets/export_packages.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
// #docregion platform_imports
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class PaymentWebView extends StatefulWidget {
  const PaymentWebView({super.key});

  @override
  State<PaymentWebView> createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    var paymentNotifier = Provider.of<PaymentNotifier>(context, listen: false);
    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            //debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            //debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            //debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
          onUrlChange: (UrlChange change) {

            //when the wearer does [payment succeed or cancel the payment
            //IF WE DONT PUT THIS LOGIC WE WILL BE REDIRECTED TO THE WEB HTML PAGE OF CHECKOUT/CANCEL WE CREATED IN THE STRIPE BACKEND
            //INSTEAD WHEN WE DO .PUSH WE DIRECTED TO THE SUCCESSFUL/PAYMENTFAILED WIDGET WE HAVE CREATED
            //display corresponding pages 
            if (change.url!.contains("checkout-success")) {
              paymentNotifier.paymentUrl = "";
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return const Successful();
              }));
            } else if (change.url!.contains("cancel")) {
              paymentNotifier.paymentUrl = "";
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return const PaymentFailed();
              }));
            }
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      //load request for the paymentUrl (success or failed or)
      ..loadRequest(Uri.parse(paymentNotifier.paymentUrl));

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          toolbarHeight: 20,
        ),
        body: WebViewWidget(controller: _controller));
  }
}
