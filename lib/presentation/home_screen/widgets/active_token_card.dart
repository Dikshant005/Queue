import 'package:flutter/material.dart';
import '../../../constant/color_constants.dart';
import '../../../constant/dimen_constants.dart';
import '../../../constant/text_constants.dart';

class ActiveTokenCard extends StatelessWidget {
  const ActiveTokenCard({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Connect to WebSocket / polling service to stream live queue updates
    return InkWell(
      onTap: () {
        // TODO: Navigate to Live Queue Tracker & Token Details screen
      },
      borderRadius: BorderRadius.circular(DimenConstants.radiusLarge),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: DimenConstants.spacingMedium + 2,
          vertical: DimenConstants.spacingMedium,
        ),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              ColorConstants.tokenCardStart,
              ColorConstants.tokenCardEnd,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(DimenConstants.radiusLarge),
          boxShadow: [
            BoxShadow(
              color: ColorConstants.tokenCardStart.withValues(alpha: 0.35),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            // Glowing Blue Ticket Badge
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: ColorConstants.primaryBlue,
                borderRadius: BorderRadius.circular(DimenConstants.radiusMedium - 2),
                boxShadow: [
                  BoxShadow(
                    color: ColorConstants.primaryBlue.withValues(alpha: 0.5),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.confirmation_number_rounded,
                size: 26,
                color: ColorConstants.textWhite,
              ),
            ),

            const SizedBox(width: DimenConstants.spacingMedium),

            // Token Info Column
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  TextConstants.yourActiveToken,
                  style: TextStyle(
                    fontSize: DimenConstants.fontSizeSmall - 1,
                    fontWeight: FontWeight.w500,
                    color: ColorConstants.textLight,
                    letterSpacing: 0.2,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  TextConstants.activeTokenNumber,
                  style: TextStyle(
                    fontSize: DimenConstants.fontSizeTokenNumber,
                    fontWeight: FontWeight.w900,
                    color: ColorConstants.textWhite,
                    letterSpacing: 0.8,
                  ),
                ),
              ],
            ),

            const Spacer(),

            // Estimated Wait Column
            const Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.schedule_rounded,
                      size: 15,
                      color: ColorConstants.textWhite,
                    ),
                    SizedBox(width: DimenConstants.spacingExtraSmall),
                    Text(
                      '${TextConstants.approxPrefix}${TextConstants.activeTokenWaitTime}',
                      style: TextStyle(
                        fontSize: DimenConstants.fontSizeSubtitle,
                        fontWeight: FontWeight.w800,
                        color: ColorConstants.textWhite,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2),
                Text(
                  TextConstants.estimatedWaitLabel,
                  style: TextStyle(
                    fontSize: DimenConstants.fontSizeMicro + 1,
                    fontWeight: FontWeight.w400,
                    color: ColorConstants.textLight,
                  ),
                ),
              ],
            ),

            const SizedBox(width: DimenConstants.spacingMedium - 2),

            // Circular Forward Arrow Button
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: ColorConstants.textWhite.withValues(alpha: 0.16),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_forward_rounded,
                size: 18,
                color: ColorConstants.textWhite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

