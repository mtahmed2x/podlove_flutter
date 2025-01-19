import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podlove_flutter/ui/screens/auth/singup.dart';
import 'package:podlove_flutter/ui/screens/splash_screen/initial_screen.dart';
import 'package:podlove_flutter/ui/screens/splash_screen/splash_screen.dart';
import 'package:podlove_flutter/ui/screens/onboarding/approach.dart';
import 'package:podlove_flutter/ui/screens/onboarding/expectation.dart';
import 'package:podlove_flutter/ui/screens/onboarding/attention.dart';
import 'package:podlove_flutter/ui/screens/auth/forgot_password.dart';
import 'package:podlove_flutter/ui/screens/auth/reset_password.dart';
import 'package:podlove_flutter/ui/screens/auth/signin.dart';
import 'package:podlove_flutter/ui/screens/auth/verify_code.dart';
import 'package:podlove_flutter/ui/screens/auth/verify_email.dart';
import 'package:podlove_flutter/ui/screens/auth/verify_phone.dart';
import 'package:podlove_flutter/ui/screens/terms/terms.dart';
import 'package:podlove_flutter/routes/route_path.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: RouterPath.signUp,
    routes: [
      GoRoute(
        path: RouterPath.initialScreen,
        builder: (context, state) => const InitialScreen(),
      ),
      GoRoute(
        path: RouterPath.splashScreen,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RouterPath.approachToLove,
        builder: (context, state) => const Approach(),
      ),
      GoRoute(
        path: RouterPath.expectationFromApp,
        builder: (context, state) => const Expectation(),
      ),
      GoRoute(
        path: RouterPath.termsOfUse,
        builder: (context, state) => const TermsOfUse(),
      ),
      GoRoute(
        path: RouterPath.attention,
        builder: (context, state) => const Attention(),
      ),
      GoRoute(
        path: RouterPath.signUp,
        builder: (context, state) => const SignUp(),
      ),
      GoRoute(
        path: RouterPath.emailVerification,
        builder: (context, state) => const VerifyEmail(),
      ),
      GoRoute(
        path: RouterPath.phoneVerification,
        builder: (context, state) => const VerifyPhone(),
      ),
      GoRoute(
        path: RouterPath.signIn,
        builder: (context, state) => const SignIn(),
      ),
      GoRoute(
        path: RouterPath.forgotPassword,
        builder: (context, state) => const ForgotPassword(),
      ),
      GoRoute(
        path: RouterPath.verifyCode,
        builder: (context, state) {
          final args = state.extra as Map<String, dynamic>?;
          return VerifyCode(
            state: args?['status'] ?? "PhoneActivation",
            title: args?['title'] ?? 'Verify Code',
            email: args?['email'] ?? 'email',
            phoneNumber: args?['phoneNumber'] ?? 'password',
            instructionText: args?['instructionText'] ?? 'Please enter the six digit code we sent you to your number ',
          );
        },
      ),

      GoRoute(
        path: RouterPath.resetPass,
        builder: (context, state) => const ResetPassword(),
      ),
    ],
  );
});
