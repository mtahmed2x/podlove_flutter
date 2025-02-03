class ApiEndpoints {
  static String baseUrl = "http://142.93.217.28:7000";
  // static String baseUrl = "http://10.0.60.41:7000";

  static String signUp = "/auth/register";
  static String activation = "/auth/activate";
  static String signIn = "/auth/login";
  static String forgotPassword = "/auth/forgot-password";
  static String recovery = "/auth/recovery";
  static String resetPassword = "/auth/reset-password";
  static String changePassword = "/auth/change-password";
  static String resendOTP = "/auth/resend-otp";

  static String home = "/home";

  static String privacy = "/privacy";
  static String terms = "/tac";
  static String faq = "/faq";
  static String help = "/support/create";

  static String deleteAccount = "/auth/delete";

  static String purchase = "/subscription/upgrade";
}
