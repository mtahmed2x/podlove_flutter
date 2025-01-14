import 'package:get/get.dart';
import 'package:podlove_flutter/bindings/sign_up_binding.dart';
import 'package:podlove_flutter/ui/screens/splash_screen/initial_screen.dart';
import 'package:podlove_flutter/routes/route_path.dart';
import 'package:podlove_flutter/ui/screens/onboarding/approach.dart';
import 'package:podlove_flutter/ui/screens/onboarding/expectation.dart';
import 'package:podlove_flutter/ui/screens/splash_screen/splash_screen.dart';
import 'package:podlove_flutter/ui/screens/onboarding/attention.dart';
import '../ui/screens/auth/forgot_password.dart';
import '../ui/screens/auth/reset_password.dart';
import '../ui/screens/auth/signin.dart';
import '../ui/screens/auth/singup.dart';
import '../ui/screens/auth/verify_code.dart';
import '../ui/screens/auth/verify_email.dart';
import '../ui/screens/auth/verify_phone.dart';
import '../ui/screens/terms/terms.dart';



class AppRouter {
  static final appPages = [
    GetPage(name: RouterPath.initialScreen, page: () => InitialScreen()),
    GetPage(name: RouterPath.splashScreen, page: () => SplashScreen()),
    
    GetPage(name: RouterPath.approachToLove, page: () => Approach()),
    GetPage(name: RouterPath.expectationFromApp, page: () => Expectation()),
    
    GetPage(name: RouterPath.termsOfUse, page: () => TermsOfUse()),
    GetPage(name: RouterPath.attention, page: () => Attention()),

    GetPage(name: RouterPath.signUp, page: () => SignUp(), binding: SignUpBinding()),
    GetPage(name: RouterPath.emailVerification, page: () => VerifyEmail()),
    GetPage(name: RouterPath.phoneVerification, page: () => VerifyPhone()),
    GetPage(name: RouterPath.signIn, page: () => SignIn()),
    GetPage(name: RouterPath.forgotPassword, page: () => ForgotPassword()),
    GetPage(name: RouterPath.verifyCode, page: () => VerifyCode()),
    GetPage(name: RouterPath.resetPass, page: () => ResetPassword())
  ];
}