import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constant/color_constants.dart';
import '../providers/notifications_provider.dart';

class NotificationFilterChips extends ConsumerWidget {
  const NotificationFilterChips({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilter = ref.watch(notificationFilterProvider);

    return SizedBox(
      height: 38,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: NotifFilter.values.length,
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final filter = NotifFilter.values[index];
          final isSelected = filter == activeFilter;

          return GestureDetector(
            onTap: () {
              ref.read(notificationFilterProvider.notifier).selectFilter(filter);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? ColorConstants.primaryBlue
                    : const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  filter.label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: isSelected
                        ? Colors.white
                        : ColorConstants.textHeadline.withValues(alpha: 0.8),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

