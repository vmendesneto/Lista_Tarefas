import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lista_tarefas_vitor/controller/home_settings_controller.dart';

final homeSettingsProvider = StateNotifierProvider<HomeSettingsController, HomeSettingsState>(
      (ref) => HomeSettingsController(),
);