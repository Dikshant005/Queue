import 'package:flutter/material.dart';
import '../../../constant/color_constants.dart';
import '../../../constant/text_constants.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            TextConstants.profileTitle,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: ColorConstants.textHeadline,
              letterSpacing: -0.5,
            ),
          ),
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Settings coming soon!'),
                  behavior: SnackBarBehavior.floating,
                  duration: Duration(seconds: 1),
                ),
              );
              // TODO: Navigate to Settings & Preferences Screen
            },
            icon: const Icon(
              Icons.settings_outlined,
              color: ColorConstants.textHeadline,
              size: 24,
            ),
            splashRadius: 22,
          ),
        ],
      ),
    );
  }
}

