import 'package:flutter/material.dart';
import '../../../constant/asset_constants.dart';
import '../../../constant/color_constants.dart';
import '../../../constant/dimen_constants.dart';
import '../../../constant/text_constants.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Left: FlowGuard mini ribbon logo + Location dropdown
        InkWell(
          onTap: () {
            // TODO: Fetch user's current GPS location dynamically using Geolocator
            // TODO: Open Location Picker / City Selector modal sheet
          },
          borderRadius: BorderRadius.circular(DimenConstants.radiusSmall),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: DimenConstants.spacingExtraSmall,
              horizontal: DimenConstants.spacingExtraSmall,
            ),
            child: Row(
              children: [
                Image.asset(
                  AssetConstants.logo,
                  height: DimenConstants.homeHeaderLogoSize,
                  width: DimenConstants.homeHeaderLogoSize,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.waves_rounded,
                      size: DimenConstants.homeHeaderLogoSize,
                      color: ColorConstants.primaryBlue,
                    );
                  },
                ),
                const SizedBox(width: DimenConstants.spacingSmall),
                // Hardcoded location as requested with TODO for Geolocator
                const Text(
                  TextConstants.defaultLocation,
                  style: TextStyle(
                    fontSize: DimenConstants.fontSizeCardTitle,
                    fontWeight: FontWeight.w700,
                    color: ColorConstants.textHeadline,
                  ),
                ),
                const SizedBox(width: DimenConstants.spacingExtraSmall),
                const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 20,
                  color: ColorConstants.textHeadline,
                ),
              ],
            ),
          ),
        ),

        // Right: Notification Bell Action
        IconButton(
          onPressed: () {
            // TODO: Navigate to Notification Center screen
          },
          icon: const Icon(
            Icons.notifications_none_rounded,
            size: 26,
            color: ColorConstants.textHeadline,
          ),
          splashRadius: 24,
        ),
      ],
    );
  }
}

