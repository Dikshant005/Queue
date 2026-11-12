import 'package:flutter_riverpod/flutter_riverpod.dart';

class QueueTrackerState {
  final String tokenNumber;
  final String waitTime;
  final int peopleAhead;
  final int currentStep; // 0: Joined, 1: In Queue, 2: Next
  final bool isRefreshing;

  const QueueTrackerState({
    this.tokenNumber = 'A-024',
    this.waitTime = '12 min',
    this.peopleAhead = 3,
    this.currentStep = 1,
    this.isRefreshing = false,
  });

  QueueTrackerState copyWith({
    String? tokenNumber,
    String? waitTime,
    int? peopleAhead,
    int? currentStep,
    bool? isRefreshing,
  }) {
    return QueueTrackerState(
      tokenNumber: tokenNumber ?? this.tokenNumber,
      waitTime: waitTime ?? this.waitTime,
      peopleAhead: peopleAhead ?? this.peopleAhead,
      currentStep: currentStep ?? this.currentStep,
      isRefreshing: isRefreshing ?? this.isRefreshing,
    );
  }
}

class QueueTrackerNotifier extends Notifier<QueueTrackerState> {
  @override
  QueueTrackerState build() => const QueueTrackerState();

  Future<void> refresh() async {
    state = state.copyWith(isRefreshing: true);
    // TODO: Connect to backend Queue API / WebSocket to sync real-time position
    await Future.delayed(const Duration(milliseconds: 600));
    state = state.copyWith(isRefreshing: false);
  }

  void cancelToken() {
    // TODO: Send queue leave/cancel request to backend API
  }
}

final queueTrackerProvider =
    NotifierProvider<QueueTrackerNotifier, QueueTrackerState>(
  QueueTrackerNotifier.new,
);

