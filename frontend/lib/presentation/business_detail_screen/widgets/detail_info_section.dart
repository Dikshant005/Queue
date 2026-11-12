import 'package:flutter/material.dart';
import '../../../constant/color_constants.dart';
import '../../../constant/dimen_constants.dart';
import '../../../constant/text_constants.dart';

class DetailInfoSection extends StatelessWidget {
  final String title;
  final String rating;
  final String location;
  final String status;

  const DetailInfoSection({
    super.key,
    this.title = TextConstants.sampleBusinessName,
    this.rating = TextConstants.sampleBusinessRating,
    this.location = TextConstants.sampleBusinessDetailedLocation,
    this.status = TextConstants.openStatus,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Fetch real-time operating hours, live queue length, and GPS distance from backend
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Name & Open Badge Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: DimenConstants.fontSizeTitle,
                  fontWeight: FontWeight.w800,
                  color: ColorConstants.textHeadline,
                  letterSpacing: -0.3,
                ),
              ),
            ),
            const SizedBox(width: DimenConstants.spacingSmall),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: DimenConstants.spacingSmall + 2,
                vertical: 4.0,
              ),
              decoration: BoxDecoration(
                color: ColorConstants.statusOpenBg,
                borderRadius: BorderRadius.circular(DimenConstants.radiusSmall),
              ),
              child: Text(
                status,
                style: const TextStyle(
                  fontSize: DimenConstants.fontSizeSmall,
                  fontWeight: FontWeight.w700,
                  color: ColorConstants.statusOpenText,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: DimenConstants.spacingSmall),

        // Rating Row
        Row(
          children: [
            const Icon(
              Icons.star_rounded,
              size: 20,
              color: ColorConstants.starRatingYellow,
            ),
            const SizedBox(width: DimenConstants.spacingExtraSmall),
            Text(
              rating,
              style: const TextStyle(
                fontSize: DimenConstants.fontSizeBody,
                fontWeight: FontWeight.w600,
                color: ColorConstants.textHeadline,
              ),
            ),
          ],
        ),

        const SizedBox(height: DimenConstants.spacingSmall),

        // Location Row
        Row(
          children: [
            const Icon(
              Icons.location_on_outlined,
              size: 18,
              color: ColorConstants.textLight,
            ),
            const SizedBox(width: DimenConstants.spacingExtraSmall),
            Expanded(
              child: Text(
                location,
                style: const TextStyle(
                  fontSize: DimenConstants.fontSizeBody - 1,
                  fontWeight: FontWeight.w400,
                  color: ColorConstants.textBody,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

