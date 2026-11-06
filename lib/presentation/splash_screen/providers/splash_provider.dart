import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider handling the splash screen display duration before navigating
final splashLoadingProvider = FutureProvider.autoDispose<bool>((ref) async {
  await Future.delayed(const Duration(milliseconds: 2800));
  return true;
});

