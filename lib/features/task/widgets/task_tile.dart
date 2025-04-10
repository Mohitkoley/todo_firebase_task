import 'package:flutter/material.dart';
import 'package:todo_firebase/features/task/models/task_model.dart';
import 'package:todo_firebase/features/task/view_models/task_view_model.dart';
import 'package:todo_firebase/features/task/widgets/share_task_by_email_dailog.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.task,
    required this.onToggle,
    required this.userId,
    required this.vm,
  });
  final Task task;
  final VoidCallback onToggle;
  final String userId;
  final TaskViewModel vm;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onToggle.call();
      },
      onLongPress: () {
        //show share dialog
        showDialog(
          context: context,
          builder: (context) {
            return ShareTaskByEmailDailog(vm: vm, taskId: task.id);
          },
        );
      },
      title: Text(task.title),
      subtitle: Text(task.ownerId == userId ? "Own" : "Shared"),
      trailing: Icon(
        task.isCompleted ? Icons.check_circle : Icons.circle,
        color: task.isCompleted ? Colors.green : Colors.grey,
      ),
    );
  }
}
