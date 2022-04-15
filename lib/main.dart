
import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lista_tarefas_vitor/providers/providers.dart';
import 'package:lista_tarefas_vitor/utils/theme_colors.dart';
import 'package:lista_tarefas_vitor/view/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controller/initial_controller.dart';


late SharedPreferences? prefs;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((shared) {
    prefs = shared;
    runApp(ProviderScope(child: MyApp()));
  });


}

class MyApp extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themesNotifier = ref.read(themeProvider.notifier);
    themesNotifier.setTheme(themes[prefs!.getInt("theme") ?? 1]);


    return Platform.isAndroid == true ? MaterialApp(
      theme: themesNotifier.getTheme(),
      title: 'Lista de Tarefas',
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => HomePage(),
      },
      home: HomePage(),
    ) :  CupertinoApp(
        theme: themesNotifier.getTheme(),
    title: 'Lista de Tarefas',
    debugShowCheckedModeBanner: false,
    routes: {
    '/home': (context) => HomePage(),
    },
      home: HomePage(),
    );
  }
}


