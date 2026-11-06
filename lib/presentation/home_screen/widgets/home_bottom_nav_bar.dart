import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constant/color_constants.dart';
import '../../../constant/dimen_constants.dart';
import '../../../constant/text_constants.dart';
import '../providers/home_nav_provider.dart';

class HomeBottomNavBar extends ConsumerWidget {
  const HomeBottomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTab = ref.watch(homeNavProvider);

    return Container(
      decoration: BoxDecoration(
        color: ColorConstants.scaffoldBackground,
        border: const Border(
          top: BorderSide(
            color: ColorConstants.subtleBorder,
            width: 1.2,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: ColorConstants.shadowColor.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: DimenConstants.bottomNavHeight,
          child: Row(
            children: [
              _buildNavItem(
                ref: ref,
                tab: HomeNavTab.home,
                isSelected: currentTab.isHome,
                label: TextConstants.navHome,
                activeIcon: Icons.home_rounded,
                inactiveIcon: Icons.home_outlined,
              ),
              _buildNavItem(
                ref: ref,
                tab: HomeNavTab.explore,
                isSelected: currentTab.isExplore,
                label: TextConstants.navExplore,
                activeIcon: Icons.explore_rounded,
                inactiveIcon: Icons.explore_outlined,
              ),
              _buildNavItem(
                ref: ref,
                tab: HomeNavTab.activity,
                isSelected: currentTab.isActivity,
                label: TextConstants.navActivity,
                activeIcon: Icons.history_rounded,
                inactiveIcon: Icons.history_outlined,
              ),
              _buildNavItem(
                ref: ref,
                tab: HomeNavTab.profile,
                isSelected: currentTab.isProfile,
                label: TextConstants.navProfile,
                activeIcon: Icons.person_rounded,
                inactiveIcon: Icons.person_outline_rounded,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required WidgetRef ref,
    required HomeNavTab tab,
    required bool isSelected,
    required String label,
    required IconData activeIcon,
    required IconData inactiveIcon,
  }) {
    return Expanded(
      child: InkWell(
        onTap: () {
          ref.read(homeNavProvider.notifier).selectTab(tab);
          // TODO: Wire navigation transitions for Explore, My Activity, and Profile tabs
        },
        child: Column(
          children: [
            // Top Indicator Bar for Active Tab
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 2.5,
              width: isSelected ? 48 : 0,
              decoration: BoxDecoration(
                color: isSelected
                    ? ColorConstants.primaryBlue
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            const Spacer(),

            // Tab Icon
            Icon(
              isSelected ? activeIcon : inactiveIcon,
              size: 24,
              color: isSelected
                  ? ColorConstants.primaryBlue
                  : ColorConstants.textLight,
            ),

            const SizedBox(height: 3),

            // Tab Label
            Text(
              label,
              style: TextStyle(
                fontSize: DimenConstants.fontSizeMicro + 1,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected
                    ? ColorConstants.primaryBlue
                    : ColorConstants.textLight,
              ),
            ),

            const Spacer(),
          ],
        ),
      ),
    );
  }
}

