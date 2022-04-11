import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lista_tarefas_vitor/providers/providers.dart';
import 'package:path_provider/path_provider.dart';



List? toDoList;

class OpenTask extends ConsumerStatefulWidget {
  const OpenTask({Key? key}) : super(key: key);

  @override
  _OpenTaskState createState() => _OpenTaskState();
}

class _OpenTaskState extends ConsumerState<OpenTask> {



  final _toDoControler = TextEditingController();

  List _toDoList = []; //lista
  late Map<String, dynamic> _lastRemoved;
  late int _lastRemovedPos;

  @override
  void initState() {
    super.initState();
    _readData().then((data) {
      setState(() {
        _toDoList = json.decode(data!);
      });
    });
  }

  void _addToDo() {
    if (_toDoControler.text.isNotEmpty) {
      setState(() {
        Map<String, dynamic> newToDo = Map();
        newToDo["title"] = _toDoControler.text;
        _toDoControler.text = "";
        newToDo["ok"] = false;
        _toDoList.add(newToDo);
        _savedata();
      });
    }
    return null;
  }

  Future<Null> _refresh() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _toDoList.sort((a, b) {
        if (a["ok"] && !b["ok"])
          return 1;
        else if (!a["ok"] && b["ok"])
          return -1;
        else
          return 0;
      });
      _savedata();
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {

    final state = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Tarefas"),
        backgroundColor: Colors.blueAccent[700],
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(17.0, 1.0, 7.0, 1.0),
            child: Row(
              children: [
                Expanded(
                    child: TextFormField(
                      style: TextStyle(color: state.cardColor),
                        autofocus: true,
                        validator: (value) {
                          if (value!.isEmpty || value == "") {
                            return "Insira Tarefa";
                          }
                          return null;
                        },
                        controller: _toDoControler,
                        decoration: InputDecoration(
                            labelText: ("Nova tarefa"),
                            labelStyle: TextStyle(
                              color: Colors.blueAccent[700],
                            )))),
                ElevatedButton(
                  child: Text("ADD"),
                  onPressed: _addToDo,
                ),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refresh,
              child: ListView.builder(
                  padding: EdgeInsets.only(top: 10.0),
                  itemCount: _toDoList.length,
                  itemBuilder: buildItem),
            ),
          )
        ],
      ),
    );
  }

  Widget buildItem(context, index) {

    final state = ref.watch(themeProvider);

    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      background: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment(-0.9, 0.0),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
      direction: DismissDirection.startToEnd,
      child: CheckboxListTile(
        tileColor:  state.primaryColorDark,
        selectedTileColor: state.cardColor,

        subtitle: Text(
          "Arraste para excluir",
          style: TextStyle(fontSize: 12,color: state.cardColor),
        ),
        title: Text(
          _toDoList[index]["title"],
          style: TextStyle(fontSize: 20, color: state.cardColor),
        ),
        value: _toDoList[index]["ok"],
        secondary: CircleAvatar(
          backgroundColor: state.primaryColor,
          child: Icon(
            _toDoList[index]["ok"] ? Icons.check : Icons.pending_actions,
            color: state.cardColor,
          ),
        ),
        onChanged: (c) {
          setState(() {
            _toDoList[index]["ok"] = c;
            _savedata();
          });
        },
      ),
      onDismissed: (direction) {
        setState(() {
          _lastRemoved = Map.from(_toDoList[index]);
          _lastRemovedPos = index;
          _toDoList.removeAt(index);

          _savedata();

          final sanke = SnackBar(
            content: Text("Tarefa ${_lastRemoved["title"]} foi removida"),
            action: SnackBarAction(
                label: "Desfazer",
                onPressed: () {
                  setState(() {
                    _toDoList.insert(_lastRemovedPos, _lastRemoved);
                    _savedata();
                  });
                }),
            duration: Duration(seconds: 3),
          );
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(sanke);
        });
      },
    );
  }

  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data.json");
  }

  Future<File> _savedata() async {
    String data = json.encode((_toDoList));
    final file = await _getFile();
    return file.writeAsString(data);
  }

  Future<String?> _readData() async {
    try {
      final file = await _getFile();
      return file.readAsString();
    } catch (e) {
      return null;
    }
  }
}

