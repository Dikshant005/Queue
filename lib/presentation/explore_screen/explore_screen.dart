import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../constant/color_constants.dart';
import '../../constant/dimen_constants.dart';
import 'widgets/category_filter_chips.dart';
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
            children: const [
              // 1. Search Bar & Filter Action Button (No back button as requested)
              ExploreTopBar(),

              SizedBox(height: DimenConstants.spacingMedium),

              // 2. Category Filter Pills Row (All, Clinics, Salons, Labs, Dining)
              CategoryFilterChips(),

              SizedBox(height: DimenConstants.spacingMedium),

              // 3. Businesses Content Area (Left blank for backend integration)
              Expanded(
                child: SizedBox.expand(
                  // TODO: Fetch businesses dynamically from backend API based on coordinates
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

