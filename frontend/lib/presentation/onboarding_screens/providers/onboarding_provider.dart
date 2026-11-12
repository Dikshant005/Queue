import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingState {
  final int currentPage;
  final int totalPages;

  const OnboardingState({
    this.currentPage = 0,
    this.totalPages = 2,
  });

  bool get isFirstPage => currentPage == 0;
  bool get isLastPage => currentPage == totalPages - 1;

  OnboardingState copyWith({
    int? currentPage,
    int? totalPages,
  }) {
    return OnboardingState(
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
    );
  }
}

class OnboardingNotifier extends Notifier<OnboardingState> {
  late final PageController pageController;

  @override
  OnboardingState build() {
    pageController = PageController();
    ref.onDispose(() {
      pageController.dispose();
    });
    return const OnboardingState();
  }

  void onPageChanged(int index) {
    state = state.copyWith(currentPage: index);
  }

  void nextPage() {
    if (state.currentPage < state.totalPages - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void skipToLast() {
    pageController.jumpToPage(state.totalPages - 1);
  }
}

final onboardingProvider =
    NotifierProvider<OnboardingNotifier, OnboardingState>(
  OnboardingNotifier.new,
);

