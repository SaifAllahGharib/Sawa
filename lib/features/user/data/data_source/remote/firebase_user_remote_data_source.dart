import 'package:injectable/injectable.dart';

import '../../../../../core/clients/firebase_client.dart';
import '../../model/user_model.dart';
import 'interface/i_user_remote_data_source.dart';

@LazySingleton(as: IUserRemoteDataSource)
class FirebaseUserRemoteDataSource implements IUserRemoteDataSource {
  final FirebaseClient _firebaseClient;

  FirebaseUserRemoteDataSource(this._firebaseClient);

  @override
  Future<void> createUser({required UserModel user}) async {
    return _firebaseClient.db
        .ref()
        .child('users')
        .child(user.id)
        .set(user.toJson());
  }

  @override
  Future<void> deleteUser({required String uId}) async {
    return _firebaseClient.db.ref().child('users').child(uId).remove();
  }

  @override
  Future<UserModel> getUser({required String uId}) async {
    final response = await _firebaseClient.db
        .ref()
        .child('users')
        .child(uId)
        .get();

    final rawMap = Map<String, dynamic>.from(response.value as Map);
    return UserModel.fromJson(rawMap);
  }

  @override
  Future<void> updateUser({required UserModel user}) async {
    return _firebaseClient.db
        .ref()
        .child('users')
        .child(user.id)
        .update(user.toJson());
  }

  @override
  Future<bool> userExists({required String uId}) async {
    final snapshot = await _firebaseClient.db
        .ref()
        .child('users')
        .child(uId)
        .get();

    return snapshot.exists;
  }
}
