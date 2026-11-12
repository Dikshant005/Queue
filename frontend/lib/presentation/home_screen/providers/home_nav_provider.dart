import 'package:flutter_riverpod/flutter_riverpod.dart';

enum HomeNavTab {
  home,
  explore,
  activity,
  profile;

  bool get isHome => this == HomeNavTab.home;
  bool get isExplore => this == HomeNavTab.explore;
  bool get isActivity => this == HomeNavTab.activity;
  bool get isProfile => this == HomeNavTab.profile;
}

class HomeNavNotifier extends Notifier<HomeNavTab> {
  @override
  HomeNavTab build() => HomeNavTab.home;

  void selectTab(HomeNavTab tab) {
    state = tab;
  }
}

final homeNavProvider = NotifierProvider<HomeNavNotifier, HomeNavTab>(
  HomeNavNotifier.new,
);

