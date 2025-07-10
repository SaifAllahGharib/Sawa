abstract class SupabaseConstant {
  static const String baseUrl = 'https://llxfwyxarmesaregkaby.supabase.co';
  static const String authPath = '/auth/v1';
  static const String signUp = '/signup';
  static const String login = '/token?grant_type=password';
  static const String logout = '/logout';
  static const String refreshToken = '/token?grant_type=refresh_token';
  static const String resendEmail = '/resend';
  static const String verifyOtp = '/verify';
  static const String recoverPassword = '/recover';
  static const String updateUser = '/user';
  static const String getUser = '/user';
  static const String otp = '/otp';
  static const String databasePath = '/rest/v1';
  static const String usersTable = '/users';
  static const String storagePath = '/storage/v1';
}
