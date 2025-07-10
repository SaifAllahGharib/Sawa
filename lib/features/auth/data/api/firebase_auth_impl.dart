import 'package:intern_intelligence_social_media_application/core/network/firebase_auth_api.dart';
import 'package:intern_intelligence_social_media_application/features/auth/data/api/auth_api.dart';
import 'package:intern_intelligence_social_media_application/features/auth/data/models/login_model.dart';
import 'package:intern_intelligence_social_media_application/features/auth/data/models/signup_model.dart';

class FirebaseAuthApiImpl extends AuthApi {
  final FirebaseAuthApi _supabaseAuthApi;

  FirebaseAuthApiImpl(this._supabaseAuthApi);

  @override
  Future<void> createAccount(SignupModel model) async {
    return await _supabaseAuthApi.createAccount(model);
  }

  @override
  Future<void> login(LoginModel model) async {
    return await _supabaseAuthApi.login(model);
  }
}
