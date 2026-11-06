import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../constant/asset_constants.dart';
import '../../constant/color_constants.dart';
import '../../constant/dimen_constants.dart';
import '../../constant/text_constants.dart';
import '../business_detail_screen/business_detail_screen.dart';
import 'widgets/category_filter_chips.dart';
import 'widgets/explore_business_card.dart';
import 'widgets/explore_top_bar.dart';

class ExploreScreen extends ConsumerWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: ColorConstants.scaffoldBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: DimenConstants.screenHorizontalPadding,
            vertical: DimenConstants.spacingSmall,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Search Bar & Filter Action Button (No back button as requested)
              const ExploreTopBar(),

              const SizedBox(height: DimenConstants.spacingMedium),

              // 2. Category Filter Pills Row (All, Clinics, Salons, Labs, Dining)
              const CategoryFilterChips(),

              const SizedBox(height: DimenConstants.spacingMedium),

              // 3. Featured Single Item (as shown in the reference design)
              ExploreBusinessCard(
                title: TextConstants.sampleBusinessName,
                rating: TextConstants.sampleBusinessRating,
                location: TextConstants.sampleBusinessLocation,
                waitTime: TextConstants.sampleBusinessWaitTime,
                imageAsset: AssetConstants.lobbyReception,
                onTap: () {
                  // Navigate to Business Detail Screen
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const BusinessDetailScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin = Offset(1.0, 0.0);
                        const end = Offset.zero;
                        const curve = Curves.easeInOutCubic;
                        final tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));
                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    ),
                  );
                },
                onBookmarkTap: () {
                  // TODO: Save business to user bookmarks
                },
              ),

              const SizedBox(height: DimenConstants.spacingMedium),

              // 4. Content Area for Remaining Dynamic List
              const Expanded(
                child: SizedBox.expand(
                  // TODO: Fetch businesses list dynamically from backend API based on coordinates
                  // TODO: Listen to exploreCategoryProvider to filter by active category
                  // TODO: Apply search query debouncing to filter results
                  // TODO: Render dynamic ListView.separated using ExploreBusinessCard
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
