import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constant/asset_constants.dart';
import '../../../constant/color_constants.dart';
import '../../../constant/dimen_constants.dart';
import '../../notifications_screen/notifications_screen.dart';
import '../../select_location_screen/providers/location_provider.dart';
import '../../select_location_screen/select_location_screen.dart';

class HomeHeader extends ConsumerWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocation = ref.watch(locationProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Left: FlowGuard mini ribbon logo + Location dropdown
        InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const SelectLocationScreen(),
              ),
            );
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
                // Current Selected Location
                Text(
                  currentLocation,
                  style: const TextStyle(
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
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const NotificationsScreen(),
              ),
            );
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

