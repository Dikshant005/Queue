import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../constant/color_constants.dart';
import '../../constant/dimen_constants.dart';
import '../activity_screen/activity_screen.dart';
import '../explore_screen/explore_screen.dart';
import 'providers/home_nav_provider.dart';
import 'widgets/active_token_card.dart';
import 'widgets/greeting_section.dart';
import 'widgets/home_bottom_nav_bar.dart';
import 'widgets/home_header.dart';
import 'widgets/home_search_bar.dart';
import 'widgets/nearby_business_card.dart';
import 'widgets/service_categories_row.dart';
import 'widgets/upcoming_appointment_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTab = ref.watch(homeNavProvider);

    return Scaffold(
      backgroundColor: ColorConstants.scaffoldBackground,
      bottomNavigationBar: const HomeBottomNavBar(),
      body: IndexedStack(
        index: currentTab.index,
        children: const [
          // Tab 0: Home Content
          _HomeContentView(),

          // Tab 1: Explore Screen (Navigated via bottom nav)
          ExploreScreen(),

          // Tab 2: My Activity (My Appointments Screen)
          ActivityScreen(),

          // Tab 3: Profile Placeholder
          _PlaceholderView(
            title: 'Profile',
            // TODO: Connect User Profile / Account Settings screen
          ),
        ],
      ),
    );
  }
}

class _HomeContentView extends StatelessWidget {
  const _HomeContentView();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: DimenConstants.screenHorizontalPadding,
          vertical: DimenConstants.spacingSmall,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            // 1. Top Bar: Brand Logo, Location Dropdown & Notification Bell
            HomeHeader(),

            SizedBox(height: DimenConstants.spacingLarge - 4),

            // 2. Greeting Headline & Subtitle
            GreetingSection(),

            SizedBox(height: DimenConstants.spacingLarge),

            // 3. Search Bar Input
            HomeSearchBar(),

            SizedBox(height: DimenConstants.spacingLarge + 2),

            // 4. Quick Service Categories Row
            ServiceCategoriesRow(),

            SizedBox(height: DimenConstants.spacingLarge + 4),

            // 5. Nearby Businesses Showcase
            NearbyBusinessCard(),

            SizedBox(height: DimenConstants.spacingLarge),

            // 6. Active Live Queue Token Card
            ActiveTokenCard(),

            SizedBox(height: DimenConstants.spacingMedium),

            // 7. Upcoming Appointment Card
            UpcomingAppointmentCard(),

            SizedBox(height: DimenConstants.spacingLarge),
          ],
        ),
      ),
    );
  }
}

class _PlaceholderView extends StatelessWidget {
  final String title;

  const _PlaceholderView({required this.title});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            fontSize: DimenConstants.fontSizeHeadline,
            fontWeight: FontWeight.w700,
            color: ColorConstants.textHeadline,
          ),
        ),
      ),
    );
  }
}
