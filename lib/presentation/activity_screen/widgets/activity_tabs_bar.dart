import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constant/color_constants.dart';
import '../../../constant/text_constants.dart';
import '../providers/activity_provider.dart';

class ActivityTabsBar extends ConsumerWidget {
  const ActivityTabsBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTab = ref.watch(activityTabProvider);

    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFF1F5F9),
            width: 1.5,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            // "Upcoming" Tab
            _buildTab(
              context: context,
              ref: ref,
              label: TextConstants.tabUpcoming,
              tab: ActivityTab.upcoming,
              isSelected: currentTab.isUpcoming,
            ),
            const SizedBox(width: 32),

            // "Past" Tab
            _buildTab(
              context: context,
              ref: ref,
              label: TextConstants.tabPast,
              tab: ActivityTab.past,
              isSelected: currentTab.isPast,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab({
    required BuildContext context,
    required WidgetRef ref,
    required String label,
    required ActivityTab tab,
    required bool isSelected,
  }) {
    return InkWell(
      onTap: () {
        ref.read(activityTabProvider.notifier).selectTab(tab);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 15,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected
                    ? ColorConstants.primaryBlue
                    : ColorConstants.textBody,
              ),
            ),
          ),
          // Underline indicator
          Container(
            height: 2.5,
            width: 80,
            decoration: BoxDecoration(
              color: isSelected
                  ? ColorConstants.primaryBlue
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}

