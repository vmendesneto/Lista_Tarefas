import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeSettingsState {
  final bool wantKeepAlive;
  final String cacheSize;
  final String title;

  const HomeSettingsState({this.wantKeepAlive = true, this.cacheSize = 'N/A', this.title = "Settings"});
}

class HomeSettingsController extends StateNotifier<HomeSettingsState> {
  HomeSettingsController([HomeSettingsState? state]) : super(HomeSettingsState());

  bool get wantKeepAlive => state.wantKeepAlive;
  String get cacheSize => state.cacheSize;
  String get title => state.title;

}
