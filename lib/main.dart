import 'dart:async';
import 'dart:convert';
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {



final _toDoControler = TextEditingController(text: "Nome da Tarefa"); //para pegar o texto digitado

  List _toDoList = [];//lista
  Map<String, dynamic> _lastRemoved; //mapa para desfazer remoção
  int _lastRemovedPos; //pq se eu desfazer a remoçao quero q ele volte para a mesma posição em que estava


//linha de baixo foi criada com ctrl+o e escolhido initstate para sempre q o app abrir buscar as tarefas q estão salvas do ultimo uso
  @override
  void initState() {
    super.initState();
    _readData().then((data){ //chamando o readdata e colocando em na string data
      setState(() {
        _toDoList = json.decode(data);
      });
      });


  }

  void _addToDo() {
    //essa é a função que será incluida no botão linha 56
    setState(() {
      //setstate para que quando ele fizer a adição abaixo ele atualize a tela na hora
      Map<String, dynamic> newToDo =
      Map(); //map sempre vai ser string e dynamic
        newToDo["title"] = _toDoControler.text; //o titulo da nova tarefa é o que estiver escrito no text box
        _toDoControler.text ="Nome da Tarefa"; //sendo assim quando adicionar ele zera o que estava escrito
        newToDo["ok"] =false; //inicializar a tarefa sempre falsa pois acabou de ser criada
        _toDoList.add(newToDo); //adicionando um map na nossa lista
        _savedata(); //salvando permanentemente ao adicionar e savedata na hora do check tbm linha 100
      }
    );
  }
    Future<Null> _refresh() async {
      //criando a função refresh e pedindo para atualizar em 1 segundo
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        _toDoList.sort((a, b) { //função para os não concluidos aparecerem primeiro usada na linha 110
          if (a["ok"] &&
              !b["ok"]) return 1; //se a for ok e b for diferente "!" de ok então 1
          else if (!a["ok"] &&
              b["ok"]) return -1; //se b for ok e a for diferente "!" de ok então -1
          else
            return 0; // se od dois nao forem ok então 0
        });
        _savedata();
      });
      return null;
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //dados do AppBar
        title: Text("Lista de Tarefas"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Column(
        //coluna dos dados
        children: [
          Container(
            //container de espaçamentos linha 33 e criar linha de dados linha 34
            padding: EdgeInsets.fromLTRB(17.0, 1.0, 7.0, 1.0),
            child: Row(
              children: [
                Expanded(
                    child: //expanded foi colocado para ele devifinir o tamanho o textfield e do botao na linha, sem definir os tamanho não roda
                        TextFormField( //troquei o textfield
                          validator: (value){
                            if (value.isEmpty){
                              return "Insira Tarefa";
                            }
                            return null;
                          },
                            controller: _toDoControler, // o que for adicionado no texto salvar no _toDoControler criado na linha 21
                            decoration: InputDecoration(
                            labelText: ("Nova tarefa"),
                            labelStyle: TextStyle(color: Colors.blueAccent
    ,)
                            )
  )),
                RaisedButton(
                  //criando um botão
                  color: Colors.blueAccent,
                  child: Text("ADD"),
                  textColor: Colors.white,
                  onPressed: _addToDo,
                  ),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refresh,
              child: ListView.builder(
                //listView é uma lista, builder é q permite q construe enquanto rola
                  padding: EdgeInsets.only(top: 10.0), //espaçando no topo
                  itemCount: _toDoList
                      .length, //definindo quantidade de itens, a quantidade que estiver no todolist vai ser o tamanho dela
                  itemBuilder: buildItem), //criou essa funçao da listview na linha 102 a 124 para não ficar muita coisa aqui
            ),

          )
        ],
      ),
    );
  } //obter o aruivo linha 28 a 32
  Widget buildItem(context, index) {
    //index é o numero de cada elemento
    return Dismissible( //criando o excluir apartir da rolagem para o lado como ex. excluir email do gmail
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),//a Key é para saber qual excluir
      background: Container(
        color: Colors.red,
        child: Align( //criando o icone da lixeira, primeiro o alinhamento deposi o icone, -0.9 é da esquerda para direita sendo -0.1 o centro colado na esquerda
          alignment: Alignment(-0.9,0.0),
          child: Icon(Icons.delete, color: Colors.white,), //icone da lixeira e cor
        ),
      ),
      direction: DismissDirection.startToEnd,//escolhendo esquerda para direita para excluir
      child: CheckboxListTile( //escolhendo o que vou excluir linha 113 a 133
        // lista normal mais o botao de check
        title: Text(_toDoList[index]["title"]),
        value: _toDoList[index]["ok"], //resposta no check
        secondary: CircleAvatar(
          child: Icon(
            _toDoList[index]["ok"]
                ? //definir se esta concluido ou não
            Icons.check
                : Icons
                .error, //vai mudar o icone de definido ou não
          ),
        ),
        onChanged: (c) {
          setState(() {
            _toDoList[index]["ok"] = c; //obter se é true ou false e depois armazenar e salvar na variavel c setstate atualiza na hora
            _savedata();
          });
        },
      ),
        onDismissed: (direction){
        setState(() {  //tudo em setstate para atualização na hora
          _lastRemoved = Map.from(_toDoList[index]); //salvando o que removemos na linha 138 e 139, para se a pessoa quiser desfazer ele saber o que era
          _lastRemovedPos = index;
          _toDoList.removeAt(index);//aqui realmente removemos ele

          _savedata();//para salvar o que foi feito

          final sanke = SnackBar(content: Text("Tarefa ${_lastRemoved["title"]} foi removida"),//snackbar informando que a tarefa X foi removida
         action: SnackBarAction(label: "Desfazer", onPressed: (){
           setState(() {
             _toDoList.insert(_lastRemovedPos, _lastRemoved); //incluir novamente na minha lista na mesma posião e nome
             _savedata(); //salvando
           });
         }),
            duration: Duration(seconds: 3), //duração que quanto tempo ele vai ficar na tela
          );
          Scaffold.of(context).removeCurrentSnackBar(); //não deixar duas snakebar aparecerem ao mesmo tempo
          Scaffold.of(context).showSnackBar(sanke); //para exibir o snake criado na acima linha 145 a 153
        });
    },
    );
  }
  Future<File> _getFile() async {
    //lista de arquivos
    final directory =
        await getApplicationDocumentsDirectory(); //await pq é dados futuros async e sincronização
    return File(
        "${directory.path}/data.json"); //abrindo o arquivo atraves do File, linha de cima abri o diretorio e linha de baixo escolho o local no diretorio
  } //salvar dados linha 33 a 37

  Future<File> _savedata() async {
    //tudo que ocorre salvamento e leitura de arquivos nao é estantanio é async
    String data = json.encode(
        (_toDoList)); //transformando minha lista em um json e salvando em uma string (data)
    final file = await _getFile();
    return file.writeAsString(data);
  }

//ler o arquivo linha 39 a 47
  Future<String> _readData() async {
    try {
      final file = await _getFile();
      return file.readAsString();
    } catch (e) {
      return null;
    }
  }
}
