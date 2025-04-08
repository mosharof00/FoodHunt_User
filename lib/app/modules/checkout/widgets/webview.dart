import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../Utils/appbar_title.dart';
import '../../../../Utils/custom_icon_button.dart';
import '../../../../Utils/global_snackbar.dart';
import '../../../../gen/colors.gen.dart';

import '../../../routes/app_pages.dart';
import '../controllers/checkout_controller.dart';

class PaymentWebViewScreen extends StatefulWidget {
  final String url;

  const PaymentWebViewScreen({super.key, required this.url});

  @override
  _PaymentWebViewScreenState createState() => _PaymentWebViewScreenState();
}

class _PaymentWebViewScreenState extends State<PaymentWebViewScreen> {
  late final WebViewController _controller;
  final checkoutController = Get.put(CheckoutController());
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    // Initialize the WebViewController
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            checkoutController.isLoading.value = true;
            checkoutController.showLoadingDialog();
          },
          onProgress: (int progress) {
            // Handle progress updates if necessary
          },
          onPageFinished: (String url) {
            checkoutController.isLoading.value = false;
            checkoutController.closeLoadingDialogIfOpen();
            // Handle payment success/failure based on URL
            if (url.contains("payment-success") ||
                url.contains('/api/stripe/success') ||
                url.contains('status=success') ||
                url.contains('/payment-success')) {
              checkoutController.updateOrderPaymentStatusToPaid();
              Get.offAllNamed(Routes.MY_ORDERS);
              globalSnackBar(
                title: 'Order confirmed successfully!',
                message:
                    'Your order is successfully placed.Thank you for your order. Please check out orders history to track and all info.',
                durationInSeconds: 3,
              );
            } else if (url.contains("api/fail")) {
              Get.back();
              Get.offAllNamed(Routes.MY_ORDERS);
              globalSnackBar(
                  title: 'Fail payment confirmation!',
                  message:
                      'Your order payment confirmation fail. Payment status will be Due of your this order. Please Check your order.',
                  durationInSeconds: 5,
                  textColor: Colors.red);
            }
          },
          onWebResourceError: (WebResourceError error) {
            checkoutController.isLoading.value = false;
            checkoutController.closeLoadingDialogIfOpen();
            globalSnackBar(
                title: 'Fail payment confirmation!',
                message:
                    'Your order payment confirmation fail. Payment status will be Due of your this order. Please Check your order.',
                durationInSeconds: 5,
                textColor: Colors.red);
          },
          onNavigationRequest: (NavigationRequest request) {
            // Prevent navigation to disallowed URLs
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PopScope(
        canPop: true,
        onPopInvoked: (didPop) {
          if (didPop) return;

          if (checkoutController.orderedId.value != 0) {
            checkoutController.deleteOrder(
              orderId: checkoutController.orderedId.value,
            );
            checkoutController.orderedId.value = 0;
          }
          Navigator.of(context).pop(); // Allow the screen to pop.
        },
        child: Scaffold(
          backgroundColor: ColorName.bgColor,
          appBar: AppBar(
            backgroundColor: ColorName.bgColor,
            surfaceTintColor: ColorName.bgColor,
            title: appbarTitle(text: 'Check Out'),
            centerTitle: true,
            leading: Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: CustomIconButton(
                onPressed: () {
                  if (checkoutController.orderedId.value != 0) {
                    checkoutController.deleteOrder(
                        orderId: checkoutController.orderedId.value);
                  }

                  Get.back();
                },
              ),
            ),
          ),
          body: WebViewWidget(controller: _controller),
        ),
      ),
    );
  }
}
