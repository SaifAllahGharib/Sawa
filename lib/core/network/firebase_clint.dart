import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseClint {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseDatabase _db = FirebaseDatabase.instance;

  FirebaseClint._privateConstructor();

  static final FirebaseClint _instance = FirebaseClint._privateConstructor();

  factory FirebaseClint() {
    return _instance;
  }

  FirebaseAuth get auth => _auth;

  FirebaseDatabase get db => _db;
}
