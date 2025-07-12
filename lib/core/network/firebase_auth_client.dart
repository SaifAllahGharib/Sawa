import 'package:intern_intelligence_social_media_application/core/clients/firebase_client.dart';
import 'package:intern_intelligence_social_media_application/features/auth/data/api/auth_api.dart';
import 'package:intern_intelligence_social_media_application/features/auth/data/models/login_model.dart';
import 'package:intern_intelligence_social_media_application/features/auth/data/models/signup_model.dart';

class FirebaseAuthClient extends AuthApi {
  final FirebaseClient _firebaseClint;

  FirebaseAuthClient(this._firebaseClint);

  @override
  Future<void> createAccount(SignupModel model) async {
    await _firebaseClint.auth.createUserWithEmailAndPassword(
      email: model.email,
      password: model.password,
    );
  }

  @override
  Future<void> login(LoginModel model) async {
    await _firebaseClint.auth.signInWithEmailAndPassword(
      email: model.email,
      password: model.password,
    );
  }
}
