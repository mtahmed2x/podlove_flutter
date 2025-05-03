import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podlove_flutter/constants/app_widgets.dart';
import 'package:podlove_flutter/providers/bio_check_providers.dart';
import 'package:podlove_flutter/providers/user_provider.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';
import 'package:podlove_flutter/ui/widgets/custom_round_button.dart';
import 'package:podlove_flutter/ui/widgets/custom_text.dart';
import 'package:podlove_flutter/ui/widgets/custom_text_field.dart';
import 'package:podlove_flutter/utils/logger.dart';

class AddBio extends ConsumerStatefulWidget {
  const AddBio({super.key});

  @override
  ConsumerState<AddBio> createState() => _AddBioState();
}

class _AddBioState extends ConsumerState<AddBio> {
  final _addBioController = TextEditingController();
  String? _validationMessage;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ref.invalidate(bioCheckProvider);
  }

  @override
  void dispose() {
    _addBioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bioCheckState = ref.watch(bioCheckProvider);
    final bioCheckNotifier = ref.read(bioCheckProvider.notifier);

    ref.listen(bioCheckProvider, (prev, current) {
      if (current.isLoading == false && current.isSuccess == false && current.error != null) {
        setState(() {
          _validationMessage = current.error!;
        });
      } else if (current.isLoading == false && current.isSuccess == true) {
        setState(() {
          _validationMessage = null;
        });
        logger.i("Valid");
        // Optionally navigate or show success UI
      }
    });

    return Scaffold(
      appBar: const CustomAppBar(title: "Add Bio", isLeading: true),
      backgroundColor: const Color.fromARGB(255, 248, 248, 248),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w).copyWith(top: 20.h, bottom: 44.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15.h),
                Center(
                  child: Column(
                    children: [
                      AppWidgets.podLoveLogo,
                      SizedBox(height: 25.h),
                      CustomText(
                        text: "Add Your Bio",
                        color: const Color.fromARGB(255, 51, 51, 51),
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: 12.h),
                      CustomText(
                        text: "Please do not add your name",
                        color: const Color.fromARGB(255, 51, 51, 51),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(height: 40.h),
                    ],
                  ),
                ),
                CustomTextField(
                  fieldType: TextFieldType.text,
                  label: TextSpan(
                    text: "Write your bio ",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromARGB(255, 51, 51, 51),
                    ),
                    children: [
                      TextSpan(
                        text: "( Max 200 words )",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color.fromARGB(255, 51, 51, 51),
                        ),
                      ),
                    ],
                  ),
                  hint: "Type here..",
                  maxLines: 5,
                  controller: _addBioController,
                ),
                if (_validationMessage != null) ...[
                  SizedBox(height: 10.h),
                  Text(
                    _validationMessage!,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
                SizedBox(height: 30.h),
                Consumer(
                  builder: (context, ref, _) {
                    return CustomRoundButton(
                      text: bioCheckState.isLoading ? "Saving..." : "Continue",
                      onPressed: bioCheckState.isLoading
                          ? null
                          : () async {
                        final text = _addBioController.text.trim();
                        final wordCount = text.split(RegExp(r'\s+')).length;

                        if (text.isEmpty) {
                          setState(() {
                            _validationMessage = "Please write down your bio!";
                          });
                        } else if (wordCount < 5) {
                          setState(() {
                            _validationMessage = "Your bio must be at least 5 words.";
                          });
                        } else if (wordCount > 200) {
                          setState(() {
                            _validationMessage = "Your bio must not exceed 200 words.";
                          });
                        } else {
                          setState(() {
                            _validationMessage = null;
                          });
                          await bioCheckNotifier.bioCheck(text);
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
