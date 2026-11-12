import 'package:flutter/material.dart';
import '../../../constant/asset_constants.dart';
import '../../../constant/color_constants.dart';
import '../../../constant/dimen_constants.dart';
import '../../../constant/text_constants.dart';

class WelcomeStepView extends StatelessWidget {
  const WelcomeStepView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: DimenConstants.spacingExtraLarge),

        // FlowGuard Logo
        Center(
          child: Image.asset(
            AssetConstants.logo,
            height: DimenConstants.logoSize,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(
                Icons.waves_rounded,
                size: DimenConstants.logoSize,
                color: ColorConstants.primaryBlue,
              );
            },
          ),
        ),

        const SizedBox(height: DimenConstants.spacingMedium),

        // Brand Name
        const Text(
          TextConstants.appName,
          style: TextStyle(
            fontSize: DimenConstants.fontSizeHeadline,
            fontWeight: FontWeight.w900,
            letterSpacing: 2.0,
            color: ColorConstants.textHeadline,
          ),
        ),

        const SizedBox(height: DimenConstants.spacingSmall),

        // Tagline
        const Text(
          TextConstants.appTagline,
          style: TextStyle(
            fontSize: DimenConstants.fontSizeBody,
            fontWeight: FontWeight.w400,
            color: ColorConstants.textBody,
            letterSpacing: 0.3,
          ),
        ),

        const SizedBox(height: DimenConstants.spacingLarge),

        // Modern Reception Lobby Image with curved clipping
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(DimenConstants.radiusImageTop),
                topRight: Radius.circular(DimenConstants.radiusImageTop),
              ),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: ColorConstants.lightBlueBackground,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(DimenConstants.radiusImageTop),
                    topRight: Radius.circular(DimenConstants.radiusImageTop),
                  ),
                ),
                child: Image.asset(
                  AssetConstants.lobbyReception,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(
                        Icons.apartment_rounded,
                        size: 80,
                        color: ColorConstants.textLight,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

