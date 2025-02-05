import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:podlove_flutter/constants/app_colors.dart';

class SubscriptionCard extends StatelessWidget {
  final double? width;
  final String title;
  final String subtitle;
  final String price;
  final List<String> features;
  final VoidCallback onViewDetails;
  final VoidCallback onPressed;
  final bool isCurrentPlan;

  const SubscriptionCard({
    this.width = 300,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.features,
    required this.onPressed,
    required this.onViewDetails,
    this.isCurrentPlan = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(375, 812), minTextAdapt: true);

    return SizedBox(
      width: width?.w,
      child: Card(
        elevation: 0,
        color: Color.fromARGB(255, 254, 254, 254),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 4.h),
              Container(
                height: 2.h,
                width: 70.w,
                color: AppColors.accent,
              ),
              SizedBox(height: 20.h),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.orange,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                price,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 34, 104, 192),
                ),
              ),
              const SizedBox(height: 16),
              Column(
                children: features
                    .map((feature) => Padding(
                          padding: EdgeInsets.all(8.w),
                          child: Row(
                            children: [
                              Icon(
                                Icons.check,
                                color: Colors.orange,
                                size: 20.sp,
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: Text(
                                  feature,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ))
                    .toList(),
              ),
              SizedBox(height: 16.h),
              TextButton(
                onPressed: onViewDetails,
                child: Text(
                  "View Details",
                  style: TextStyle(
                    color: Color.fromARGB(255, 42, 89, 167),
                    fontSize: 14.sp,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              SizedBox(
                width: 250.w,
                height: 55.h,
                child: OutlinedButton(
                  onPressed: onPressed,
                  style: OutlinedButton.styleFrom(
                    backgroundColor: isCurrentPlan
                        ? Color.fromARGB(255, 254, 254, 254)
                        : Color.fromARGB(255, 255, 161, 117),
                    side: BorderSide(
                      color: Color.fromARGB(255, 255, 226, 212),
                    ),
                  ),
                  child: Text(
                    isCurrentPlan ? "Current Plan" : "Purchase",
                    style: TextStyle(
                      color: isCurrentPlan
                          ? Color.fromARGB(255, 255, 161, 117)
                          : Color.fromARGB(255, 254, 254, 254),
                      fontSize: 16.sp,
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

void showSubscriptionDetails(
    BuildContext context,
    String title,
    String price,
    List<Map<String, String>> features,
    ) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Close button (top right corner)
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close, color: Colors.orange),
                ),
              ),

              // Title
              Center(
                child: Text(
                  "Details",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Subscription Name & Price
              Text(
                "$title ($price)",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              // Description Title
              Text(
                "Everything in the Listener package, plus:",
                style: TextStyle(fontSize: 14),
              ),

              const SizedBox(height: 8),

              // Features List (Bold key + Normal details)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: features.map((feature) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("• ", style: TextStyle(fontSize: 16)),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: "${feature['key']}: ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: feature['details'],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      );
    },
  );
}
