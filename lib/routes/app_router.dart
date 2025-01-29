import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:podlove_flutter/data/models/home_response_model.dart';
import 'package:podlove_flutter/routes/route_path.dart';
import 'package:podlove_flutter/constants/app_enums.dart';
import 'package:podlove_flutter/ui/screens/auth/singup.dart';
import 'package:podlove_flutter/ui/screens/home/content/home_content.dart';
import 'package:podlove_flutter/ui/screens/home/content/profile_content.dart';
import 'package:podlove_flutter/ui/screens/home/home.dart';
import 'package:podlove_flutter/ui/screens/home/podcast.dart';
import 'package:podlove_flutter/ui/screens/home/profile/edit_profile.dart';
import 'package:podlove_flutter/ui/screens/home/settings/change_password.dart';
import 'package:podlove_flutter/ui/screens/home/sidebar/faq.dart';
import 'package:podlove_flutter/ui/screens/home/sidebar/help.dart';
import 'package:podlove_flutter/ui/screens/home/sidebar/privacy_policty.dart';
import 'package:podlove_flutter/ui/screens/home/sidebar/settings.dart';
import 'package:podlove_flutter/ui/screens/home/sidebar/terms_conditions.dart';
import 'package:podlove_flutter/ui/screens/onboarding/connection_pathway.dart';
import 'package:podlove_flutter/ui/screens/splash_screen/initial_screen.dart';
import 'package:podlove_flutter/ui/screens/splash_screen/splash_screen.dart';
import 'package:podlove_flutter/ui/screens/onboarding/approach.dart';
import 'package:podlove_flutter/ui/screens/onboarding/expectation.dart';
import 'package:podlove_flutter/ui/screens/onboarding/attention.dart';
import 'package:podlove_flutter/ui/screens/auth/forgot_password.dart';
import 'package:podlove_flutter/ui/screens/auth/reset_password.dart';
import 'package:podlove_flutter/ui/screens/auth/signin.dart';
import 'package:podlove_flutter/ui/screens/auth/verify_code.dart';
import 'package:podlove_flutter/ui/screens/onboarding/terms.dart';
import 'package:podlove_flutter/ui/screens/user/add_bio.dart';
import 'package:podlove_flutter/ui/screens/user/age/select_age.dart';
import 'package:podlove_flutter/ui/screens/user/age/select_preferred_age.dart';
import 'package:podlove_flutter/ui/screens/user/body/select_body_type.dart';
import 'package:podlove_flutter/ui/screens/user/body/select_preferred_body_type.dart';
import 'package:podlove_flutter/ui/screens/user/compatibility_question.dart';
import 'package:podlove_flutter/ui/screens/user/ethnicity/select_ethnicity.dart';
import 'package:podlove_flutter/ui/screens/user/ethnicity/select_preferred_ethnicities.dart';
import 'package:podlove_flutter/ui/screens/user/gender/select_gender.dart';
import 'package:podlove_flutter/ui/screens/user/gender/select_preferred_gender.dart';
import 'package:podlove_flutter/ui/screens/user/location/distance_preference.dart';
import 'package:podlove_flutter/ui/screens/user/location/enter_location.dart';
import 'package:podlove_flutter/ui/screens/user/location/location_access.dart';
import 'package:podlove_flutter/ui/screens/user/select_interests.dart';
import 'package:podlove_flutter/ui/screens/user/select_personality_traits.dart';
import 'package:podlove_flutter/ui/screens/user/upload_photo.dart';

