class EndPoints {
  static const String signUp = "/api/v1/auth/signup";
  static const String signIn = "/api/v1/auth/signin";
  // Forgot password flow (adjust to your backend routes if different)
  static const String sendOtp = "/api/v1/auth/send-otp"; // body: { phone }
  static const String verifyOtp =
      "/api/v1/auth/verify-otp"; // body: { phone, otp }
  static const String resetPassword =
      "/api/v1/auth/reset-password"; // body: { phone, otp, newPassword }
}
