import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

class TaskState {
  final List? toDoList;

  TaskState({this.toDoList = const []});
}

class TaskController extends StateNotifier<TaskState> {
  TaskController([TaskState? state]) : super(TaskState()) {

    initialData();
  }



  Future<File> getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data.json");
  }

  Future<String?> readData() async {
    try {
      final file = await getFile();
      return file.readAsString();
    } catch (e) {
      return null;
    }
  }
  Future<List?> initialData() async {
    var list = [];
    readData().then((data) {
      final map = json.decode(data!);
      map.forEach((k) => list.add(Customer(k)));
      print("teste");
     // print(list.toString());
      state = TaskState(toDoList: list);
      return list;
    });
  }

  Future<File> savedata(toDoList) async {
    String data = json.encode((toDoList));
    final file = await getFile();
     return file.writeAsString(data);
  }

}
extension ListExtension<E> on List<E> {
  void addUnique(E element) {
    if (!contains(element)) {
      add(element);
    }
  }
}
class Customer {
  String titulo;

  Customer(this.titulo,);
  @override
  String toString() {
    return '{ ${this.titulo} }';
  }
}
