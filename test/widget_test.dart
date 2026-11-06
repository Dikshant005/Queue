import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flowguard/constant/text_constants.dart';
import 'package:flowguard/presentation/auth_screens/auth_screen.dart';
import 'package:flowguard/presentation/business_detail_screen/business_detail_screen.dart';
import 'package:flowguard/presentation/explore_screen/explore_screen.dart';
import 'package:flowguard/presentation/home_screen/home_screen.dart';
import 'package:flowguard/presentation/onboarding_screens/onboarding_screen.dart';
import 'package:flowguard/presentation/splash_screen/providers/splash_provider.dart';
import 'package:flowguard/presentation/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('SplashScreen displays FlowGuard branding and tagline',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          splashLoadingProvider.overrideWith((ref) async => true),
        ],
        child: const MaterialApp(
          home: SplashScreen(),
        ),
      ),
    );
    await tester.pump();

    // Verify brand title and tagline on Splash Screen
    expect(find.text(TextConstants.appName), findsOneWidget);
    expect(find.text(TextConstants.appTagline), findsOneWidget);
  });

  testWidgets(
      'OnboardingScreen displays 3-step flow and navigates to AuthScreen',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: OnboardingScreen(),
        ),
      ),
    );
    await tester.pump();

    // Screen 1: Welcome with Get Started ->
    expect(find.text(TextConstants.getStartedWithArrow), findsOneWidget);

    // Tap "Get Started ->" to advance to Screen 2
    await tester.tap(find.text(TextConstants.getStartedWithArrow));
    await tester.pumpAndSettle();

    // Screen 2: Join Queues Digitally
    expect(find.text(TextConstants.joinQueuesTitle), findsOneWidget);
    expect(find.text(TextConstants.nextWithArrow), findsOneWidget);

    // Tap "Next ->" to advance to Screen 3
    await tester.tap(find.text(TextConstants.nextWithArrow));
    await tester.pumpAndSettle();

    // Screen 3: Get Notified Instantly
    expect(find.text(TextConstants.getNotifiedTitle), findsOneWidget);
    expect(find.text(TextConstants.getStarted), findsOneWidget);

    // Tap "Get Started" to complete onboarding and enter AuthScreen
    await tester.tap(find.text(TextConstants.getStarted));
    await tester.pumpAndSettle();

    // Verify AuthScreen is loaded
    expect(find.text(TextConstants.welcomeBack), findsOneWidget);
    expect(find.text(TextConstants.loginTab), findsOneWidget);
    expect(find.text(TextConstants.signUpTab), findsOneWidget);
  });

  testWidgets(
      'AuthScreen allows guest login bypass directly to HomeScreen',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: AuthScreen(),
        ),
      ),
    );
    await tester.pump();

    // Verify guest button exists, scroll into view, and tap it
    expect(find.text(TextConstants.continueAsGuest), findsOneWidget);
    await tester.ensureVisible(find.text(TextConstants.continueAsGuest));
    await tester.pumpAndSettle();
    await tester.tap(find.text(TextConstants.continueAsGuest));
    await tester.pumpAndSettle();

    // Verify HomeScreen elements loaded
    expect(find.text(TextConstants.defaultLocation), findsOneWidget);
    expect(find.text(TextConstants.greetingEvening), findsOneWidget);
    expect(find.text(TextConstants.nearbyBusinesses), findsOneWidget);
    expect(find.text(TextConstants.yourActiveToken), findsOneWidget);
  });

  testWidgets('HomeScreen renders all sections and bottom navigation bar',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: HomeScreen(),
        ),
      ),
    );
    await tester.pump();

    // 1. Header & Location
    expect(find.text(TextConstants.defaultLocation), findsOneWidget);

    // 2. Greeting
    expect(find.text(TextConstants.greetingEvening), findsOneWidget);
    expect(find.text(TextConstants.greetingSubtitle), findsOneWidget);

    // 3. Search
    expect(find.text(TextConstants.searchBusinessesHint), findsWidgets);

    // 4. Categories
    expect(find.text(TextConstants.categoryClinics), findsWidgets);
    expect(find.text(TextConstants.categorySalons), findsWidgets);
    expect(find.text(TextConstants.categoryLabs), findsWidgets);
    expect(find.text(TextConstants.categoryDining), findsWidgets);
    expect(find.text(TextConstants.categoryMore), findsOneWidget);

    // 5. Nearby Businesses
    expect(find.text(TextConstants.nearbyBusinesses), findsOneWidget);
    expect(find.text(TextConstants.sampleBusinessName), findsWidgets);
    expect(find.text(TextConstants.openStatus), findsOneWidget);

    // 6. Active Token Card
    expect(find.text(TextConstants.yourActiveToken), findsOneWidget);
    expect(find.text(TextConstants.activeTokenNumber), findsOneWidget);

    // 7. Upcoming Appointment Card
    expect(find.text(TextConstants.upcomingAppointment), findsOneWidget);

    // 8. Bottom Navigation Bar Tabs
    expect(find.text(TextConstants.navHome), findsOneWidget);
    expect(find.text(TextConstants.navExplore), findsOneWidget);
    expect(find.text(TextConstants.navActivity), findsOneWidget);
    expect(find.text(TextConstants.navProfile), findsOneWidget);
  });

  testWidgets(
      'ExploreScreen renders single item and navigates to BusinessDetailScreen',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: Scaffold(body: ExploreScreen()),
        ),
      ),
    );
    await tester.pump();

    // Verify search bar and filter button exist
    expect(find.text(TextConstants.searchBusinessesHint), findsOneWidget);
    expect(find.byIcon(Icons.tune_rounded), findsOneWidget);

    // Verify NO back button exists
    expect(find.byIcon(Icons.arrow_back), findsNothing);
    expect(find.byIcon(Icons.arrow_back_ios), findsNothing);

    // Verify category chips exist
    expect(find.text(TextConstants.categoryAll), findsOneWidget);
    expect(find.text(TextConstants.categoryClinics), findsOneWidget);

    // Verify single item is present
    expect(find.text(TextConstants.sampleBusinessName), findsOneWidget);

    // Tap on the item to navigate to BusinessDetailScreen
    await tester.tap(find.text(TextConstants.sampleBusinessName));
    await tester.pumpAndSettle();

    // Verify BusinessDetailScreen loaded
    expect(find.text(TextConstants.tabServices), findsOneWidget);
    expect(find.text(TextConstants.tabAbout), findsOneWidget);
    expect(find.text(TextConstants.tabReviews), findsOneWidget);
    expect(find.text(TextConstants.joinQueueButton), findsOneWidget);
    expect(find.text(TextConstants.bookAppointmentButton), findsOneWidget);
  });

  testWidgets('BusinessDetailScreen renders all sections and tabs',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: BusinessDetailScreen(),
        ),
      ),
    );
    await tester.pump();

    // Title and status
    expect(find.text(TextConstants.sampleBusinessName), findsOneWidget);
    expect(find.text(TextConstants.openStatus), findsOneWidget);

    // Services
    expect(find.text(TextConstants.serviceGeneralConsultation), findsOneWidget);
    expect(find.text(TextConstants.serviceDentalCheckup), findsOneWidget);
    expect(find.text(TextConstants.serviceSkinConsultation), findsOneWidget);
    expect(find.text(TextConstants.viewAllServices), findsOneWidget);

    // Bottom action buttons
    expect(find.text(TextConstants.joinQueueButton), findsOneWidget);
    expect(find.text(TextConstants.bookAppointmentButton), findsOneWidget);

    // Tap "Join Queue"
    await tester.tap(find.text(TextConstants.joinQueueButton));
    await tester.pump();
    expect(find.text('Joined queue! Generating live token...'), findsOneWidget);
  });
}
