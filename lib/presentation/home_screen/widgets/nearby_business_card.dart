import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constant/asset_constants.dart';
import '../../../constant/color_constants.dart';
import '../../../constant/dimen_constants.dart';
import '../../../constant/text_constants.dart';
import '../providers/home_nav_provider.dart';

class NearbyBusinessCard extends ConsumerWidget {
  const NearbyBusinessCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        // Section Header Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              TextConstants.nearbyBusinesses,
              style: TextStyle(
                fontSize: DimenConstants.fontSizeHeadline - 8,
                fontWeight: FontWeight.w800,
                color: ColorConstants.textHeadline,
                letterSpacing: -0.2,
              ),
            ),
            TextButton(
              onPressed: () {
                // Switch to Explore tab in bottom navigation
                ref.read(homeNavProvider.notifier).selectTab(HomeNavTab.explore);
                // TODO: Navigate to full Nearby Businesses directory screen
              },
              style: TextButton.styleFrom(
                foregroundColor: ColorConstants.primaryBlue,
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text(
                TextConstants.seeAllWithArrow,
                style: TextStyle(
                  fontSize: DimenConstants.fontSizeBody,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: DimenConstants.spacingMedium),

        // Business Card
        // TODO: Fetch nearby businesses list from backend based on GPS coordinates
        InkWell(
          onTap: () {
            // TODO: Navigate to Business Details & Token Booking screen
          },
          borderRadius: BorderRadius.circular(DimenConstants.radiusCard),
          child: Container(
            padding: const EdgeInsets.all(DimenConstants.spacingSmall + 2),
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
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Business Thumbnail Photo
                ClipRRect(
                  borderRadius: BorderRadius.circular(DimenConstants.radiusMedium - 2),
                  child: Container(
                    width: DimenConstants.businessThumbnailWidth,
                    height: DimenConstants.businessThumbnailHeight,
                    color: ColorConstants.lightBlueBackground,
                    child: Image.asset(
                      AssetConstants.lobbyReception,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Icon(
                            Icons.storefront_rounded,
                            size: 40,
                            color: ColorConstants.textLight,
                          ),
                        );
                      },
                    ),
                  ),
                ),

                const SizedBox(width: DimenConstants.spacingMedium - 2),

                // Details Column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // "Open" Green Pill Badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: DimenConstants.spacingSmall,
                          vertical: 2.5,
                        ),
                        decoration: BoxDecoration(
                          color: ColorConstants.statusOpenBg,
                          borderRadius: BorderRadius.circular(
                            DimenConstants.radiusExtraSmall + 2,
                          ),
                        ),
                        child: const Text(
                          TextConstants.openStatus,
                          style: TextStyle(
                            fontSize: DimenConstants.fontSizeMicro + 1,
                            fontWeight: FontWeight.w700,
                            color: ColorConstants.statusOpenText,
                          ),
                        ),
                      ),

                      const SizedBox(height: DimenConstants.spacingExtraSmall),

                      // Business Name
                      const Text(
                        TextConstants.sampleBusinessName,
                        style: TextStyle(
                          fontSize: DimenConstants.fontSizeCardTitle - 1,
                          fontWeight: FontWeight.w800,
                          color: ColorConstants.textHeadline,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: DimenConstants.spacingExtraSmall),

                      // Rating Row
                      const Row(
                        children: [
                          Icon(
                            Icons.star_rounded,
                            size: 16,
                            color: ColorConstants.starRatingYellow,
                          ),
                          SizedBox(width: DimenConstants.spacingExtraSmall),
                          Text(
                            TextConstants.sampleBusinessRating,
                            style: TextStyle(
                              fontSize: DimenConstants.fontSizeTerms,
                              fontWeight: FontWeight.w500,
                              color: ColorConstants.textBody,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: DimenConstants.spacingExtraSmall),

                      // Distance & Location
                      const Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 14,
                            color: ColorConstants.locationPinOrange,
                          ),
                          SizedBox(width: DimenConstants.spacingExtraSmall),
                          Text(
                            TextConstants.sampleBusinessLocation,
                            style: TextStyle(
                              fontSize: DimenConstants.fontSizeTerms,
                              fontWeight: FontWeight.w500,
                              color: ColorConstants.textBody,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: DimenConstants.spacingSmall - 2),

                      // Estimated Wait Chip
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: DimenConstants.spacingSmall,
                          vertical: 3.0,
                        ),
                        decoration: BoxDecoration(
                          color: ColorConstants.waitChipBg,
                          borderRadius: BorderRadius.circular(
                            DimenConstants.radiusSmall,
                          ),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.access_time_rounded,
                              size: 13,
                              color: ColorConstants.waitChipText,
                            ),
                            SizedBox(width: DimenConstants.spacingExtraSmall),
                            Text(
                              TextConstants.sampleBusinessWaitTime,
                              style: TextStyle(
                                fontSize: DimenConstants.fontSizeMicro + 1,
                                fontWeight: FontWeight.w700,
                                color: ColorConstants.waitChipText,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Trailing Chevron Indicator
                const Icon(
                  Icons.chevron_right_rounded,
                  size: 22,
                  color: ColorConstants.textLight,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

