import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lista_tarefas_vitor/controller/initial_controller.dart';
import 'package:lista_tarefas_vitor/providers/providers.dart';
import 'package:lista_tarefas_vitor/widgets/dialog_theme.dart';
import 'package:share/share.dart';


class OpenTask extends ConsumerStatefulWidget {
  const OpenTask({Key? key}) : super(key: key);

  @override
  OpenTaskState createState() => OpenTaskState();
}

class OpenTaskState extends ConsumerState<OpenTask> {
  final inicio = new initial();
  final _toDoControler = TextEditingController();

  late Map<String, dynamic> _lastRemoved;
  late int _lastRemovedPos;


  @override
  void initState() {
    super.initState();
    inicio.readData().then((data) {
      setState(() {
        inicio.lista = json.decode(data!);
      });
    });
  }

  void addToDo() {
    if (_toDoControler.text.isNotEmpty) {
      Map<String, dynamic> newToDo = Map();
      newToDo["title"] = _toDoControler.text;
      newToDo["ok"] = false;
      inicio.lista.add(newToDo);
      inicio.savedata();
      setState(() {
        inicio.lista = inicio.lista;
        _toDoControler.text = "";
        FocusScope.of(context).requestFocus(new FocusNode());
      });

    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(themeProvider);
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Tarefas"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        actions: [
          PopupMenuButton(
              color: state.primaryColor,
              elevation: 20,
              enabled: true,
              onSelected: (value) {
                setState(() {
                  //value == 1
                  //   ?
                  Navigator.of(context)
                         .push(showThemeChangerDialog(context));

                });
              },
              itemBuilder: (context) => [
                    PopupMenuItem(
                      child:  Text(
                        "Trocar o Tema",
                        style: TextStyle(color: state.cardColor),
                      ),
                      value: 1,
                    ),
                   /* PopupMenuItem(
                      child: Text("Apagar Todas as Tarefas",
                          style: TextStyle(color: state.cardColor)),
                      value: 2,
                    ),*/
                  ])
        ],
      ),
      body: Center(
          child: Column(
        children: [
          SizedBox(height: _height * 0.0016,),
          Container(
            padding: EdgeInsets.all(4.0),
            child: Row(
              children: [
                Expanded(
                    child: Container(
                        height: _height * 0.06,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueAccent)),
                        child: TextField(
                            style:
                                TextStyle(color: state.cardColor, fontSize: _height * 0.054, decoration: TextDecoration.none),
                            autofocus: false,
                            controller: _toDoControler,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                hintText: ("Nova tarefa"),
                                hintStyle: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: _height * 0.024))))),
                SizedBox(
                  width: _width * 0.0125,
                ),
                SizedBox(
                    height: _height * 0.06,
                    child: ElevatedButton(
                      child: Text("ADD"),
                      onPressed:(){
                        addToDo();
                        _refresh();
                      } ,
                    )),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.only(top: 10.0),
                itemCount: inicio.lista.length,
                itemBuilder: buildItem),
          ),
        ],
      )),
    );
  }

  Widget buildItem(context, index) {
    final state = ref.watch(themeProvider);
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.height;

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
      child: inicio.lista[index]["ok"] == false
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent),
                    ), //BoxDecoration

                    child: CheckboxListTile(
                        tileColor: state.primaryColorDark,
                        selectedTileColor: state.cardColor,
                        subtitle: Text(
                          "Arraste para direita para excluir  -->",
                          style:
                              TextStyle(fontSize: _height * 0.0164, color: state.cardColor),
                        ),
                        title: Text(
                          inicio.lista[index]["title"],
                          style:
                              TextStyle(fontSize: _height * 0.03, color: state.cardColor),
                        ),
                        value: inicio.lista[index]["ok"],
                        secondary: CircleAvatar(
                          backgroundColor: state.primaryColor,
                          child: Icon(
                            inicio.lista[index]["ok"]
                                ? Icons.check
                                : Icons.pending_actions,
                            color: state.cardColor,
                          ),
                        ),
                        onChanged: (c) {
                          setState(() {
                            inicio.lista[index]["ok"] = c;
                            inicio.savedata();
                          });
                        }))
              ]))
          : Container(),
      onDismissed: (direction) {
        setState(() {
          _lastRemoved = Map.from(inicio.lista[index]);
          _lastRemovedPos = index;
          inicio.lista.removeAt(index);
          inicio.savedata();


          final sanke = SnackBar(
            content: Text("Tarefa ${_lastRemoved["title"]} foi removida"),
            action: SnackBarAction(
                label: "Desfazer",
                onPressed: () {
                  setState(() {
                    inicio.lista.insert(_lastRemovedPos, _lastRemoved);
                    inicio.savedata();
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


  Future<Null> _refresh() async {
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      inicio.lista.sort((a, b) {
        if (a["ok"] && !b["ok"])
          return 1;
        else if (!a["ok"] && b["ok"])
          return -1;
        else
          return 0;
      });
      inicio.savedata();
    });
    return null;
  }

  /*showConfDelete(BuildContext context, state) {

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: state.primaryColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          title:
              Text("Excluir Tarefas", style: TextStyle(color: state.cardColor)),
          content: Text("Confirma a exclusão das tarefas pendentes",
              style: TextStyle(color: state.cardColor)),
          actions: <Widget>[
            TextButton(
              child: Text('Yes', style: TextStyle(color: state.hoverColor)),
              onPressed: () {
                setState(() {
                  inicio.deleteData();
                  inicio.lista = inicio.lista;
                  Navigator.pop(context);
                });

              },
            ),
            TextButton(
              child: Text('No', style: TextStyle(color: state.hoverColor)),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );

  }*/
}
