import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> createUserIfNotExist(User user) async {
    final userDoc = await _db.collection('users').doc(user.uid).get();

    if (!userDoc.exists) {
      await _db.collection('users').doc(user.uid).set({
        'email': user.email,
        'name': user.displayName ?? "user${user.uid.substring(0, 5)}",
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }

  Future<User?> signUp(String email, String password) async {
    final result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result.user;
  }

  Future<User?> signIn(String email, String password) async {
    final result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result.user;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Stream<User?> get user => _auth.authStateChanges();
}
