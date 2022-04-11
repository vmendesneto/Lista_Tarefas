import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lista_tarefas_vitor/controller/taskController.dart';

final taskProvider = StateNotifierProvider<TaskController, TaskState>(
      (ref) => TaskController(),
);