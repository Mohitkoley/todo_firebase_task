import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_firebase/core/shared/extension/context_extension.dart';
import 'package:todo_firebase/features/auth/view_model/auth_view_model.dart';
import 'package:todo_firebase/features/task/view/task_view.dart';

import 'sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  openNSLocalNetworkUsageDescription() async {
    showCupertinoDialog(
      context: context,
      builder:
          (context) => Center(
            child: CupertinoAlertDialog(
              title: Text('NSLocalNetworkUsageDescription'),
              actions: [
                CupertinoDialogAction(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                CupertinoDialogAction(
                  child: Text('OK'),
                  onPressed: () {
                    // AppSettings.openAppSettings(type: AppSettingsType.wifi);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
    );
  }

  void _signIn() async {
    try {
      final user = await _authService.signIn(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
      if (user != null) {
        await _authService.createUserDocumentIfNotExists(user);
        context.showSnack('Sign in successful');
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
      appBar: AppBar(title: const Text('Sign In')),
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
            ElevatedButton(onPressed: _signIn, child: const Text('Sign In')),
            const SizedBox(height: 10),
            TextButton(
              onPressed:
                  () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const SignUpScreen()),
                  ),
              child: const Text('Don’t have an account? Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
