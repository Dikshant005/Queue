import 'package:flutter/material.dart';
import '../../../constant/color_constants.dart';
import '../../../constant/dimen_constants.dart';

/// Reusable Business Card for the Explore Screen list
class ExploreBusinessCard extends StatelessWidget {
  final String title;
  final String rating;
  final String location;
  final String waitTime;
  final String? imageAsset;
  final VoidCallback? onTap;
  final VoidCallback? onBookmarkTap;
  final bool isBookmarked;

  const ExploreBusinessCard({
    super.key,
    required this.title,
    required this.rating,
    required this.location,
    required this.waitTime,
    this.imageAsset,
    this.onTap,
    this.onBookmarkTap,
    this.isBookmarked = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
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
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Business Thumbnail Photo
            ClipRRect(
              borderRadius:
                  BorderRadius.circular(DimenConstants.radiusMedium - 2),
              child: Container(
                width: 95,
                height: 90,
                color: ColorConstants.lightBlueBackground,
                child: imageAsset != null
                    ? Image.asset(
                        imageAsset!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Icon(
                              Icons.storefront_rounded,
                              size: 36,
                              color: ColorConstants.textLight,
                            ),
                          );
                        },
                      )
                    : const Center(
                        child: Icon(
                          Icons.storefront_rounded,
                          size: 36,
                          color: ColorConstants.textLight,
                        ),
                      ),
              ),
            ),

            const SizedBox(width: DimenConstants.spacingMedium),

            // Info Column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: DimenConstants.fontSizeSubtitle,
                      fontWeight: FontWeight.w800,
                      color: ColorConstants.textHeadline,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: DimenConstants.spacingExtraSmall),

                  // Rating Row
                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        size: 16,
                        color: ColorConstants.starRatingYellow,
                      ),
                      const SizedBox(width: DimenConstants.spacingExtraSmall),
                      Text(
                        rating,
                        style: const TextStyle(
                          fontSize: DimenConstants.fontSizeTerms,
                          fontWeight: FontWeight.w500,
                          color: ColorConstants.textBody,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: DimenConstants.spacingExtraSmall),

                  // Location Row
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 14,
                        color: ColorConstants.textLight,
                      ),
                      const SizedBox(width: DimenConstants.spacingExtraSmall),
                      Text(
                        location,
                        style: const TextStyle(
                          fontSize: DimenConstants.fontSizeTerms,
                          fontWeight: FontWeight.w500,
                          color: ColorConstants.textBody,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: DimenConstants.spacingSmall - 2),

                  // Wait Time Chip
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
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.access_time_rounded,
                          size: 13,
                          color: ColorConstants.waitChipText,
                        ),
                        const SizedBox(width: DimenConstants.spacingExtraSmall),
                        Text(
                          waitTime,
                          style: const TextStyle(
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

            // Bookmark / Save Action
            IconButton(
              onPressed: onBookmarkTap,
              icon: Icon(
                isBookmarked
                    ? Icons.bookmark_rounded
                    : Icons.bookmark_border_rounded,
                size: 22,
                color: isBookmarked
                    ? ColorConstants.primaryBlue
                    : ColorConstants.textLight,
              ),
              splashRadius: 20,
            ),
          ],
        ),
      ),
    );
  }
}

