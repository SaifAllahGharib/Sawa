import 'package:injectable/injectable.dart';

import '../../../../core/clients/firebase_client.dart';
import '../model/user_model.dart';
import 'user_remote_data_source.dart';

@LazySingleton(as: IUserRemoteDataSource)
class FirebaseUserRemoteDataSource implements IUserRemoteDataSource {
  final FirebaseClient _firebaseClient;

  FirebaseUserRemoteDataSource(this._firebaseClient);

  @override
  Future<void> createUser(UserModel user) async {
    return _firebaseClient.db
        .ref()
        .child('users')
        .child(user.id)
        .set(user.toJson());
  }

  @override
  Future<void> deleteUser(String userId) async {
    return _firebaseClient.db.ref().child('users').child(userId).remove();
  }

  @override
  Future<UserModel> getUser(String uId) async {
    final response = await _firebaseClient.db
        .ref()
        .child('users')
        .child(uId)
        .get();

    final rawMap = Map<String, dynamic>.from(response.value as Map);
    return UserModel.fromJson(rawMap);
  }

  @override
  Future<void> updateUser(UserModel user) async {
    return _firebaseClient.db
        .ref()
        .child('users')
        .child(user.id)
        .update(user.toJson());
  }

  @override
  Future<bool> userExists(String uId) async {
    final snapshot = await _firebaseClient.db
        .ref()
        .child('users')
        .child(uId)
        .get();

    return snapshot.exists;
  }
}
