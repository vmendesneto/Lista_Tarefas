
import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';




class initial{
  List lista = [];


  Future<File> getFile() async {
    final directory = await getApplicationDocumentsDirectory();
      return File("${directory.path}/data.json");
  }

  Future<File> savedata() async {
    String data = json.encode((lista));
    final file = await getFile();
    return file.writeAsString(data);
  }

  Future<String?> readData() async {
    try {
      final file = await getFile();
      readData().then((value) => {
        if(value!.isNotEmpty){
          lista = jsonDecode(value)
        } else {
          lista = []
        }
      });
      return file.readAsString();
    } catch (e) {
      return null;
    }
  }
  Future<String?> deleteData() async {
        lista.clear();
        savedata();
        lista = lista;
    }


}