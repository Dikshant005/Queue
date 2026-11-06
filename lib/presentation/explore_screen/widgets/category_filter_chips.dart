import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constant/color_constants.dart';
import '../../../constant/dimen_constants.dart';
import '../../../constant/text_constants.dart';
import '../providers/explore_provider.dart';

class CategoryFilterChips extends ConsumerWidget {
  const CategoryFilterChips({super.key});

  static const List<String> categories = [
    TextConstants.categoryAll,
    TextConstants.categoryClinics,
    TextConstants.categorySalons,
    TextConstants.categoryLabs,
    TextConstants.categoryDining,
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(exploreCategoryProvider);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((cat) {
          final isSelected = cat == selectedCategory;

          return Padding(
            padding: const EdgeInsets.only(right: DimenConstants.spacingSmall + 2),
            child: InkWell(
              onTap: () {
                ref.read(exploreCategoryProvider.notifier).selectCategory(cat);
              },
              borderRadius: BorderRadius.circular(DimenConstants.radiusPill),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  horizontal: DimenConstants.spacingMedium + 2,
                  vertical: DimenConstants.spacingSmall,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? ColorConstants.primaryBlue
                      : ColorConstants.cardBackground,
                  borderRadius: BorderRadius.circular(DimenConstants.radiusPill),
                  border: Border.all(
                    color: isSelected
                        ? ColorConstants.primaryBlue
                        : ColorConstants.inputBorder.withValues(alpha: 0.8),
                    width: 1.1,
                  ),
                ),
                child: Text(
                  cat,
                  style: TextStyle(
                    fontSize: DimenConstants.fontSizeBody,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: isSelected
                        ? ColorConstants.textWhite
                        : ColorConstants.textBody,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

