import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<User?> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } catch (e) {
      log('Firebase Auth Create Error: $e');
    }
    return null;
  }

  Future<User?> loginUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } catch (e) {
      log('Firebase Auth Login Error: $e');
      throw Exception('An unknown error occurred');
    }
  }

  Future<void> signOut() async {
    try {
      _auth.signOut();
    } catch (e) {
      log('Firebase Auth SignOut Error: $e');
    }
  }

  Future<bool> isEmailRegistered(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
