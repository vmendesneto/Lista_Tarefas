import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lista_tarefas_vitor/controller/initial_controller.dart';
import 'package:lista_tarefas_vitor/providers/providers.dart';
import 'package:lista_tarefas_vitor/widgets/dialog_theme.dart';

class ClosedTask extends ConsumerStatefulWidget {
  const ClosedTask({Key? key}) : super(key: key);

  @override
  ClosedTaskState createState() => ClosedTaskState();
}

class ClosedTaskState extends ConsumerState<ClosedTask> {
  late Map<String, dynamic> _lastRemoved;
  late int _lastRemovedPos;
  var inicio = new initial();

  @override
  void initState() {
    super.initState();
    inicio.readData().then((data) {
      setState(() {
        inicio.lista = json.decode(data!);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Tarefas"),
        backgroundColor: Colors.blueAccent[700],
        centerTitle: true,
        actions: [
          PopupMenuButton(
              color: state.primaryColor,
              elevation: 20,
              enabled: true,
              onSelected: (value) {
                setState(() {
                  //value == 1
                  //     ?
                  Navigator.of(context).push(showThemeChangerDialog(context));
                  //    : inicio.deleteData;
                });
              },
              itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Text(
                        "Trocar Tema",
                        style: TextStyle(color: state.cardColor),
                      ),
                      value: 1,
                    ),
                    // PopupMenuItem(
                    //   child: Text("Apagar Todas as Tarefas",
                    //       style: TextStyle(color: state.cardColor)),
                    //   value: 2,
                    // ),
                  ])
        ],
      ),
      body: Center(
          child: Column(
        children: [
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
      child: inicio.lista[index]["ok"] == true
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent),
                    ), //BoxDecoration

                    child: CheckboxListTile(
                        tileColor: state.primaryColorDark,
                        checkColor: state.primaryColor,
                        activeColor: state.cardColor,
                        subtitle: Text(
                          "Arraste para excluir",
                          style:
                              TextStyle(fontSize: 12, color: state.cardColor),
                        ),
                        title: Text(
                          inicio.lista[index]["title"],
                          style:
                              TextStyle(fontSize: 20, color: state.cardColor),
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
                        onChanged: (c) async {
                          setState(() {
                            inicio.lista[index]["ok"] = c;
                            inicio.savedata();
                          });
                          await inicio.readData().then((data) {
                            inicio.lista = json.decode(data!);
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
}
