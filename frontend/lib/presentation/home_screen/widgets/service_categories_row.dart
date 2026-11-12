import 'package:flutter/material.dart';
import '../../../constant/color_constants.dart';
import '../../../constant/dimen_constants.dart';
import '../../../constant/text_constants.dart';

class ServiceCategoryItem {
  final String label;
  final IconData icon;

  const ServiceCategoryItem({
    required this.label,
    required this.icon,
  });
}

class ServiceCategoriesRow extends StatelessWidget {
  const ServiceCategoriesRow({super.key});

  static const List<ServiceCategoryItem> categories = [
    ServiceCategoryItem(
      label: TextConstants.categoryClinics,
      icon: Icons.medical_services_outlined,
    ),
    ServiceCategoryItem(
      label: TextConstants.categorySalons,
      icon: Icons.content_cut_rounded,
    ),
    ServiceCategoryItem(
      label: TextConstants.categoryLabs,
      icon: Icons.science_outlined,
    ),
    ServiceCategoryItem(
      label: TextConstants.categoryDining,
      icon: Icons.restaurant_rounded,
    ),
    ServiceCategoryItem(
      label: TextConstants.categoryMore,
      icon: Icons.grid_view_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: Fetch available service categories dynamically from backend API
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: categories.map((cat) {
        return InkWell(
          onTap: () {
            // TODO: Navigate to category service listings screen for: ${cat.label}
          },
          borderRadius: BorderRadius.circular(DimenConstants.radiusMedium),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: DimenConstants.categoryCardSize,
                height: DimenConstants.categoryCardSize,
                decoration: BoxDecoration(
                  color: ColorConstants.categoryCardBg,
                  borderRadius: BorderRadius.circular(DimenConstants.radiusCard),
                  border: Border.all(
                    color: ColorConstants.curvedWaveLine.withValues(alpha: 0.5),
                    width: 1.0,
                  ),
                ),
                child: Icon(
                  cat.icon,
                  size: DimenConstants.categoryIconSize,
                  color: ColorConstants.primaryBlue,
                ),
              ),
              const SizedBox(height: DimenConstants.spacingSmall),
              Text(
                cat.label,
                style: const TextStyle(
                  fontSize: DimenConstants.fontSizeSmall,
                  fontWeight: FontWeight.w600,
                  color: ColorConstants.textHeadline,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

