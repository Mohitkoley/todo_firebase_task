import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_firebase/features/auth/view/signin_screen.dart';
import 'package:todo_firebase/features/task/models/task_model.dart';
import 'package:todo_firebase/features/task/view_models/task_view_model.dart';
import 'package:todo_firebase/features/task/widgets/task_input_dialog.dart';
import 'package:todo_firebase/features/task/widgets/task_tile.dart';

class TaskHomeScreen extends StatelessWidget {
  final User currentUserId;

  const TaskHomeScreen({super.key, required this.currentUserId});

  @override
  Widget build(BuildContext context2) {
    return Scaffold(
      appBar: AppBar(
        title: Text(currentUserId.email ?? ""),
        actions: [
          //sign out button
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context2).pushReplacement(
                MaterialPageRoute(builder: (context) => const SignInScreen()),
              );
            },
          ),
        ],
      ),
      body: PopScope(
        canPop: false,
        child: Consumer<TaskViewModel>(
          builder: (context, vm, _) {
            return StreamBuilder<List<Task>>(
              stream: vm.getTasks(currentUserId.uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Text(
                        "Long Press to share",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.blueGrey,
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                          itemCount: snapshot.data!.length,
                          separatorBuilder: (context, index) => Divider(),
                          itemBuilder: (context, index) {
                            final task = snapshot.data![index];
                            return TaskTile(
                              userId: currentUserId.uid,
                              task: task,
                              vm: vm,
                              onToggle: () {
                                // vm.toggleComplete(task);
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return TaskInputDialog(
                                      onSave: (updatedTask) {
                                        vm.updateTask(updatedTask);
                                      },
                                      currentUserId: currentUserId.uid,
                                      existingTask: task,
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
                return const Center(child: Text('No tasks available'));
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context2,
            builder:
                (_) => TaskInputDialog(
                  onSave: (task) {
                    Provider.of<TaskViewModel>(
                      context2,
                      listen: false,
                    ).addTask(task);
                  },
                  currentUserId: currentUserId.uid,
                ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
