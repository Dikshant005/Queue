import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AuthTab {
  login,
  signUp;

  bool get isLogin => this == AuthTab.login;
  bool get isSignUp => this == AuthTab.signUp;
}

class AuthNotifier extends Notifier<AuthTab> {
  @override
  AuthTab build() => AuthTab.login;

  void selectTab(AuthTab tab) {
    state = tab;
  }
}

final authTabProvider = NotifierProvider<AuthNotifier, AuthTab>(
  AuthNotifier.new,
);

