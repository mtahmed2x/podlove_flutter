import 'package:flutter/material.dart';
import 'package:podlove_flutter/constants/app_colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Purchase extends StatefulWidget {
  final String url;

  const Purchase({super.key, required this.url});

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
              _showSuccessDialog();
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Center(child: Text("Payment Successful")), // Center title
        content: const Text(
          "Your payment was completed successfully!",
          textAlign: TextAlign.center, // Center content text
        ),
        actions: [
          Center( // Center the button
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
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
