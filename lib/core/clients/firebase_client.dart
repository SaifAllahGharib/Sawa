import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseClient {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseDatabase _db = FirebaseDatabase.instance;

  FirebaseClient._privateConstructor();

  static final FirebaseClient _instance = FirebaseClient._privateConstructor();

  factory FirebaseClient() {
    return _instance;
  }

  FirebaseAuth get auth => _auth;

  FirebaseDatabase get db => _db;
}
