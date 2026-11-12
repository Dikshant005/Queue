import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constant/color_constants.dart';
import '../../../constant/dimen_constants.dart';
import '../../../constant/text_constants.dart';
import '../providers/business_detail_provider.dart';

class DetailTabsBar extends ConsumerWidget {
  const DetailTabsBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTab = ref.watch(businessDetailTabProvider);

    return Column(
      children: [
        Row(
          children: [
            _buildTabItem(
              ref: ref,
              label: TextConstants.tabServices,
              tab: BusinessDetailTab.services,
              isSelected: currentTab.isServices,
            ),
            _buildTabItem(
              ref: ref,
              label: TextConstants.tabAbout,
              tab: BusinessDetailTab.about,
              isSelected: currentTab.isAbout,
            ),
            _buildTabItem(
              ref: ref,
              label: TextConstants.tabReviews,
              tab: BusinessDetailTab.reviews,
              isSelected: currentTab.isReviews,
            ),
          ],
        ),

        // Bottom border line with moving active indicator
        Stack(
          children: [
            Container(
              height: 2.0,
              color: ColorConstants.subtleBorder,
            ),
            AnimatedAlign(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              alignment: _getAlignment(currentTab),
              child: FractionallySizedBox(
                widthFactor: 0.33,
                child: Container(
                  height: 2.5,
                  decoration: BoxDecoration(
                    color: ColorConstants.tabIndicatorColor,
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Alignment _getAlignment(BusinessDetailTab tab) {
    switch (tab) {
      case BusinessDetailTab.services:
        return Alignment.centerLeft;
      case BusinessDetailTab.about:
        return Alignment.center;
      case BusinessDetailTab.reviews:
        return Alignment.centerRight;
    }
  }

  Widget _buildTabItem({
    required WidgetRef ref,
    required String label,
    required BusinessDetailTab tab,
    required bool isSelected,
  }) {
    return Expanded(
      child: InkWell(
        onTap: () {
          ref.read(businessDetailTabProvider.notifier).selectTab(tab);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: DimenConstants.spacingSmall + 2,
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: DimenConstants.fontSizeSubtitle,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected
                    ? ColorConstants.primaryBlue
                    : ColorConstants.tabInactiveText,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
