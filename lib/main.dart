import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_firebase/features/auth/view/signin_screen.dart';
import 'package:todo_firebase/features/auth/view_model/auth_view_model.dart';
import 'package:todo_firebase/features/task/view/task_view.dart';
import 'package:todo_firebase/features/task/view_models/task_view_model.dart';
import 'package:todo_firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "TODO",
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // await configureNetworkToolsFlutter(
  //   (await getApplicationDocumentsDirectory()).path,
  //   enableDebugging: kDebugMode,
  // );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => TaskViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter TODO',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: StreamBuilder(
        stream: context.read<AuthViewModel>().user,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: const Center(child: CircularProgressIndicator()),
            );
          }
          if (snapshot.hasData) {
            final user = snapshot.data!;
            return TaskHomeScreen(currentUserId: user);
          } else {
            return const SignInScreen();
          }
        },
      ),
    );
  }
}
