import 'package:get/get.dart';
import 'package:podlove_flutter/presentation/screens/splash_screen/initial_screen.dart';
import 'package:podlove_flutter/routes/route_path.dart';
import 'package:podlove_flutter/presentation/screens/onboarding/approach.dart';
import 'package:podlove_flutter/presentation/screens/onboarding/expectation.dart';
import 'package:podlove_flutter/presentation/screens/splash_screen/splash_screen.dart';
import 'package:podlove_flutter/presentation/screens/onboarding/attention.dart';
import '../presentation/screens/auth/forgot_password.dart';
import '../presentation/screens/auth/reset_password.dart';
import '../presentation/screens/auth/signin.dart';
import '../presentation/screens/auth/singup.dart';
import '../presentation/screens/auth/verify_code.dart';
import '../presentation/screens/auth/verify_email.dart';
import '../presentation/screens/auth/verify_phone.dart';
import '../presentation/screens/terms/terms.dart';



class AppRouter {
  static final AppPages = [
    GetPage(name: RouterPath.initialScreen, page: () => InitialScreen()),
    GetPage(name: RouterPath.splashScreen, page: () => SplashScreen()),
    
    GetPage(name: RouterPath.approachToLove, page: () => Approach()),
    GetPage(name: RouterPath.expectationFromApp, page: () => Expectation()),
    
    GetPage(name: RouterPath.termsOfUse, page: () => TermsOfUse()),
    GetPage(name: RouterPath.attention, page: () => Attention()),

    GetPage(name: RouterPath.signUp, page: () => SignUp()),
    GetPage(name: RouterPath.emailVerification, page: () => VerifyEmail()),
    GetPage(name: RouterPath.phoneVerification, page: () => VerifyPhone()),
    GetPage(name: RouterPath.signIn, page: () => SignIn()),
    GetPage(name: RouterPath.forgotPassword, page: () => ForgotPassword()),
    GetPage(name: RouterPath.verifyCode, page: () => VerifyCode()),
    GetPage(name: RouterPath.resetPass, page: () => ResetPassword())
  ];
}