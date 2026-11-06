import 'package:flutter/material.dart';
import '../../../constant/asset_constants.dart';
import '../../../constant/color_constants.dart';
import '../../../constant/text_constants.dart';
import '../../business_detail_screen/business_detail_screen.dart';

class QueueBusinessCard extends StatelessWidget {
  const QueueBusinessCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to Business Detail Screen
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const BusinessDetailScreen(),
          ),
        );
        // TODO: Pass dynamic businessId when connected to backend API
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFFE2E8F0),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // Thumbnail Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                AssetConstants.lobbyReception,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 60,
                  height: 60,
                  color: ColorConstants.categoryCardBg,
                  child: const Icon(
                    Icons.local_hospital_rounded,
                    color: ColorConstants.primaryBlue,
                    size: 28,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),

            // Clinic Information
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    TextConstants.businessLabel,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: ColorConstants.textLight,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    TextConstants.sampleBusinessName,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: ColorConstants.textHeadline,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: const [
                      Icon(
                        Icons.location_on,
                        size: 14,
                        color: ColorConstants.textBody,
                      ),
                      SizedBox(width: 3),
                      Text(
                        '1.2 km',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: ColorConstants.textBody,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Chevron
            const Icon(
              Icons.chevron_right_rounded,
              color: ColorConstants.textLight,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}

