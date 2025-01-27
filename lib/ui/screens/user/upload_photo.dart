import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:podlove_flutter/constants/app_colors.dart';
import 'package:podlove_flutter/constants/app_strings.dart';
import 'package:podlove_flutter/providers/user/user_provider.dart';
import 'package:podlove_flutter/routes/route_path.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';
import 'package:podlove_flutter/ui/widgets/custom_round_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:podlove_flutter/utils/logger.dart';
import 'package:http/http.dart' as http;

class UploadPhoto extends ConsumerStatefulWidget {
  const UploadPhoto({super.key});

  @override
  ConsumerState<UploadPhoto> createState() => _UploadPhotoState();
}

class _UploadPhotoState extends ConsumerState<UploadPhoto> {
  File? _selectedImage;

  final String cloudinaryUrl =
      'https://api.cloudinary.com/v1_1/dvjbfwhxe/image/upload';
  final String uploadPreset = 'podlove_upload';

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
      logger.i(pickedFile.path);
    }
  }

  Future<void> _uploadImage(WidgetRef ref) async {
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select an image first!")),
      );
      return;
    }

    try {
      final request = http.MultipartRequest('POST', Uri.parse(cloudinaryUrl))
        ..fields['upload_preset'] = uploadPreset
        ..files.add(
            await http.MultipartFile.fromPath('file', _selectedImage!.path));

      final response = await request.send();
      if (response.statusCode == 200) {
        final res = await http.Response.fromStream(response);
        logger.i('Upload successful: ${res.body}');
        final responseData = json.decode(res.body);

        final imageUrl = responseData['secure_url'];
        logger.i('Upload successful: $imageUrl');
      } else {
        final res = await http.Response.fromStream(response);
        logger.e('Upload failed: ${response.statusCode} - ${res.body}');
      }
    } catch (e) {
      logger.e('Error uploading image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred while uploading the image")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.uploadPhotoTitle),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 15.h),
                Center(
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/podLove.png",
                        width: 250.w,
                        height: 50.h,
                      ),
                      SizedBox(height: 25.h),
                      Text(
                        AppStrings.uploadPhotoPrompt,
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryText,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        AppStrings.uploadPhotoDescription,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.primaryText,
                        ),
                      ),
                      SizedBox(height: 40.h),
                      GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          width: 150.w,
                          height: 150.h,
                          decoration: BoxDecoration(
                            color: const Color(0xFFEAEAEA),
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: const Color(0xFFDADADA),
                            ),
                          ),
                          child: _selectedImage != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(12.r),
                                  child: Image.file(
                                    _selectedImage!,
                                    fit: BoxFit.cover,
                                    width: 150.w,
                                    height: 150.h,
                                  ),
                                )
                              : const Center(
                                  child: Icon(
                                    Icons.camera_alt,
                                    size: 40,
                                    color: Color(0xFF9E9E9E),
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        _selectedImage == null
                            ? AppStrings.tapToUpload
                            : AppStrings.tapToChangePhoto,
                        style: TextStyle(
                          color: AppColors.primaryText,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Consumer(
                        builder: (context, ref, _) {
                          final userState = ref.watch(userProvider);
                          final userNotifier = ref.read(userProvider.notifier);
                          return CustomRoundButton(
                              text: userState?.isLoading == true
                                  ? AppStrings.saving
                                  : AppStrings.continueButton,
                              onPressed: userState?.isLoading == true
                                  ? null
                                  : () async {
                                      if (_selectedImage == null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content:
                                                Text("Please select an image."),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                        return;
                                      } else {
                                        await userNotifier
                                            .uploadAvatar(_selectedImage!);
                                        if (userState!.error != null) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                "Failed to upload image.",
                                              ),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                          return;
                                        }
                                        GoRouter.of(context).go(
                                            '${RouterPath.compatibalityQuestion}/1');
                                      }
                                    });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 100.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
