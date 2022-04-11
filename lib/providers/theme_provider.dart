import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lista_tarefas_vitor/utils/theme.dart';
import 'package:lista_tarefas_vitor/utils/theme_colors.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeData>(
      (ref) => ThemeNotifier(themes[1]),
);