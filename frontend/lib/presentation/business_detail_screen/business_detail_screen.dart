import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../constant/color_constants.dart';
import '../../constant/dimen_constants.dart';
import '../../constant/text_constants.dart';
import '../rate_review_screen/rate_review_screen.dart';
import 'providers/business_detail_provider.dart';
import 'widgets/detail_bottom_actions.dart';
import 'widgets/detail_header_image.dart';
import 'widgets/detail_info_section.dart';
import 'widgets/detail_tabs_bar.dart';
import 'widgets/services_list_view.dart';

class BusinessDetailScreen extends ConsumerWidget {
  final String? title;
  final String? rating;
  final String? location;
  final String? imageAsset;

  const BusinessDetailScreen({
    super.key,
    this.title,
    this.rating,
    this.location,
    this.imageAsset,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTab = ref.watch(businessDetailTabProvider);

    return Scaffold(
      backgroundColor: ColorConstants.scaffoldBackground,
      bottomNavigationBar: const DetailBottomActions(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Top Image Banner with Floating Back, Favorite & Share Buttons
            DetailHeaderImage(imageAsset: imageAsset),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DimenConstants.screenHorizontalPadding,
                vertical: DimenConstants.spacingMedium,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 2. Business Title, Open Status Badge, Rating & Location
                  DetailInfoSection(
                    title: title ?? 'Northside Family Clinic',
                    rating: rating ?? '4.8 (2.4k reviews)',
                    location: location ?? '1.2 km • Sector 14, Saharanpur',
                  ),

                  const SizedBox(height: DimenConstants.spacingLarge),

                  // 3. Segmented Tabs Bar: Services | About | Reviews
                  const DetailTabsBar(),

                  const SizedBox(height: DimenConstants.spacingLarge - 4),

                  // 4. Tab Content (Services list by default)
                  if (currentTab.isServices) const ServicesListView(),

                  if (currentTab.isAbout)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24.0),
                      child: Center(
                        child: Text(
                          'Clinic details, doctor profiles & facilities',
                          style: TextStyle(
                            fontSize: DimenConstants.fontSizeBody,
                            color: ColorConstants.textBody,
                          ),
                        ),
                      ),
                      // TODO: Display clinic about details, doctor profiles, and facilities
                    ),

                  if (currentTab.isReviews)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Column(
                        children: [
                          const Center(
                            child: Text(
                              'Customer reviews & ratings breakdown',
                              style: TextStyle(
                                fontSize: DimenConstants.fontSizeBody,
                                color: ColorConstants.textBody,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Center(
                            child: OutlinedButton.icon(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => RateReviewScreen(
                                      clinicName: title ??
                                          TextConstants.sampleBusinessName,
                                      rating: rating ??
                                          TextConstants.sampleBusinessRating,
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.rate_review_outlined,
                                color: ColorConstants.primaryBlue,
                                size: 18,
                              ),
                              label: const Text(
                                'Write a Review',
                                style: TextStyle(
                                  color: ColorConstants.primaryBlue,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  color: ColorConstants.primaryBlue,
                                  width: 1.5,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  const SizedBox(height: DimenConstants.spacingLarge),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

