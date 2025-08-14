import 'package:injectable/injectable.dart';
import 'package:sawa/core/clients/firebase_client.dart';
import 'package:sawa/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:sawa/features/auth/data/models/login_model.dart';
import 'package:sawa/features/auth/data/models/signup_model.dart';

@LazySingleton(as: IAuthRemoteDataSource)
class FirebaseAuthRemoteDataSource implements IAuthRemoteDataSource {
  final FirebaseClient _firebaseClint;

  FirebaseAuthRemoteDataSource(this._firebaseClint);

  @override
  Future<String?> createAccount({required SignupModel signupModel}) async {
    return await _firebaseClint.auth
        .createUserWithEmailAndPassword(
          email: signupModel.identifier,
          password: signupModel.password,
        )
        .then((value) => value.user?.uid);
  }

  @override
  Future<String?> login({required LoginModel loginModel}) async {
    return await _firebaseClint.auth
        .signInWithEmailAndPassword(
          email: loginModel.identifier,
          password: loginModel.password,
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
  Future<void> deleteUser({required LoginModel loginModel}) async {
    final user = _firebaseClint.auth.currentUser;

    if (user != null) {
      await user.delete();
    } else {
      final userCredential = await _firebaseClint.auth
          .signInWithEmailAndPassword(
            email: loginModel.identifier,
            password: loginModel.password,
          );
      await userCredential.user?.delete();
    }
  }

  @override
  Future<void> logout() async {
    await _firebaseClint.auth.signOut();
  }
}
