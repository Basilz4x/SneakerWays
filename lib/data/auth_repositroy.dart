import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthRepositroy {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> createUser({
    required String email,
    required String password,
  }) async {
    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOutUser() async {
    await _auth.signOut();
  }
}

final authRepositroyProvider = Provider((ref) => AuthRepositroy());
