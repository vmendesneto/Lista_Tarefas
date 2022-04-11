import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lista_tarefas_vitor/controller/home_controller.dart';

final homeProvider = StateNotifierProvider<HomeController, HomeState>(
      (ref) => HomeController(),
);