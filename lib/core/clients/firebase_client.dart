import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseClient {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseDatabase _db = FirebaseDatabase.instance;

  FirebaseClient._();

  static final FirebaseClient _instance = FirebaseClient._();

  factory FirebaseClient() {
    return _instance;
  }

  FirebaseAuth get auth => _auth;

  FirebaseDatabase get db => _db;
}
