import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_firebase/features/task/models/task_model.dart';
import 'package:todo_firebase/features/task/repository/task_repository.dart';

class TaskViewModel extends ChangeNotifier {
  final TaskRepository _taskRepo = TaskRepository();

  StreamSubscription? _taskSub;

  Stream<List<Task>> getTasks(String uid) {
    return _taskRepo.getTasks(uid);
  }

  void addTask(Task task) {
    _taskRepo.addTask(task);
  }

  void updateTask(Task task) {
    _taskRepo.updateTask(task);
  }

  void toggleComplete(Task task) {
    _taskRepo.toggleComplete(task);
  }

  void shareTask(String taskId, String email) {
    _taskRepo.shareTask(taskId, email);
  }

  @override
  void dispose() {
    _taskSub?.cancel();
    super.dispose();
  }
}
