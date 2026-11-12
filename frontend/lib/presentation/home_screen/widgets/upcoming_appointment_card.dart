import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constant/color_constants.dart';
import '../../../constant/dimen_constants.dart';
import '../../../constant/text_constants.dart';
import '../providers/home_nav_provider.dart';

class UpcomingAppointmentCard extends ConsumerWidget {
  const UpcomingAppointmentCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: Fetch user's scheduled appointments from appointment booking service
    return InkWell(
      onTap: () {
        ref.read(homeNavProvider.notifier).selectTab(HomeNavTab.activity);
      },
      borderRadius: BorderRadius.circular(DimenConstants.radiusCard),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: DimenConstants.spacingMedium,
          vertical: DimenConstants.spacingMedium - 2,
        ),
        decoration: BoxDecoration(
          color: ColorConstants.cardBackground,
          borderRadius: BorderRadius.circular(DimenConstants.radiusCard),
          border: Border.all(
            color: ColorConstants.subtleBorder,
            width: 1.1,
          ),
          boxShadow: const [
            BoxShadow(
              color: ColorConstants.shadowColor,
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            // Calendar Icon Container
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: ColorConstants.inputBackground,
                borderRadius: BorderRadius.circular(DimenConstants.radiusMedium - 4),
                border: Border.all(
                  color: ColorConstants.inputBorder.withValues(alpha: 0.6),
                  width: 1.0,
                ),
              ),
              child: const Icon(
                Icons.calendar_month_outlined,
                size: 22,
                color: ColorConstants.textHeadline,
              ),
            ),

            const SizedBox(width: DimenConstants.spacingMedium),

            // Appointment Info Column
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    TextConstants.upcomingAppointment,
                    style: TextStyle(
                      fontSize: DimenConstants.fontSizeBody,
                      fontWeight: FontWeight.w700,
                      color: ColorConstants.textHeadline,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    TextConstants.sampleAppointmentDetail,
                    style: TextStyle(
                      fontSize: DimenConstants.fontSizeSmall,
                      fontWeight: FontWeight.w400,
                      color: ColorConstants.textBody,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Chevron Indicator
            const Icon(
              Icons.chevron_right_rounded,
              size: 22,
              color: ColorConstants.textLight,
            ),
          ],
        ),
      ),
    );
  }
}

