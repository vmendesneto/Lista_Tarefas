import 'package:flutter_riverpod/flutter_riverpod.dart';


import 'package:lista_tarefas_vitor/view/open_task.dart';
import 'package:flutter/material.dart';

// Providers
import 'package:lista_tarefas_vitor/providers/providers.dart';
import 'package:lista_tarefas_vitor/widgets/dialog_theme.dart';

class HomePage extends ConsumerWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(themeProvider);
    final dataNotifier = ref.watch(homeProvider.notifier);
    final data = ref.watch(homeProvider);
    final settingsNotifier = ref.watch(homeSettingsProvider.notifier);

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
            ThemeChangerWidget(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: data.selectedIndex,
        //selectedIndex: data.selectedIndex,
        unselectedItemColor: state.textTheme.bodyText2!.color,
        //unselectedColor: state.textTheme.bodyText2!.color,
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
        //onItemSelected: (index) {
        //   _pageController.jumpToPage(index);
        // },
        selectedItemColor: state.indicatorColor,
        //selectedColor: state.indicatorColor,
        backgroundColor: state.primaryColor,
        elevation: 0.0,
        //showElevation: false,
        items: [
          // BottomNavyBarItem(
          //   icon: Icon(Icons.work_outline),
          //   title: Text('Marketplace'),
          // ),

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
          BottomNavigationBarItem(
            icon: Icon(
              Icons.palette_outlined,
              size: 23.3,
            ),
            label: 'Temas',
          ),

        ],
      ),
    );
  }
}