import 'package:flutter/material.dart';
import '../../../constant/asset_constants.dart';
import '../../../constant/color_constants.dart';
import '../../../constant/dimen_constants.dart';
import '../../../constant/text_constants.dart';

class QueueStepView extends StatelessWidget {
  const QueueStepView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: DimenConstants.screenHorizontalPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: DimenConstants.spacingMedium),

          // Title
          const Text(
            TextConstants.joinQueuesTitle,
            style: TextStyle(
              fontSize: DimenConstants.fontSizeHeadline,
              fontWeight: FontWeight.w800,
              color: ColorConstants.textHeadline,
              height: 1.2,
            ),
          ),

          const SizedBox(height: DimenConstants.spacingSmall),

          // Subtitle
          const Text(
            TextConstants.joinQueuesSubtitle,
            style: TextStyle(
              fontSize: DimenConstants.fontSizeSubtitle,
              fontWeight: FontWeight.w400,
              color: ColorConstants.textBody,
              height: 1.4,
            ),
          ),

          const SizedBox(height: DimenConstants.spacingMedium),

          // Responsive illustration scaled via Expanded
          Expanded(
            child: Center(
              child: Image.asset(
                AssetConstants.queueIllustration,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    decoration: BoxDecoration(
                      color: ColorConstants.lightBlueBackground,
                      borderRadius: BorderRadius.circular(DimenConstants.radiusLarge),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.phone_iphone_rounded,
                        size: 80,
                        color: ColorConstants.primaryBlue,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: DimenConstants.spacingSmall),
        ],
      ),
    );
  }
}
