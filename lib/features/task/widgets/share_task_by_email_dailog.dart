import 'package:flutter/material.dart';
import 'package:todo_firebase/features/task/view_models/task_view_model.dart';

class ShareTaskByEmailDailog extends StatefulWidget {
  const ShareTaskByEmailDailog({
    super.key,
    required this.vm,
    required this.taskId,
  });
  final TaskViewModel vm;
  final String taskId;

  @override
  State<ShareTaskByEmailDailog> createState() => _ShareTaskByEmailDailogState();
}

class _ShareTaskByEmailDailogState extends State<ShareTaskByEmailDailog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  void _saveTask() {
    if (_formKey.currentState!.validate()) {
      widget.vm.shareTask(widget.taskId, _emailController.text.trim());
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Share Task'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              validator:
                  (value) =>
                      value == null || value.isEmpty ? 'Enter a Email' : null,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            // Implement sharing logic here
            _saveTask();
          },
          child: const Text('Share'),
        ),
      ],
    );
  }
}
