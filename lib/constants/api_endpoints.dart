class ApiEndpoints {
  static String baseUrl = "http://182.252.68.230:7001";
  // static String baseUrl = "http://10.0.60.41:7000";
  static String signUp = "/auth/register";
  static String activate = "/auth/activate";
  static String signIn = "/auth/login";
  static String recovery = "/auth/recovery";
  static String recoveryVerify = "/auth/recovery-verify";
  static String resetPassword = "/auth/reset-password";
  static String changePassword = "/auth/change-password";
  static String resendOTP = "/auth/resend-otp";
  static String deleteAccount = "/auth/delete";
  static String signInWithGoogle = "/auth/signin-with-google";
  static String home = "/home";
  static String privacy = "/privacy";
  static String terms = "/tac";
  static String faq = "/faq";
  static String consumer = "/consumer";
  static String media = "/media";
  static String help = "/support/create";
  static String purchase = "/subscription/upgrade";
  static String subscriptionPlan = "/plan";
  static String connectionPathway = "/ai/is-user-suitable";
  static String bioCheck = "/user/validate-bio";
}
