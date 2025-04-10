import 'package:flutter/material.dart';
import 'package:todo_firebase/core/shared/extension/context_extension.dart';
import 'package:todo_firebase/features/auth/view/signin_screen.dart';
import 'package:todo_firebase/features/auth/view_model/auth_view_model.dart';
import 'package:todo_firebase/features/task/view/task_view.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthViewModel();

  void _signUp() async {
    try {
      final user = await _authService.signUp(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
      if (user != null) {
        await _authService.createUserDocumentIfNotExists(user);
        context.showSnack("Sign up succesful");
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => TaskHomeScreen(currentUserId: user),
          ),
        );
      }
    } catch (e) {
      context.showSnack("Error $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _signUp, child: const Text('Sign Up')),
            const SizedBox(height: 10),
            TextButton(
              onPressed:
                  () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const SignInScreen()),
                  ),
              child: const Text('Already have an account? Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}
