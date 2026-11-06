import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../constant/color_constants.dart';
import '../../constant/text_constants.dart';
import '../home_screen/providers/home_nav_provider.dart';
import '../notifications_screen/notifications_screen.dart';
import 'widgets/profile_header.dart';
import 'widgets/profile_menu_item.dart';
import 'widgets/profile_user_card.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: ColorConstants.scaffoldBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Header
              const ProfileHeader(),

              // User Info Card
              const ProfileUserCard(),

              const SizedBox(height: 8),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  color: Color(0xFFF1F5F9),
                  thickness: 1.2,
                  height: 1,
                ),
              ),
              const SizedBox(height: 6),

              // Menu Items List
              ProfileMenuItem(
                icon: Icons.calendar_month_outlined,
                title: TextConstants.menuMyBookings,
                onTap: () {
                  // Switch to My Activity / Appointments tab
                  ref.read(homeNavProvider.notifier).selectTab(HomeNavTab.activity);
                },
              ),
              ProfileMenuItem(
                icon: Icons.sync_alt_rounded,
                title: TextConstants.menuMyQueueHistory,
                onTap: () {
                  _showFeatureToast(context, TextConstants.menuMyQueueHistory);
                  // TODO: Navigate to Queue History screen
                },
              ),
              ProfileMenuItem(
                icon: Icons.account_balance_wallet_outlined,
                title: TextConstants.menuWalletPayments,
                onTap: () {
                  _showFeatureToast(context, TextConstants.menuWalletPayments);
                  // TODO: Navigate to Wallet & Payment Methods screen
                },
              ),
              ProfileMenuItem(
                icon: Icons.location_on_outlined,
                title: TextConstants.menuAddresses,
                onTap: () {
                  _showFeatureToast(context, TextConstants.menuAddresses);
                  // TODO: Navigate to Saved Addresses screen
                },
              ),
              ProfileMenuItem(
                icon: Icons.notifications_none_outlined,
                title: TextConstants.menuNotifications,
                onTap: () {
                  // Open Notifications Screen
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const NotificationsScreen(),
                    ),
                  );
                },
              ),
              ProfileMenuItem(
                icon: Icons.help_outline_rounded,
                title: TextConstants.menuHelpSupport,
                onTap: () {
                  _showFeatureToast(context, TextConstants.menuHelpSupport);
                  // TODO: Open Help Center & Live Chat Support
                },
              ),
              ProfileMenuItem(
                icon: Icons.info_outline_rounded,
                title: TextConstants.menuAboutFlowguard,
                onTap: () {
                  showAboutDialog(
                    context: context,
                    applicationName: TextConstants.appTitle,
                    applicationVersion: '1.0.0',
                    applicationLegalese: '© 2026 FlowGuard Inc. All rights reserved.',
                  );
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  void _showFeatureToast(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature feature coming soon!'),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 1),
      ),
    );
  }
}

