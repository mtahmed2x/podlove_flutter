import 'package:flutter/material.dart';
import 'package:podlove_flutter/constants/app_colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Purchase extends StatefulWidget {
  final String url;
  final VoidCallback onPressed;


  const Purchase({super.key, required this.url, required this.onPressed});

  @override
  State<Purchase> createState() => _PurchaseState();
}

class _PurchaseState extends State<Purchase> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            if (url.contains("https://example.com/success")) {
              Navigator.pop(context);
              _showSuccessDialog(onPressed: widget.onPressed);
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  void _showSuccessDialog({required final VoidCallback onPressed}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Center(child: Text("Payment Successful")),
        content: const Text(
          "Your payment was completed successfully!",
          textAlign: TextAlign.center,
        ),
        actions: [
          Center(
            child: TextButton(
              onPressed: onPressed,
              style: TextButton.styleFrom(
                foregroundColor: AppColors.background,
                backgroundColor: AppColors.accent,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: const Text("OK"),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(controller: _controller),
    );
  }
}
