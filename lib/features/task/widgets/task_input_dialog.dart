import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../models/task_model.dart';

class TaskInputDialog extends StatefulWidget {
  final void Function(Task task) onSave;
  final String currentUserId;
  final Task? existingTask; // Optional parameter for updating a task

  const TaskInputDialog({
    super.key,
    required this.onSave,
    required this.currentUserId,
    this.existingTask,
  });

  @override
  State<TaskInputDialog> createState() => _TaskInputDialogState();
}

class _TaskInputDialogState extends State<TaskInputDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  bool isCompleted = false;

  @override
  void initState() {
    super.initState();
    if (widget.existingTask != null) {
      // Populate fields if updating an existing task
      _titleController.text = widget.existingTask!.title;
      _descController.text = widget.existingTask!.description;
      isCompleted = widget.existingTask!.isCompleted;
    }
  }

  void _saveTask() {
    if (_formKey.currentState!.validate()) {
      final task = Task(
        id:
            widget.existingTask?.id ??
            const Uuid().v4(), // Use existing ID or generate a new one
        title: _titleController.text.trim(),
        description: _descController.text.trim(),
        isCompleted: isCompleted,
        ownerId: widget.existingTask?.ownerId ?? widget.currentUserId,
        sharedWith: widget.existingTask?.sharedWith ?? [widget.currentUserId],
      );

      widget.onSave(task);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.existingTask == null ? 'Create Task' : 'Update Task'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
              validator:
                  (value) =>
                      value == null || value.isEmpty ? 'Enter a title' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _descController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Completed'),
                Switch(
                  value: isCompleted,
                  onChanged: (value) {
                    setState(() {
                      if (widget.existingTask != null) {
                        widget.existingTask!.isCompleted = value;
                      }
                      isCompleted = value;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: const Text('Cancel'),
        ),
        ElevatedButton(onPressed: _saveTask, child: const Text('Save')),
      ],
    );
  }
}
