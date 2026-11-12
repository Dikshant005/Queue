import 'package:flutter/material.dart';
import '../../../constant/color_constants.dart';
import '../../../constant/text_constants.dart';

enum SortOption {
  recommended,
  distance,
  rating,
  priceLowToHigh;

  String get label {
    switch (this) {
      case SortOption.recommended:
        return TextConstants.sortRecommended;
      case SortOption.distance:
        return TextConstants.sortDistance;
      case SortOption.rating:
        return TextConstants.sortRating;
      case SortOption.priceLowToHigh:
        return TextConstants.sortPriceLowHigh;
    }
  }
}

class ExploreFilterSheet extends StatefulWidget {
  const ExploreFilterSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const ExploreFilterSheet(),
    );
  }

  @override
  State<ExploreFilterSheet> createState() => _ExploreFilterSheetState();
}

class _ExploreFilterSheetState extends State<ExploreFilterSheet> {
  SortOption _selectedSort = SortOption.recommended;
  final Set<String> _selectedRatings = {'4.5+'};

  final List<String> _ratingOptions = const [
    TextConstants.rating45Plus,
    TextConstants.rating40Plus,
    TextConstants.rating35Plus,
  ];

  void _clearFilters() {
    setState(() {
      _selectedSort = SortOption.recommended;
      _selectedRatings.clear();
    });
  }

  void _applyFilters() {
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Filters applied!'),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 1),
      ),
    );
    // TODO: Connect filters state to ExploreProvider to sort and filter business results
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      padding: const EdgeInsets.only(left: 24, right: 24, top: 12, bottom: 24),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drag Handle Pill
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFE2E8F0),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Sheet Title
            const Text(
              TextConstants.filtersTitle,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: ColorConstants.textHeadline,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 20),

            // "Sort By" Header
            const Text(
              TextConstants.sortByTitle,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: ColorConstants.textHeadline,
              ),
            ),
            const SizedBox(height: 12),

            // Sort Options List
            Column(
              children: SortOption.values.map((option) {
                final isSelected = option == _selectedSort;

                return InkWell(
                  onTap: () {
                    setState(() => _selectedSort = option);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        // Radio circle
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected
                                  ? ColorConstants.primaryBlue
                                  : const Color(0xFFCBD5E1),
                              width: 1.8,
                            ),
                          ),
                          child: isSelected
                              ? Center(
                                  child: Container(
                                    width: 10,
                                    height: 10,
                                    decoration: const BoxDecoration(
                                      color: ColorConstants.primaryBlue,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                )
                              : null,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          option.label,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w500,
                            color: isSelected
                                ? ColorConstants.primaryBlue
                                : ColorConstants.textHeadline,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            // "Ratings" Header
            const Text(
              TextConstants.ratingsTitle,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: ColorConstants.textHeadline,
              ),
            ),
            const SizedBox(height: 12),

            // Ratings Checkbox List
            Column(
              children: _ratingOptions.map((rating) {
                final isChecked = _selectedRatings.contains(rating);

                return InkWell(
                  onTap: () {
                    setState(() {
                      if (isChecked) {
                        _selectedRatings.remove(rating);
                      } else {
                        _selectedRatings.add(rating);
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          color: ColorConstants.starRatingYellow,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          rating,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: ColorConstants.textHeadline,
                          ),
                        ),
                        const Spacer(),

                        // Checkbox
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: isChecked
                                ? ColorConstants.primaryBlue
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: isChecked
                                  ? ColorConstants.primaryBlue
                                  : const Color(0xFFCBD5E1),
                              width: 1.5,
                            ),
                          ),
                          child: isChecked
                              ? const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 14,
                                )
                              : null,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // Bottom Actions: Clear & Apply
            Row(
              children: [
                TextButton(
                  onPressed: _clearFilters,
                  child: const Text(
                    TextConstants.clearButton,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: ColorConstants.primaryBlue,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _applyFilters,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0B132B),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: const Text(
                        TextConstants.applyButton,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

