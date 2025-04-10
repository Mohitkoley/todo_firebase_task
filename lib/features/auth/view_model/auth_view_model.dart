import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_firebase/features/auth/repository/auth_repository.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _authRepo = AuthRepository();

  Future<User?> signUp(String email, String password) async {
    return await _authRepo.signUp(email, password);
  }

  Future<User?> signIn(String email, String password) async {
    return _authRepo.signIn(email, password);
  }

  Future<void> signOut() async {
    await _authRepo.signOut();
  }

  Future<void> createUserDocumentIfNotExists(User user) async {
    await _authRepo.createUserIfNotExist(user);
  }

  Stream<User?> get user => _authRepo.user;
}