class AppRouter {
  static GoRouter appRouter = GoRouter(
    initialLocation: RouterPath.signIn,
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
          path: RouterPath.connectionPathWay,
          builder: (context, state) => const ConnectionPathway()),
      GoRoute(
        path: RouterPath.attention,
        builder: (context, state) => const Attention(),
      ),
      GoRoute(
        path: RouterPath.signUp,
        builder: (context, state) => const SignUp(),
      ),
      GoRoute(
        path: RouterPath.signIn,
        builder: (context, state) => const SignIn(),
      ),
      GoRoute(
        path: RouterPath.verifyCode,
        builder: (context, state) {
          final args = state.extra as Map<String, dynamic>?;
          return VerifyCode(
            status: args?['status'] ?? "PhoneActivation",
            title: args?['title'] ?? 'Verify Code',
            email: args?['email'] ?? 'email',
            phoneNumber: args?['phoneNumber'] ?? 'password',
            instructionText: args?['instructionText'] ??
                'Please enter the six digit code we sent you to your number ',
          );
        },
      ),
      GoRoute(
        path: RouterPath.forgotPassword,
        builder: (context, state) => const ForgotPassword(),
      ),
      GoRoute(
        path: RouterPath.resetPass,
        builder: (context, state) => const ResetPassword(),
      ),
      GoRoute(
        path: RouterPath.locationAccess,
        builder: (context, state) => const LocationAccess(),
      ),
      GoRoute(
        path: RouterPath.enterLocation,
        builder: (context, state) => const EnterLocation(),
      ),
      GoRoute(
        path: RouterPath.distancePreference,
        builder: (context, state) => const DistancePreference(),
      ),
      GoRoute(
        path: RouterPath.selectAge,
        builder: (context, state) => const SelectAge(),
      ),
      GoRoute(
        path: RouterPath.selectPreferredAge,
        builder: (context, state) => const SelectPreferredAge(),
      ),
      GoRoute(
        path: RouterPath.selectGender,
        builder: (context, state) => const SelectGender(),
      ),
      GoRoute(
        path: RouterPath.selectPreferredGender,
        builder: (context, state) => const SelectPreferredGender(),
      ),
      GoRoute(
        path: RouterPath.selectBodyType,
        builder: (context, state) => const SelectBodyType(),
      ),
      GoRoute(
        path: RouterPath.selectPreferredBodyType,
        builder: (context, state) => const SelectPreferredBodyType(),
      ),
      GoRoute(
        path: RouterPath.selectEthnicity,
        builder: (context, state) => const SelectEthnicity(),
      ),
      GoRoute(
        path: RouterPath.selectPreferredEthnicities,
        builder: (context, state) => const SelectPreferredEthnicities(),
      ),
      GoRoute(
        path: RouterPath.selectInterests,
        builder: (context, state) => const SelectInterests(),
      ),
      GoRoute(
        path: RouterPath.selectPersonalityTraits,
        builder: (context, state) => const SelectPersonalityTraits(),
      ),
      GoRoute(
        path: RouterPath.uploadPhoto,
        builder: (context, state) => const UploadPhoto(),
      ),
      GoRoute(
        path: RouterPath.addBio,
        builder: (context, state) => const AddBio(),
      ),
      GoRoute(
        path: '${RouterPath.compatibalityQuestion}/:pageIndex',
        builder: (context, state) {
          final pageIndex = int.parse(state.pathParameters['pageIndex']!);
          return CompatibilityQuestion(pageIndex: pageIndex);
        },
      ),
      GoRoute(
        path: RouterPath.home,
        builder: (context, state) => const Home(),
      ),
      GoRoute(
        path: RouterPath.homeContent,
        builder: (context, state) => HomeContent(
          onMenuTap: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      GoRoute(
        path: RouterPath.profile,
        builder: (context, state) => const ProfileContent(),
      ),
      GoRoute(
        path: RouterPath.editProfile,
        builder: (context, state) => const EditProfile(),
      ),
      GoRoute(
        path: RouterPath.privacy,
        builder: (context, state) => const PrivacyPolicy(),
      ),
      GoRoute(
        path: RouterPath.terms,
        builder: (context, state) => const TermsConditions(),
      ),
      GoRoute(
        path: RouterPath.faqs,
        builder: (context, state) => const FAQ(),
      ),
      GoRoute(
        path: RouterPath.help,
        builder: (context, state) => const Help(),
      ),
      GoRoute(
        path: RouterPath.settings,
        builder: (context, state) => const Settings(),
      ),
      GoRoute(
        path: RouterPath.changePassword,
        builder: (context, state) => const ChangePassword(),
      ),
      GoRoute(
        path: RouterPath.podcast,
        builder: (context, state) => const PodcastPage(),
      )
    ],
  );
}
