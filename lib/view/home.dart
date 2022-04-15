import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lista_tarefas_vitor/controller/initial_controller.dart';
import 'package:lista_tarefas_vitor/view/closed_task.dart';

import 'package:lista_tarefas_vitor/view/open_task.dart';
import 'package:flutter/material.dart';

// Providers
import 'package:lista_tarefas_vitor/providers/providers.dart';


class HomePage extends ConsumerWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final PageController _pageController = PageController();
  var inicio = new initial();


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(themeProvider);
    final dataNotifier = ref.watch(homeProvider.notifier);
    final data = ref.watch(homeProvider);


    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: state.indicatorColor)),
            color: state.primaryColor),
        child: PageView(
          controller: _pageController,
          physics: BouncingScrollPhysics(),
          onPageChanged: (index) {
            dataNotifier.setIndex(index);
          },
          children: <Widget>[
            OpenTask(),
            ClosedTask(),
            //ThemeChangerWidget(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: data.selectedIndex,
        unselectedItemColor: state.textTheme.bodyText2!.color,
        onTap: (index) {
            _pageController.jumpToPage(index);
        },
        selectedItemColor: state.indicatorColor,
        backgroundColor: state.primaryColor,
        elevation: 0.0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.pending_actions,
              size: 23.3,
            ),
            label: 'Pendentes',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.fact_check_outlined,
              size: 23.3,
            ),
            label: 'Concluidas',
          ),
        ],
      ),
    );
  }
}
