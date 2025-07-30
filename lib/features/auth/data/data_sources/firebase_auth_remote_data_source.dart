import 'package:injectable/injectable.dart';
import 'package:intern_intelligence_social_media_application/core/clients/firebase_client.dart';
import 'package:intern_intelligence_social_media_application/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:intern_intelligence_social_media_application/features/auth/data/models/login_model.dart';
import 'package:intern_intelligence_social_media_application/features/auth/data/models/signup_model.dart';

@LazySingleton(as: IAuthRemoteDataSource)
class FirebaseAuthRemoteDataSource implements IAuthRemoteDataSource {
  final FirebaseClient _firebaseClint;

  FirebaseAuthRemoteDataSource(this._firebaseClint);

  @override
  Future<String?> createAccount(SignupModel model) async {
    return await _firebaseClint.auth
        .createUserWithEmailAndPassword(
          email: model.email,
          password: model.password,
        )
        .then((value) => value.user?.uid);
  }

  @override
  Future<String?> login(LoginModel model) async {
    return await _firebaseClint.auth
        .signInWithEmailAndPassword(
          email: model.email,
          password: model.password,
        )
        .then((value) => value.user?.uid);
  }

  @override
  Future<bool> emailVerified() async {
    var user = _firebaseClint.auth.currentUser;
    await user?.reload();
    return user?.emailVerified ?? false;
  }

  @override
  Future<void> sendEmailVerification() async {
    var user = _firebaseClint.auth.currentUser;
    await user?.reload();
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  @override
  Future<void> deleteUser(LoginModel model) async {
    final user = _firebaseClint.auth.currentUser;

    if (user != null) {
      await user.delete();
    } else {
      final userCredential = await _firebaseClint.auth
          .signInWithEmailAndPassword(
            email: model.email,
            password: model.password,
          );
      await userCredential.user?.delete();
    }
  }

  @override
  Future<void> logout() async {
    await _firebaseClint.auth.signOut();
  }
}
