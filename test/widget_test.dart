import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flowguard/constant/text_constants.dart';
import 'package:flowguard/presentation/activity_screen/activity_screen.dart';
import 'package:flowguard/presentation/appointment_cancelled_screen/appointment_cancelled_screen.dart';
import 'package:flowguard/presentation/appointment_details_screen/appointment_details_screen.dart';
import 'package:flowguard/presentation/cancel_appointment_screen/cancel_appointment_screen.dart';
import 'package:flowguard/presentation/create_support_ticket_screen/create_support_ticket_screen.dart';
import 'package:flowguard/presentation/help_support_screen/help_support_screen.dart';
import 'package:flowguard/presentation/notifications_screen/notifications_screen.dart';
import 'package:flowguard/presentation/profile_screen/profile_screen.dart';
import 'package:flowguard/presentation/rate_review_screen/rate_review_screen.dart';
import 'package:flowguard/presentation/reschedule_appointment_screen/reschedule_appointment_screen.dart';
import 'package:flowguard/presentation/ticket_details_screen/ticket_details_screen.dart';
import 'package:flowguard/presentation/queue_success_screen/queue_success_screen.dart';
import 'package:flowguard/presentation/auth_screens/auth_screen.dart';
import 'package:flowguard/presentation/auth_screens/otp_verification_screen/otp_verification_screen.dart';
import 'package:flowguard/presentation/select_services_screen/select_services_screen.dart';
import 'package:flowguard/presentation/location_permission_screen/location_permission_screen.dart';
import 'package:flowguard/presentation/select_location_screen/select_location_screen.dart';
import 'package:flowguard/presentation/business_detail_screen/business_detail_screen.dart';
import 'package:flowguard/presentation/cancellation_successful_screen/cancellation_successful_screen.dart';
import 'package:flowguard/presentation/edit_profile_screen/edit_profile_screen.dart';
import 'package:flowguard/presentation/explore_screen/explore_screen.dart';
import 'package:flowguard/presentation/favorites_screen/favorites_screen.dart';
import 'package:flowguard/presentation/home_screen/home_screen.dart';
import 'package:flowguard/presentation/no_internet_screen/no_internet_screen.dart';
import 'package:flowguard/presentation/onboarding_screens/onboarding_screen.dart';
import 'package:flowguard/presentation/queue_full_screen/queue_full_screen.dart';
import 'package:flowguard/presentation/queue_info_screen/queue_info_screen.dart';
import 'package:flowguard/presentation/queue_tracker_screen/queue_tracker_screen.dart';
import 'package:flowguard/presentation/select_branch_screen/select_branch_screen.dart';
import 'package:flowguard/presentation/settings_screen/settings_screen.dart';
import 'package:flowguard/presentation/splash_screen/providers/splash_provider.dart';
import 'package:flowguard/presentation/splash_screen/splash_screen.dart';
import 'package:flowguard/presentation/your_turn_screen/your_turn_screen.dart';
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
      'OnboardingScreen displays 2-step flow and navigates to AuthScreen',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: OnboardingScreen(),
        ),
      ),
    );
    await tester.pump();

    // Step 1: Skip the Queue, Save Your Time
    expect(find.text(TextConstants.onboardingStep1Title), findsOneWidget);
    expect(find.text(TextConstants.onboardingStep1Subtitle), findsOneWidget);
    expect(find.text(TextConstants.nextWithArrow), findsOneWidget);
    expect(find.text(TextConstants.skip), findsOneWidget);

    // Tap "Next →" to advance to Step 2
    await tester.tap(find.text(TextConstants.nextWithArrow));
    await tester.pumpAndSettle();

    // Step 2: Get Real-Time Updates
    expect(find.text(TextConstants.onboardingStep2Title), findsOneWidget);
    expect(find.text(TextConstants.onboardingStep2Subtitle), findsOneWidget);

    // Tap "Next →" to complete onboarding and enter AuthScreen
    await tester.tap(find.text(TextConstants.nextWithArrow));
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

    // Tap "Join Queue" to navigate to QueueSuccessScreen
    await tester.tap(find.text(TextConstants.joinQueueButton));
    await tester.pumpAndSettle();
    expect(find.text(TextConstants.queueJoinedTitle), findsOneWidget);
  });

  testWidgets('QueueTrackerScreen renders gauge, wait info, stepper, and actions',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: QueueTrackerScreen(),
        ),
      ),
    );
    await tester.pump();

    // 1. Header icons
    expect(find.byIcon(Icons.chevron_left_rounded), findsOneWidget);
    expect(find.byIcon(Icons.refresh_rounded), findsOneWidget);

    // 2. Token Gauge
    expect(find.text(TextConstants.yourToken), findsOneWidget);
    expect(find.text(TextConstants.activeTokenNumber), findsOneWidget);
    expect(find.text(TextConstants.waitingInLine), findsOneWidget);

    // 3. Wait Info
    expect(find.text('${TextConstants.approxPrefix}12 min'), findsOneWidget);
    expect(find.text(TextConstants.estimatedWaitLabel), findsOneWidget);
    expect(find.text('3 People Ahead'), findsOneWidget);

    // 4. Stepper Timeline
    expect(find.text(TextConstants.stepJoined), findsOneWidget);
    expect(find.text(TextConstants.stepInQueue), findsOneWidget);
    expect(find.text(TextConstants.stepNext), findsOneWidget);

    // 5. Business Card
    expect(find.text(TextConstants.businessLabel), findsOneWidget);
    expect(find.text(TextConstants.sampleBusinessName), findsOneWidget);

    // 6. Action buttons
    expect(find.text(TextConstants.directionsButton), findsOneWidget);
    expect(find.text(TextConstants.leaveQueueButton), findsOneWidget);

    // 7. Tap "Leave Queue" shows confirmation dialog
    await tester.ensureVisible(find.text(TextConstants.leaveQueueButton));
    await tester.tap(find.text(TextConstants.leaveQueueButton));
    await tester.pumpAndSettle();
    expect(find.text(TextConstants.cancelQueueTitle), findsOneWidget);
    expect(find.text(TextConstants.keepQueueButton), findsOneWidget);
  });

  testWidgets(
      'ActivityScreen renders appointments, tabs, and switches between Upcoming and Past',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: ActivityScreen(),
        ),
      ),
    );
    await tester.pump();

    // 1. Header
    expect(find.text(TextConstants.myAppointments), findsOneWidget);

    // 2. Tabs
    expect(find.text(TextConstants.tabUpcoming), findsOneWidget);
    expect(find.text(TextConstants.tabPast), findsOneWidget);

    // 3. Upcoming Appointment 1
    expect(find.text(TextConstants.dentalCareTitle), findsOneWidget);
    expect(find.text(TextConstants.sampleAppointmentDentalTime), findsOneWidget);
    expect(find.text(TextConstants.sampleBusinessName), findsOneWidget);

    // 4. Upcoming Appointment 2
    expect(find.text(TextConstants.generalCheckupTitle), findsOneWidget);
    expect(find.text(TextConstants.sampleAppointmentGeneralTime), findsOneWidget);
    expect(find.text(TextConstants.sampleClinicLifeCare), findsOneWidget);

    // 5. View Details Buttons
    expect(find.text(TextConstants.viewDetailsWithArrow), findsNWidgets(2));

    // 6. Switch to "Past" tab
    await tester.tap(find.text(TextConstants.tabPast));
    await tester.pumpAndSettle();

    // Verify empty state for past appointments
    expect(find.text(TextConstants.noAppointmentsTitle), findsOneWidget);
    expect(find.text(TextConstants.noAppointmentsSubtitle), findsOneWidget);
    expect(find.text(TextConstants.exploreClinicsButton), findsOneWidget);
    expect(find.text(TextConstants.dentalCareTitle), findsNothing);
  });

  testWidgets('ProfileScreen renders user info and all menu options',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: ProfileScreen(),
        ),
      ),
    );
    await tester.pump();

    // 1. Header & user info
    expect(find.text(TextConstants.profileTitle), findsOneWidget);
    expect(find.text(TextConstants.sampleUserName), findsOneWidget);
    expect(find.text(TextConstants.sampleUserEmail), findsOneWidget);

    // 2. Menu items
    expect(find.text(TextConstants.menuMyBookings), findsOneWidget);
    expect(find.text(TextConstants.menuMyQueueHistory), findsOneWidget);
    expect(find.text(TextConstants.menuWalletPayments), findsOneWidget);
    expect(find.text(TextConstants.menuAddresses), findsOneWidget);
    expect(find.text(TextConstants.menuNotifications), findsOneWidget);
    expect(find.text(TextConstants.menuHelpSupport), findsOneWidget);
    expect(find.text(TextConstants.menuAboutFlowguard), findsOneWidget);
  });

  testWidgets('NotificationsScreen renders filter chips and notifications',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: NotificationsScreen(),
        ),
      ),
    );
    await tester.pump();

    // 1. Title
    expect(find.text(TextConstants.notificationsTitle), findsOneWidget);

    // 2. Filter chips
    expect(find.text(TextConstants.notifFilterAll), findsOneWidget);
    expect(find.text(TextConstants.notifFilterUpdates), findsOneWidget);
    expect(find.text(TextConstants.notifFilterBookings), findsOneWidget);
    expect(find.text(TextConstants.notifFilterOffers), findsOneWidget);

    // 3. Notifications
    expect(find.text(TextConstants.notifTurnApproaching), findsOneWidget);
    expect(find.text(TextConstants.notifAppointmentConfirmed), findsOneWidget);
    expect(find.text(TextConstants.notifReferral), findsOneWidget);
    expect(find.text(TextConstants.notifClinicUpdate), findsOneWidget);
    expect(find.text(TextConstants.notifSpecialOffer), findsOneWidget);
  });

  testWidgets('QueueSuccessScreen renders checkmark, title, and buttons',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: QueueSuccessScreen(tokenNumber: 'A-024'),
        ),
      ),
    );
    await tester.pump();

    // 1. Checkmark icon
    expect(find.byIcon(Icons.check_rounded), findsOneWidget);

    // 2. Titles
    expect(find.text(TextConstants.queueJoinedTitle), findsOneWidget);
    expect(find.textContaining('Your token A-024 has been'), findsOneWidget);

    // 3. Action Buttons
    expect(find.text(TextConstants.trackQueueButton), findsOneWidget);
    expect(find.text(TextConstants.doneButton), findsOneWidget);

    // 4. Tap "Track Queue" replaces route to QueueTrackerScreen
    await tester.tap(find.text(TextConstants.trackQueueButton));
    await tester.pumpAndSettle();
    expect(find.text(TextConstants.waitingInLine), findsOneWidget);
  });

  testWidgets(
      'OtpVerificationScreen renders illustration, boxes, timer, and navigates to LocationPermissionScreen',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: OtpVerificationScreen(phoneNumber: '+91 98765 43210'),
        ),
      ),
    );
    await tester.pump();

    // 1. Title and subtitle
    expect(find.text(TextConstants.verifyOtpTitle), findsOneWidget);
    expect(find.textContaining('+91 98765 43210'), findsOneWidget);

    // 2. 6 Digit TextFields
    expect(find.byType(TextField), findsNWidgets(6));

    // 3. Resend timer & actions
    expect(find.text(TextConstants.resendCodeIn), findsOneWidget);
    expect(find.text(TextConstants.verifyButton), findsOneWidget);
    expect(find.text(TextConstants.didntReceiveCode), findsOneWidget);

    // 4. Tap "Verify" navigates to LocationPermissionScreen
    await tester.tap(find.text(TextConstants.verifyButton));
    await tester.pumpAndSettle();
    expect(find.text(TextConstants.allowLocationTitle), findsOneWidget);
  });

  testWidgets(
      'LocationPermissionScreen renders map illustration, buttons, and navigates to HomeScreen',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: LocationPermissionScreen(),
        ),
      ),
    );
    await tester.pump();

    // 1. Title and Subtitle
    expect(find.text(TextConstants.allowLocationTitle), findsOneWidget);
    expect(find.text(TextConstants.allowLocationSubtitle), findsOneWidget);

    // 2. Action buttons
    expect(find.text(TextConstants.allowLocationButton), findsOneWidget);
    expect(find.text(TextConstants.notNowButton), findsOneWidget);

    // 3. Tap "Allow Location" navigates to HomeScreen
    await tester.tap(find.text(TextConstants.allowLocationButton));
    await tester.pumpAndSettle();
    expect(find.text(TextConstants.greetingEvening), findsOneWidget);
  });

  testWidgets(
      'SelectLocationScreen renders branding, current location, popular list, and selects new city',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: SelectLocationScreen(),
        ),
      ),
    );
    await tester.pump();

    // 1. FlowGuard Branding in AppBar
    expect(find.text(TextConstants.appName), findsOneWidget);

    // 2. Search bar
    expect(find.text(TextConstants.searchLocationHint), findsOneWidget);

    // 3. Current Location card
    expect(find.text(TextConstants.currentLocationTitle), findsOneWidget);
    expect(find.text(TextConstants.changeButton), findsOneWidget);

    // 4. Popular Locations list
    expect(find.text(TextConstants.popularLocationsTitle), findsOneWidget);
    expect(find.text(TextConstants.sampleLocationDehradun), findsOneWidget);
    expect(find.text(TextConstants.sampleLocationDelhi), findsOneWidget);
    expect(find.text(TextConstants.sampleLocationNoida), findsOneWidget);

    // 5. Select Location button
    expect(find.text(TextConstants.selectLocationButton), findsOneWidget);

    // 6. Tap "Delhi, DL" in popular locations list
    await tester.tap(find.text(TextConstants.sampleLocationDelhi));
    await tester.pump();

    // Verify "Delhi, DL" is now reflected in the Current Location card
    expect(find.text(TextConstants.sampleLocationDelhi), findsNWidgets(2));
  });

  testWidgets(
      'SelectServices -> BookAppointment -> AppointmentBooked flow works end-to-end',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: SelectServicesScreen(),
        ),
      ),
    );
    await tester.pump();

    // 1. Select Services Screen
    expect(find.text(TextConstants.selectServicesTitle), findsOneWidget);
    expect(find.text(TextConstants.selectServicesSubtitle), findsOneWidget);
    expect(find.text(TextConstants.serviceGeneralConsultation), findsOneWidget);
    expect(find.text(TextConstants.serviceDentalCheckup), findsOneWidget);

    // Tap "Continue (2 Selected)"
    await tester.tap(find.text('${TextConstants.continueButton} (2 Selected)'));
    await tester.pumpAndSettle();

    // 2. Book Appointment Screen
    expect(find.text(TextConstants.bookAppointmentTitle), findsOneWidget);
    expect(find.text(TextConstants.availableSlotsTitle), findsOneWidget);
    expect(find.text('Wed'), findsOneWidget);
    expect(find.text('10:00 AM'), findsOneWidget);

    // Tap "Continue"
    await tester.tap(find.text(TextConstants.continueButton));
    await tester.pumpAndSettle();

    // 3. Appointment Booked Screen
    expect(find.text(TextConstants.appointmentBookedTitle), findsOneWidget);
    expect(find.text(TextConstants.viewAppointmentButton), findsOneWidget);
  });

  testWidgets('ExploreScreen opens ExploreFilterSheet and displays options',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: Scaffold(body: ExploreScreen()),
        ),
      ),
    );
    await tester.pump();

    // Tap Filter Icon (tune)
    await tester.tap(find.byIcon(Icons.tune_rounded));
    await tester.pumpAndSettle();

    // Verify Filter Sheet opened
    expect(find.text(TextConstants.filtersTitle), findsOneWidget);
    expect(find.text(TextConstants.sortByTitle), findsOneWidget);
    expect(find.text(TextConstants.sortRecommended), findsOneWidget);
    expect(find.text(TextConstants.ratingsTitle), findsOneWidget);
    expect(find.text(TextConstants.rating45Plus), findsOneWidget);
    expect(find.text(TextConstants.clearButton), findsOneWidget);
    expect(find.text(TextConstants.applyButton), findsOneWidget);

    // Tap Apply
    await tester.tap(find.text(TextConstants.applyButton));
    await tester.pumpAndSettle();

    // Verify Sheet closed
    expect(find.text(TextConstants.filtersTitle), findsNothing);
  });

  testWidgets('SelectBranchScreen renders branches and navigates on continue',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: SelectBranchScreen(),
        ),
      ),
    );
    await tester.pump();

    // Verify title and subtitle
    expect(find.text(TextConstants.selectBranchTitle), findsOneWidget);
    expect(find.text(TextConstants.selectBranchSubtitle), findsOneWidget);

    // Verify branches
    expect(find.text(TextConstants.branchMainTitle), findsOneWidget);
    expect(find.text(TextConstants.branchCityCenterTitle), findsOneWidget);
    expect(find.text(TextConstants.branchPremiumTitle), findsOneWidget);

    // Tap City Center Branch
    await tester.tap(find.text(TextConstants.branchCityCenterTitle));
    await tester.pump();

    // Tap Continue
    await tester.tap(find.text(TextConstants.continueButton));
    await tester.pumpAndSettle();

    // Verify navigated to SelectServicesScreen
    expect(find.text(TextConstants.selectServicesTitle), findsOneWidget);
  });

  testWidgets('YourTurnScreen displays celebration, token badge and okay button',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: YourTurnScreen(tokenNumber: 'A-024'),
        ),
      ),
    );
    await tester.pump();

    expect(find.text(TextConstants.yourTurnTitle), findsOneWidget);
    expect(find.text(TextConstants.yourTurnSubtitle), findsOneWidget);
    expect(find.text('A-024'), findsOneWidget);
    expect(find.text(TextConstants.okayButton), findsOneWidget);
  });

  testWidgets('CancellationSuccessfulScreen renders confirmation and okay button',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: CancellationSuccessfulScreen(),
        ),
      ),
    );
    await tester.pump();

    expect(find.text(TextConstants.cancellationSuccessfulTitle), findsOneWidget);
    expect(find.text(TextConstants.cancellationSuccessfulSubtitle), findsOneWidget);
    expect(find.text(TextConstants.okayButton), findsOneWidget);
  });

  testWidgets('QueueFullScreen displays warning and go back button',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: QueueFullScreen(),
        ),
      ),
    );
    await tester.pump();

    expect(find.text(TextConstants.queueFullTitle), findsOneWidget);
    expect(find.text(TextConstants.queueFullSubtitle), findsOneWidget);
    expect(find.text(TextConstants.goBackButton), findsOneWidget);
  });

  testWidgets('FavoritesScreen displays tabs and businesses',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: FavoritesScreen(),
        ),
      ),
    );
    await tester.pump();

    expect(find.text(TextConstants.favoritesTitle), findsOneWidget);
    expect(find.text(TextConstants.tabBusinesses), findsOneWidget);
    expect(find.text(TextConstants.tabFavoritesServices), findsOneWidget);
    expect(find.text(TextConstants.sampleBusinessName), findsOneWidget);
    expect(find.text(TextConstants.sampleSalonName), findsOneWidget);
  });

  testWidgets('NoInternetScreen renders offline icon and try again button',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: NoInternetScreen(),
        ),
      ),
    );
    await tester.pump();

    expect(find.text(TextConstants.noInternetTitle), findsOneWidget);
    expect(find.text(TextConstants.noInternetSubtitle), findsOneWidget);
    expect(find.text(TextConstants.tryAgainButton), findsOneWidget);
  });

  testWidgets('EditProfileScreen renders editable fields and save button',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: EditProfileScreen(),
        ),
      ),
    );
    await tester.pump();

    expect(find.text(TextConstants.editProfileTitle), findsOneWidget);
    expect(find.text(TextConstants.changePhoto), findsOneWidget);
    expect(find.text(TextConstants.sampleUserName), findsOneWidget);
    expect(find.text(TextConstants.sampleUserEmail), findsOneWidget);
    expect(find.text(TextConstants.saveChangesButton), findsOneWidget);
  });

  testWidgets('SettingsScreen renders configuration tiles and logout button',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: SettingsScreen(),
        ),
      ),
    );
    await tester.pump();

    expect(find.text(TextConstants.settingsTitle), findsOneWidget);
    expect(find.text(TextConstants.settingAppearance), findsOneWidget);
    expect(find.text(TextConstants.settingLocation), findsOneWidget);
    expect(find.text(TextConstants.settingNotifications), findsOneWidget);
    expect(find.text(TextConstants.settingPrivacy), findsOneWidget);
    expect(find.text(TextConstants.settingHelpSupport), findsOneWidget);
    expect(find.text(TextConstants.settingAboutFlowguard), findsOneWidget);
    expect(find.text(TextConstants.logOutButton), findsOneWidget);
  });

  testWidgets('QueueInfoScreen renders queue info, token, wait time, and alert',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: QueueInfoScreen(),
        ),
      ),
    );
    await tester.pump();

    expect(find.text(TextConstants.queueInfoTitle), findsOneWidget);
    expect(find.text(TextConstants.tokenValueA024), findsOneWidget);
    expect(find.text('~ 12 min'), findsOneWidget);
    expect(find.text('3 People Ahead'), findsOneWidget);
    expect(find.text(TextConstants.cancelQueueAction), findsOneWidget);
  });

  testWidgets('AppointmentDetailsScreen renders confirmed hero card, info and action buttons',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: AppointmentDetailsScreen(),
        ),
      ),
    );
    await tester.pump();

    expect(find.text(TextConstants.appointmentDetailsTitle), findsOneWidget);
    expect(find.text(TextConstants.statusConfirmed), findsOneWidget);
    expect(find.text(TextConstants.dentalConsultationTitle), findsOneWidget);
    expect(find.text(TextConstants.appointmentDateSample), findsOneWidget);
    expect(find.text(TextConstants.appointmentTimeSample), findsOneWidget);
    expect(find.text(TextConstants.sampleBookingId), findsOneWidget);
    expect(find.text(TextConstants.rescheduleButton), findsOneWidget);
    expect(find.text(TextConstants.cancelAppointmentButton), findsOneWidget);
  });

  testWidgets('RescheduleAppointmentScreen renders dates, slots, and confirm action',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: RescheduleAppointmentScreen(),
        ),
      ),
    );
    await tester.pump();

    expect(find.text(TextConstants.rescheduleTitle), findsOneWidget);
    expect(find.text(TextConstants.selectDateTitle), findsOneWidget);
    expect(find.text('Wed'), findsOneWidget);
    expect(find.text(TextConstants.availableSlotsTitle), findsOneWidget);
    expect(find.text(TextConstants.confirmRescheduleButton), findsOneWidget);
  });

  testWidgets('CancelAppointmentScreen renders confirmation headline and inputs',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: CancelAppointmentScreen(),
        ),
      ),
    );
    await tester.pump();

    expect(find.text(TextConstants.cancelConfirmationHeadline), findsOneWidget);
    expect(find.text(TextConstants.cancellationReasonLabel), findsOneWidget);
    expect(find.text(TextConstants.goBackButton), findsOneWidget);
    expect(find.text(TextConstants.cancelAppointmentButton), findsNWidgets(2));
  });

  testWidgets('AppointmentCancelledScreen renders success badge, preview, and done button',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: AppointmentCancelledScreen(),
        ),
      ),
    );
    await tester.pump();

    expect(find.text(TextConstants.appointmentCancelledTitle), findsOneWidget);
    expect(find.text(TextConstants.appointmentCancelledSubtitle), findsOneWidget);
    expect(find.text(TextConstants.dentalConsultationTitle), findsOneWidget);
    expect(find.text(TextConstants.doneButton), findsOneWidget);
    expect(find.text(TextConstants.viewAppointmentsLink), findsOneWidget);
  });

  testWidgets('RateReviewScreen renders star rating, feedback input, and tags',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: RateReviewScreen(),
        ),
      ),
    );
    await tester.pump();

    expect(find.text(TextConstants.rateReviewTitle), findsOneWidget);
    expect(find.text(TextConstants.yourRatingTitle), findsOneWidget);
    expect(find.text('4 out of 5'), findsOneWidget);
    expect(find.text(TextConstants.yourReviewOptional), findsOneWidget);
    expect(find.text(TextConstants.whatDidYouLike), findsOneWidget);
    expect(find.text(TextConstants.chipCleanliness), findsOneWidget);
    expect(find.text(TextConstants.submitReviewButton), findsOneWidget);
  });

  testWidgets('HelpSupportScreen renders options and ticket creation button',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: HelpSupportScreen(),
        ),
      ),
    );
    await tester.pump();

    expect(find.text(TextConstants.helpSupportTitle), findsOneWidget);
    expect(find.text(TextConstants.howCanWeHelp), findsOneWidget);
    expect(find.text(TextConstants.faqTitle), findsOneWidget);
    expect(find.text(TextConstants.contactSupportTitle), findsOneWidget);
    expect(find.text(TextConstants.reportProblemTitle), findsOneWidget);
    expect(find.text(TextConstants.createSupportTicketButton), findsOneWidget);
  });

  testWidgets('CreateSupportTicketScreen renders category, priority, and submit button',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: CreateSupportTicketScreen(),
        ),
      ),
    );
    await tester.pump();

    expect(find.text(TextConstants.createSupportTicketTitle), findsOneWidget);
    expect(find.text(TextConstants.issueCategoryLabel), findsOneWidget);
    expect(find.text(TextConstants.priorityLabel), findsOneWidget);
    expect(find.text(TextConstants.descriptionLabel), findsOneWidget);
    expect(find.text(TextConstants.attachFilesOptional), findsOneWidget);
    expect(find.text(TextConstants.submitTicketButton), findsOneWidget);
  });

  testWidgets('TicketDetailsScreen renders ticket summary, chat messages, and send bar',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: TicketDetailsScreen(),
        ),
      ),
    );
    await tester.pump();

    expect(find.text(TextConstants.ticketDetailsTitle), findsOneWidget);
    expect(find.text(TextConstants.sampleTicketId), findsOneWidget);
    expect(find.text(TextConstants.statusInProgress), findsOneWidget);
    expect(find.text(TextConstants.issueTitle), findsOneWidget);
    expect(find.text(TextConstants.sampleUserMessage), findsOneWidget);
    expect(find.text(TextConstants.sampleAgentMessage), findsOneWidget);
    expect(find.text(TextConstants.addMessageHint), findsOneWidget);
  });
}
