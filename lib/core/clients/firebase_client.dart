import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';

@singleton
class FirebaseClient {
  final FirebaseAuth _auth;
  final FirebaseDatabase _db;

  FirebaseClient(this._auth, this._db);

  FirebaseAuth get auth => _auth;

  FirebaseDatabase get db => _db;
}
