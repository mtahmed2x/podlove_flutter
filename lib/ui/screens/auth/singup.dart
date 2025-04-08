import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:podlove_flutter/constants/app_colors.dart';
import 'package:podlove_flutter/constants/app_enums.dart';
import 'package:podlove_flutter/constants/app_widgets.dart';
import 'package:podlove_flutter/providers/sign_up_provider.dart';
import 'package:podlove_flutter/constants/app_strings.dart';
import 'package:podlove_flutter/routes/route_path.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';
import 'package:podlove_flutter/ui/widgets/custom_round_button.dart';
import 'package:podlove_flutter/ui/widgets/custom_text.dart';
import 'package:podlove_flutter/ui/widgets/custom_text_field.dart';
import 'package:podlove_flutter/ui/widgets/show_message_dialog.dart';
import 'package:podlove_flutter/utils/logger.dart';

class SignUp extends ConsumerStatefulWidget {
  const SignUp({super.key});

  @override
  ConsumerState<SignUp> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUp> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _nameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmPasswordFocus = FocusNode();

  String? _nameError;
  String? _emailError;
  String? _phoneError;
  String? _passwordError;
  String? _confirmPasswordError;

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '* Name is required';
    } else if (value.trim().length < 3) {
      return '* Name must be at least 3 characters';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regExp = RegExp(pattern);

    if (value == null || value.isEmpty) {
      return '* Email is required';
    } else if (!regExp.hasMatch(value)) {
      return '* Invalid Email! Enter a valid one';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '* Phone number is required';
    } else if (!RegExp(r'^\+1\d{10}$').hasMatch(value)) {
      return "* Invalid US mobile number";
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '* Password is required';
    }
    final password = value.trim();
    List<String> errors = [];

    if (password.length < 8) {
      errors.add('• Must have at least 8 characters');
    }
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      errors.add('• Must have one uppercase letter');
    }
    if (!RegExp(r'[a-z]').hasMatch(password)) {
      errors.add('• Must have one lowercase letter');
    }
    if (!RegExp(r'\d').hasMatch(password)) {
      errors.add('• Must have one digit');
    }
    if (!RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(password)) {
      errors.add('• Must have one special character');
    }

    if (errors.isNotEmpty) {
      return errors.join('\n');
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.confirmPasswordError;
    }
    if (value != _passwordController.text) {
      return AppStrings.passwordMismatchError;
    }
    return null;
  }

  @override
  void initState() {
    super.initState();

    _nameFocus.addListener(() {
      if (!_nameFocus.hasFocus) {
        final error = _validateName(_nameController.text);
        if (_nameError != error) {
          setState(() => _nameError = error);
        }
      }
    });

    _emailFocus.addListener(() {
      if (!_emailFocus.hasFocus) {
        final error = _validateEmail(_emailController.text);
        if(_emailError != error) {
          setState(() => _emailError = error);
        }
      }
    });

    _phoneFocus.addListener(() {
      if (!_phoneFocus.hasFocus) {
        setState(() {
          _phoneError = _validatePhone(_phoneController.text);
        });
      }
    });

    _passwordFocus.addListener(() {
      if (!_passwordFocus.hasFocus) {
        final error = _validatePassword(_passwordController.text);
        if(_passwordError != error) {
          setState(() => _passwordError = error);
        }
      }
    });

    _confirmPasswordFocus.addListener(() {
      if (!_confirmPasswordFocus.hasFocus) {
        final error = _validateConfirmPassword(_confirmPasswordController.text);
        if(_confirmPasswordError != error) {
          setState(() => _confirmPasswordError = error);
        }
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ref.invalidate(signUpProvider);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    ref.read(signUpProvider.notifier).resetState();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signUpState = ref.watch(signUpProvider);
    final signUpNotifier = ref.read(signUpProvider.notifier);

    ref.listen<SignUpState>(
      signUpProvider,
      (previous, current) {
        if (current.isSuccess == true && current.isLoading == false) {
          context.push(
            RouterPath.verifyCode,
            extra: {
              "method": Method.emailActivation,
              "email": current.email,
            },
          );
        } else if (current.isSuccess == false && current.isLoading == false) {
          if (current.isVerified == true) {
            showMessageDialog(
              context,
              "Alert",
              current.error.toString(),
              () => context.push(RouterPath.signIn),
              buttonText: "Sign in",
            );
          } else if (current.isVerified == false) {
            showMessageDialog(
              context,
              "Alert",
              current.error.toString(),
              () => context.push(
                RouterPath.verifyCode,
                extra: {
                  "method": Method.emailActivation,
                  "email": current.email,
                },
              ),
              buttonText: "Verify",
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                elevation: 0,
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
                content: SizedBox(
                  width: 400.w,
                  child: AwesomeSnackbarContent(
                    title: "Error",
                    message: current.error!,
                    contentType: ContentType.failure,
                  ),
                ),
              ),
            );
          }
        }
      },
    );
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.signUp, isLeading: true),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w)
              .copyWith(top: 20.h, bottom: 44.h),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: SizedBox(
                      width: 203.w,
                      child: Column(
                        children: [
                          AppWidgets.podLoveLogo,
                          SizedBox(height: 20.h),
                          CustomText(
                            text: AppStrings.welcome,
                            color: const Color.fromARGB(255, 51, 51, 51),
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(height: 30.h),
                        ],
                      ),
                    ),
                  ),
                  // Form Fields
                  CustomTextField(
                    fieldType: TextFieldType.text,
                    label: AppStrings.fullName,
                    hint: AppStrings.fullNameHint,
                    controller: _nameController,
                    focusNode: _nameFocus,
                    errorText: _nameError,
                    onChanged: (_) {
                      if (_nameError != null) setState(() => _nameError = null);
                    },
                  ),
                  CustomTextField(
                    fieldType: TextFieldType.email,
                    label: AppStrings.email,
                    hint: AppStrings.emailHint,
                    controller: _emailController,
                    focusNode: _emailFocus,
                    errorText: _emailError,
                    onChanged: (_) {
                      if (_emailError != null) setState(() => _emailError = null);
                    },
                  ),
                  CustomText(
                    text: "Phone Number",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromARGB(255, 51, 51, 51),
                  ),
                  SizedBox(height: 10.h),
                  IntlPhoneField(
                    decoration: InputDecoration(
                      hintText: 'Enter your phone number',
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 121, 121, 121),
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.accent),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.accent, width: 2.w),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.accent),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      errorText: _phoneError,
                      errorStyle: TextStyle(
                        color: AppColors.red,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.red),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.red, width: 2.w),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    focusNode: _phoneFocus,
                    initialCountryCode: 'US',
                    countries: countries
                        .where((element) => ['US']
                        .contains(element.code))
                        .toList(),// Limit to US
                    onChanged: (phone) {
                      _phoneController.text = phone.completeNumber;
                      if (_phoneError != null) {
                        setState(() => _phoneError = null);
                      }
                    },
                    validator: (phone) {
                      if (phone == null || phone.number.isEmpty) {
                        return AppStrings.enterPhoneNumberError;
                      } else if (phone.number.length != 10) {
                        return "* Invalid US mobile number";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 5.h),
                  CustomTextField(
                    fieldType: TextFieldType.password,
                    label: AppStrings.password,
                    hint: AppStrings.passwordHint,
                    controller: _passwordController,
                    focusNode: _passwordFocus,
                    errorText: _passwordError,
                    onChanged: (_) {
                      if (_passwordError != null) setState(() => _passwordError = null);
                    },
                  ),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    fieldType: TextFieldType.password,
                    label: AppStrings.confirmPassword,
                    hint: AppStrings.confirmPasswordHint,
                    controller: _confirmPasswordController,
                    focusNode: _confirmPasswordFocus,
                    errorText: _confirmPasswordError,
                    onChanged: (_) {
                      if(_confirmPasswordError != null) setState(() => _confirmPasswordError = null);
                    },

                  ),
                  SizedBox(height: 30.h),
                  CustomRoundButton(
                    text: signUpState.isLoading
                        ? AppStrings.signingUp
                        : AppStrings.signUp,
                    onPressed: signUpState.isLoading
                        ? null
                        : () async {
                      final nameErr = _validateName(_nameController.text);
                      final emailErr = _validateEmail(_emailController.text);
                      final phoneErr = _validatePhone(_phoneController.text);
                      final passwordErr = _validatePassword(_passwordController.text);
                      final confirmPasswordErr = _validateConfirmPassword(_confirmPasswordController.text);

                      setState(() {
                        _nameError = nameErr;
                        _emailError = emailErr;
                        _phoneError = phoneErr;
                        _passwordError = passwordErr;
                        _confirmPasswordError = confirmPasswordErr;
                      });

                      if (nameErr == null &&
                          emailErr == null &&
                          phoneErr == null &&
                          passwordErr == null &&
                          confirmPasswordErr == null) {
                        logger.i(_phoneController.text);
                        await signUpNotifier.signUp(
                          _nameController.text,
                          _emailController.text,
                          _phoneController.text,
                          _passwordController.text,
                        );
                      }
                    },
                  ),
                  SizedBox(height: 20.h),
                  // Sign In Link
                  Center(
                    child: GestureDetector(
                      onTap: () => context.push(RouterPath.signIn),
                      child: CustomText(
                        text: AppStrings.signInPrompt,
                        color: AppColors.accent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
