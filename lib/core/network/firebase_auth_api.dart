import 'package:intern_intelligence_social_media_application/core/network/firebase_clint.dart';
import 'package:intern_intelligence_social_media_application/features/auth/data/models/login_model.dart';
import 'package:intern_intelligence_social_media_application/features/auth/data/models/signup_model.dart';

class FirebaseAuthApi {
  final FirebaseClint _firebaseClint;

  FirebaseAuthApi(this._firebaseClint);

  Future<void> createAccount(SignupModel model) async {
    await _firebaseClint.auth.createUserWithEmailAndPassword(
      email: model.email,
      password: model.password,
    );
  }

  Future<void> login(LoginModel model) async {
    await _firebaseClint.auth.signInWithEmailAndPassword(
      email: model.email,
      password: model.password,
    );
  }
}
