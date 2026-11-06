import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constant/text_constants.dart';

class ExploreCategoryNotifier extends Notifier<String> {
  @override
  String build() => TextConstants.categoryAll;

  void selectCategory(String category) {
    state = category;
    // TODO: Filter businesses list dynamically based on selected category: $category
  }
}

final exploreCategoryProvider =
    NotifierProvider<ExploreCategoryNotifier, String>(
  ExploreCategoryNotifier.new,
);

