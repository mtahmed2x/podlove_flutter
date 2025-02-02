import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:podlove_flutter/providers/user/user_provider.dart';
import 'package:podlove_flutter/routes/route_path.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';
import 'package:podlove_flutter/ui/widgets/custom_drop_down.dart';
import 'package:podlove_flutter/ui/widgets/custom_round_button.dart';
import 'package:podlove_flutter/ui/widgets/custom_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:podlove_flutter/utils/logger.dart';

class EditProfile extends ConsumerStatefulWidget {
  const EditProfile({super.key});

  String getLastTwoParts(String input) {
    List<String> parts = input.split(',').map((e) => e.trim()).toList();
    return parts.length >= 2
        ? '${parts[parts.length - 2]}, ${parts.last}'
        : input;
  }

  @override
  ConsumerState<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends ConsumerState<EditProfile> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _bioController = TextEditingController();
  final _ageController = TextEditingController();
  final _genderPreferenceController = TextEditingController();
  final _locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final user = ref.read(userProvider)?.user;
    if (user != null) {
      _nameController.text = user.name;
      _phoneController.text = user.phoneNumber;
      _bioController.text = user.bio;
      _ageController.text = user.age.toString();
      // _genderPreferenceController.text = user.preferences.gender;
      _locationController.text = widget.getLastTwoParts(user.location.place);
    }
  }

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

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userProvider);
    final userNotifier = ref.read(userProvider.notifier);

    return Scaffold(
      appBar: CustomAppBar(title: "Edit Profile"),
      backgroundColor: const Color.fromARGB(255, 248, 248, 248),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 30),
                      Stack(
                        children: [
                          Container(
                            width: 100.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: _selectedImage != null
                                    ? FileImage(_selectedImage!)
                                    : NetworkImage(userState!.user.avatar)
                                        as ImageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 5,
                            right: 5,
                            child: GestureDetector(
                              onTap: _pickImage,
                              child: Container(
                                width: 18.0,
                                height: 18.0,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 255, 161, 117),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Image.asset(
                                  'assets/images/camera.png',
                                  width: 18.00, // Adjust based on iconSize
                                  height: 18.00,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40.h),
                CustomTextField(
                  fieldType: TextFieldType.text,
                  label: "Full Name",
                  controller: _nameController,
                ),
                SizedBox(height: 10.h),
                CustomTextField(
                  fieldType: TextFieldType.text,
                  label: "Phone Number",
                  controller: _phoneController,
                ),
                SizedBox(height: 10.h),
                CustomTextField(
                  fieldType: TextFieldType.text,
                  label: "Bio",
                  controller: _bioController,
                  maxLines: 5,
                ),
                SizedBox(height: 10.h),
                CustomTextField(
                  fieldType: TextFieldType.text,
                  label: "Age (years)",
                  controller: _ageController,
                ),
                CustomDropdown<String>(
                  label: "Gender",
                  options: ["Male", "Female"],
                  initialValue: userState!.user.gender,
                  onChanged: (selectedValue) {
                    userNotifier.updateGender(selectedValue);
                  },
                ),
                // SizedBox(height: 25.h),
                // CustomTextField(
                //   fieldType: TextFieldType.text,
                //   label: "Gender Preference",
                //   controller: _genderPreferenceController,
                // ),
                SizedBox(height: 5.h),
                CustomTextField(
                  fieldType: TextFieldType.text,
                  label: "Location",
                  controller: _locationController,
                ),
                SizedBox(height: 30),
                CustomRoundButton(
                  text: "Save",
                  onPressed: () async {
                    if (_selectedImage != null) {
                      userNotifier.uploadAvatar(_selectedImage!);
                    }
                    userNotifier.updateName(_nameController.text);
                    userNotifier.updatePhoneNumber(_phoneController.text);
                    userNotifier.updateBio(_bioController.text);
                    userNotifier.updateAge(int.tryParse(_ageController.text) ??
                        userState.user.age);
                    userNotifier.updateGender(_genderPreferenceController.text);
                    // userNotifier.updatePreferredGender(
                    //     _genderPreferenceController.text);
                    userNotifier.updateLocation(
                        userState.user.location.latitude,
                        userState.user.location.longitude,
                        _locationController.text);

                    try {
                      await userNotifier.update();
                      context.push(RouterPath.profile);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Failed to update profile: $e")),
                      );
                    }
                  },
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    _ageController.dispose();
    _genderPreferenceController.dispose();
    _locationController.dispose();
    super.dispose();
  }
}
