import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podlove_flutter/providers/user/user_provider.dart';
import 'package:podlove_flutter/routes/route_path.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';
import 'package:podlove_flutter/ui/widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileContent extends ConsumerWidget {
  const ProfileContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userProvider);

    return Scaffold(
      appBar: CustomAppBar(
        title: "Profile",
        imageUrl: "assets/images/edit-icon.png",
        onImageTap: () {
          GoRouter.of(context).go(RouterPath.editProfile);
        },
      ),
      backgroundColor: const Color.fromARGB(255, 248, 248, 248),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w)
              .copyWith(top: 20.h, bottom: 44.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30),
                      CircleAvatar(
                        radius: 72,
                        backgroundImage: NetworkImage(userState!.user.avatar),
                      ),
                      const SizedBox(height: 20),
                      CustomText(
                        text: userState.user.name,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(height: 5),
                      CustomText(
                        text: userState.auth.email,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Bio:",
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                    const SizedBox(height: 10),
                    CustomText(
                      text: userState.user.bio,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: "Phone Number:",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        const SizedBox(width: 10),
                        CustomText(
                          text: userState.user.phoneNumber,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: "Age:",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        const SizedBox(width: 10),
                        CustomText(
                          text: userState.user.age.toString(),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: "Gender:",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        const SizedBox(width: 10),
                        CustomText(
                          text: userState.user.gender,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: "Gender Preference:",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        const SizedBox(width: 10),
                        CustomText(
                          text: userState.user.preferences.gender,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: "Location:",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        const SizedBox(width: 10),
                        CustomText(
                          text: userState.user.location.latitude.toString(),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
