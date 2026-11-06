import 'package:flutter/material.dart';
import '../../../constant/color_constants.dart';
import '../../../constant/dimen_constants.dart';
import '../../../constant/text_constants.dart';

class ServiceItemData {
  final String title;
  final String details;
  final IconData icon;

  const ServiceItemData({
    required this.title,
    required this.details,
    required this.icon,
  });
}

class ServicesListView extends StatelessWidget {
  const ServicesListView({super.key});

  static const List<ServiceItemData> services = [
    ServiceItemData(
      title: TextConstants.serviceGeneralConsultation,
      details: TextConstants.priceGeneralConsultation,
      icon: Icons.schedule_rounded,
    ),
    ServiceItemData(
      title: TextConstants.serviceDentalCheckup,
      details: TextConstants.priceDentalCheckup,
      icon: Icons.health_and_safety_outlined,
    ),
    ServiceItemData(
      title: TextConstants.serviceSkinConsultation,
      details: TextConstants.priceSkinConsultation,
      icon: Icons.person_outline_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: Fetch business services list dynamically from backend catalog API
    return Column(
      children: [
        ...services.map((item) {
          return Padding(
            padding: const EdgeInsets.only(bottom: DimenConstants.spacingMedium - 2),
            child: InkWell(
              onTap: () {
                // TODO: Select service for booking / queue entry: ${item.title}
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
                ),
                child: Row(
                  children: [
                    // Service Icon Box
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: ColorConstants.inputBackground,
                        borderRadius: BorderRadius.circular(
                          DimenConstants.radiusMedium - 2,
                        ),
                      ),
                      child: Icon(
                        item.icon,
                        size: 22,
                        color: ColorConstants.textHeadline,
                      ),
                    ),

                    const SizedBox(width: DimenConstants.spacingMedium),

                    // Service Title & Price/Duration
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title,
                            style: const TextStyle(
                              fontSize: DimenConstants.fontSizeSubtitle - 1,
                              fontWeight: FontWeight.w700,
                              color: ColorConstants.textHeadline,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            item.details,
                            style: const TextStyle(
                              fontSize: DimenConstants.fontSizeSmall,
                              fontWeight: FontWeight.w500,
                              color: ColorConstants.textBody,
                            ),
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
            ),
          );
        }),

        const SizedBox(height: DimenConstants.spacingSmall),

        // "View all services →"
        Center(
          child: TextButton(
            onPressed: () {
              // TODO: Open modal sheet with full services catalog
            },
            style: TextButton.styleFrom(
              foregroundColor: ColorConstants.primaryBlue,
            ),
            child: const Text(
              TextConstants.viewAllServices,
              style: TextStyle(
                fontSize: DimenConstants.fontSizeBody,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

